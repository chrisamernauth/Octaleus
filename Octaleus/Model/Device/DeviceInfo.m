//
//  DeviceInfo.m
//  Octaleus
//
//  Created by Rahul Soni on 02/03/16.
//  Copyright (c) 2016 Rahul Soni. All rights reserved.
//

#import "DeviceInfo.h"

@implementation DeviceInfo

+(DeviceInfo *)parseWithDict:(NSDictionary *)dict{
    DeviceInfo *info = [[DeviceInfo alloc]init];
    if ([dict objectForKey:@"id"]) {
        info.device_id = [[dict objectForKey:@"id"] intValue];
    }
    if ([dict objectForKey:@"name"]) {
        info.name = [dict objectForKey:@"name"];
    }
    if ([dict objectForKey:@"serialId"]) {
        info.serial_id = [dict objectForKey:@"serialId"];
    }
    if ([dict objectForKey:@"imei"]) {
        info.imei = [dict objectForKey:@"imei"];
    }
    if ([dict objectForKey:@"panicMode"]) {
        info.panicMode = [[dict objectForKey:@"panicMode"] boolValue];
    }
    if ([dict objectForKey:@"activationStatus"]) {
        info.activationStatus = [dict objectForKey:@"activationStatus"];
    }
    if ([dict objectForKey:@"shareCount"]) {
        info.shareCount = [[dict objectForKey:@"shareCount"] intValue];
    }
    if ([dict objectForKey:@"schedule"]) {
        info.schedule = [dict objectForKey:@"schedule"];
    }
    if ([dict objectForKey:@"schedulePending"]) {
        info.schedulePending = [[dict objectForKey:@"schedulePending"] boolValue];
    }
    if ([dict objectForKey:@"batteryCharge"]) {
        info.batteryCharge = [[dict objectForKey:@"batteryCharge"] floatValue];
    }
    if ([dict objectForKey:@"firmwareVersion"]) {
        info.firmwareVersion = [[dict objectForKey:@"firmwareVersion"]intValue];
    }
    if ([dict objectForKey:@"simNumber"]) {
        info.simNumber = [dict objectForKey:@"simNumber"];
    }
    if ([dict objectForKey:@"communicationProtocol"]) {
        info.communicationProtocol = [dict objectForKey:@"communicationProtocol"];
    }
    if ([dict objectForKey:@"reports"]) {
        info.reports = [dict objectForKey:@"reports"];
    }
    if ([dict objectForKey:@"nextWakeUpSeconds"]) {
        info.nextWakeUpSeconds = [dict objectForKey:@"nextWakeUpSeconds"];
    }
    if ([dict objectForKey:@"isOwn"]) {
        info.isOwn = [dict objectForKey:@"isOwn"];
    }
    if ([dict objectForKey:@"reportsExpirationDate"]) {
        info.reportsExpirationDate = [dict objectForKey:@"reportsExpirationDate"];
    }
    
    if ([dict objectForKey:@"lastLocation"]){
        NSDictionary *subdict = [dict objectForKey:@"lastLocation"];
        if([subdict objectForKey:@"latitude"]){
            info.latitude = [[subdict objectForKey:@"latitude"] doubleValue];
        }
        if([subdict objectForKey:@"longitude"]){
             info.longitude = [[subdict objectForKey:@"longitude"] doubleValue];
        }
    }
    
    return info;
}

@end
