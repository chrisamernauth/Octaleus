//
//  ServiceList.m
//  PallySmartFinder
//
//  Created by Rahul Soni on 14/10/15.
//  Copyright (c) 2015 Rahul Soni. All rights reserved.
//

#import "ServiceList.h"

static ServiceList *singleton = nil;
@implementation ServiceList
@synthesize delegate = _delegate;

+(ServiceList *)Instance{
    if (singleton == nil) {
        singleton = [[ServiceList alloc]init];
    }
    return singleton;
}

+(ServiceList *)clearInstance{
    return singleton = nil;
}

-(void)updateLocation:(CommonInfo *)cInfo withDelegate:(id<ModelListLoadedDelegate>)del{
    _delegate = del;
    NSString *urlpart = [NSString stringWithFormat:@"resource/%@/locate",cInfo.trackerId];
    OCRequest *request = [[OCRequest alloc]initWithUrlPart:urlpart andDelegate:self andMethod:POST];
   // [request setParameter:cInfo.trackerId forKey:@"trackerId"];
    [request setParameter:[NSNumber numberWithFloat:cInfo.latitude] forKey:@"lat"];
    [request setParameter:[NSNumber numberWithFloat:cInfo.longitude] forKey:@"lng"];
    [request setParameter:cInfo.batteryLevel forKey:@"batteryLevel"];
    request.Tag = REGISTRATION;
    [request startRequest];
}

#pragma mark -OCRequestDelegate
-(void)OCRequestDidSucceed:(OCRequest *)request{
    if (request.IsSuccess) {
        if (_delegate && [_delegate respondsToSelector:@selector(ModelListLoadedSuccessfullyRequstTag:)]){
            [_delegate ModelListLoadedSuccessfullyRequstTag:request.Tag];
        }
    }
}

-(void)OCRequestDidFail:(OCRequest *)request withError:(NSError *)error{
    NSString *alert_error = [error.userInfo objectForKey:@"message"];
    if (_delegate && [_delegate respondsToSelector:@selector(ModelListLoadFailWithError:)]){
        [_delegate ModelListLoadFailWithError:alert_error];
    }
}



@end
