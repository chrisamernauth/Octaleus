//
//  DeviceManager.m
//  Octaleus
//
//  Created by Rahul Soni on 02/03/16.
//  Copyright (c) 2016 Rahul Soni. All rights reserved.
//

#import "DeviceManager.h"
#import "TrackerAccount.h"
#import "TrackerDevice.h"
#import <MagicalRecord/MagicalRecord.h>
#import "URLSchemea.h"
static DeviceManager *singleton = nil;
@implementation DeviceManager

+(DeviceManager *)sharedInstance{
    if (singleton == nil) {
        singleton = [[DeviceManager alloc]init];
        singleton.deviceArr = [[NSMutableArray alloc]init];
    }
    return singleton;
}

+(DeviceManager *)clearInstance{
    return singleton = nil;
}

-(DeviceInfo *)getDeviceInfo{
    return [_deviceArr objectAtIndex:0];
}

-(void)loginWithEmail:(NSString *)email andPassword:(NSString *)password andBlock:(DeviceBlock)block{
    savedblock = block;
    OCRequest *request = [[OCRequest alloc]initWithUrlPart:LOGIN_ITRAQ andDelegate:self andMethod:POST];
    //    NSDictionary *dict = @{@"email":email,@"password":password,@"api_key":API_KEY};
    //    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
    //                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
    //                                                         error:nil];
    //    NSString *json = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    [request setParameter:email forKey:@"email"];
    [request setParameter:password forKey:@"password"];
    [request setParameter:API_KEY forKey:@"apiKey"];
    request.Tag = BASE_URL_ITRAQ;
    [request startRequest];
}

-(void)getDeviceInfoWithSavedBlock:(NSInteger)deviceid and:(DeviceBlock)block{
    savedblock = block;
    NSString *device_id = [NSString stringWithFormat:@"%ld",(long)deviceid];
    NSString *url_part = [NSString stringWithFormat:DEVICES,device_id];
    OCRequest *request = [[OCRequest alloc]initWithUrl:url_part andDelegate:self];
    request.Tag = DEVICES;
    [request startRequest];
}

-(void)getDeviceInfoDetailWithSavedBlock:(NSInteger)deviceid and:(DeviceBlock)block{
    savedblock = block;
    NSString *device_id = [NSString stringWithFormat:@"%ld",(long)deviceid];
    NSString *url_part = [NSString stringWithFormat:DEVICES,device_id];
    OCRequest *request = [[OCRequest alloc]initWithUrl:url_part andDelegate:self];
    request.Tag = @"DeviceTag";
    [request startRequest];
}

-(void)checkIfDevicesActivated:(NSString *)serialId andblock:(DeviceActivatedBlock)block{
    activateBlock = block;
    NSString *url_part = [NSString stringWithFormat:DEVICES_ACTIVATED,serialId];
    OCRequest *request = [[OCRequest alloc]initWithUrl:url_part andDelegate:self];
    request.Tag = DEVICES_ACTIVATED;
    [request startRequest];
}

-(void)getAddressFromCombain:(CLLocationCoordinate2D)coord and:(DeviceAddressBlock)block{
    devAddressBlock = block;
    NSString *urlpart = @"https://cps.combain.com/?key=nxewycpovtusmhauyw8e";
    OCRequest *request = [[OCRequest alloc] initWithUrlPart:urlpart andDelegate:self andMethod:POST];
    NSDictionary *dictparameters = @{ @"latitude": [NSNumber numberWithFloat:coord.latitude], @"longitude": [NSNumber numberWithFloat:coord.longitude], @"accuracy": @10, @"age": @"" };
    [request setParameter:dictparameters forKey:@"gps"];
    [request setParameter:@1 forKey:@"address"];
    request.Tag = COMBAIN;
    [request startRequest];
}
-(void)addDeviceWithSerialId:(NSString *)serialId andName:(NSString *)name andBlock:(ADDeviceBlock)block{
    addDeviceblock = block;
    OCRequest *request = [[OCRequest alloc]initWithUrlPart:ADD_DEVICES andDelegate:self andMethod:POST];
    [request setParameter:serialId forKey:@"serialId"];
    [request setParameter:name forKey:@"name"];
    request.Tag = ADD_DEVICES;
    [request startRequest];
}

-(void)saveDevice:(NSDictionary *)data andBlock:(DeviceSuccessfullyAddedToLocalBlock)block{
    deviceSavedblock = block;
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        TrackerDevice *device = [FEMDeserializer objectFromRepresentation:data mapping:[TrackerDevice defaultMapping] context:localContext];
        if (deviceSavedblock) {
            deviceSavedblock(true,nil);
        }
    }];
}


#pragma mark -OCRequestDelegate
-(void)OCRequestDidSucceed:(OCRequest *)request{
    if (request.IsSuccess) {
        NSDictionary *dict = [request.responseData objectForKey:@"data"];
        if ([request.Tag isEqual:BASE_URL_ITRAQ]) {
            NSDictionary *datadict = request.responseData;
            [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
                [TrackerAccount MR_truncateAllInContext:localContext];
                TrackerAccount *account = [FEMDeserializer objectFromRepresentation:datadict mapping:[TrackerAccount defaultMapping] context:localContext];
                [account setAuth_token:[request.httpHeaderField objectForKey:@"X-AUTH-TOKEN"]];
                [account saveAccountOnLocal];
                if (savedblock) {
                    NSError *error;
                    savedblock(true,error,nil);
                }
            }];
            
        }else if ([request.Tag isEqual:DEVICES]){
            _deviceArr = [[NSMutableArray alloc]init];
            
            DeviceInfo *info = [DeviceInfo parseWithDict:dict];
            [_deviceArr addObject:info];
            if (savedblock) {
                NSError *error;
                savedblock(true,error,nil);
            }
        }else if ([request.Tag isEqual:@"DeviceTag"]){
            if (savedblock) {
                savedblock(true,dict,nil);
            }
        }
        else if ([request.Tag isEqual:DEVICES_ACTIVATED]){
            int status = [[request.responseData objectForKey:@"status"] intValue];
            if ([request.responseData objectForKey:@"data"] == [NSNull null] && status >0) {
                if (activateBlock) {
                    
                    activateBlock(false,nil,nil);
                }
            }else{
                if (activateBlock) {
                    
                    activateBlock(true,dict,nil);
                }
            }
            return;
        }else if ([request.Tag isEqual:ADD_DEVICES]){
            int status = [[request.responseData objectForKey:@"status"] intValue];
            if (status == 0) {
                if (addDeviceblock) {
                    addDeviceblock(true,nil);
                }
            }else{
                if (addDeviceblock) {
                    addDeviceblock(false,nil);
                }
            }
            return;
        }else if ([request.Tag isEqual:COMBAIN]){
            if ([request.responseData objectForKey:@"address"] != [NSNull null]){
                NSDictionary *addressdict = [request.responseData objectForKey:@"address"];
                NSMutableArray *arr = [NSMutableArray new];
                if ([addressdict objectForKey:@"road"] != [NSNull null] && [addressdict objectForKey:@"road"] != nil){
                    NSString *road = [addressdict objectForKey:@"road"];
                    [arr addObject:road];
                }
                if ([addressdict objectForKey:@"hamlet"] != [NSNull null] && [addressdict objectForKey:@"hamlet"] != nil){
                    NSString *hamlet = [addressdict objectForKey:@"hamlet"];
                    [arr addObject:hamlet];
                }
                if ([addressdict objectForKey:@"county"] != [NSNull null]  && [addressdict objectForKey:@"county"] != nil){
                    NSString *county = [addressdict objectForKey:@"county"];
                    [arr addObject:county];
                }
                if ([addressdict objectForKey:@"state"] != [NSNull null] && [addressdict objectForKey:@"state"] != nil){
                    NSString *state = [addressdict objectForKey:@"state"];
                    [arr addObject:state];
                }
                if ([addressdict objectForKey:@"country"] != [NSNull null]  && [addressdict objectForKey:@"country"] != nil){
                    NSString *country = [addressdict objectForKey:@"country"];
                    [arr addObject:country];
                }
                if (devAddressBlock){
                    devAddressBlock(true,arr,nil);
                }
            }else{
                if (devAddressBlock){
                    devAddressBlock(false,nil,nil);
                }
            }
        }
        
    }
}

-(void)OCRequestDidFail:(OCRequest *)request withError:(NSError *)error{
    if ([request.Tag isEqual:COMBAIN]){
        if (devAddressBlock){
            devAddressBlock(false,nil,error);
        }
    }else{
        if (savedblock) {
            NSError *error;
            savedblock(false,nil,error);
        }
    }
}

@end

