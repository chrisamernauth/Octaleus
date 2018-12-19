//
//  KitLocateTasker.m
//  Periodic-Example-iPhone
//
//  Created by KitLocate on 06/03/13.
//  Copyright (c) 2013 KitLocate. All rights reserved.
//
//  The class which implements the CallBack functions of KitLocate
//

#import "KitLocateTasker.h"
#import <KitLocate/KitLocate.h>
#import "DataUtility.h"
#import "BLEDevice.h"
#import "Constant.h"

static KitLocateTasker *sharedObject=nil;
@implementation KitLocateTasker
@synthesize currentCordinates = _currentCordinates;
//32bbef70-6972-483e-b39c-ef7309d16e49
+ (id)Instance
{
    
    if (sharedObject==nil)
    {
        sharedObject = [[super alloc] init];
        [KitLocate initKitLocateWithDelegate:sharedObject APIKey:API_KEY_KIT_LOCATE];
        [KitLocate registerForLocalNotifications];
    }
    
    return sharedObject;
}
-(void)initWithKitDelegate:(id<PeriodicLocationUpdater>)del{
    _delegate = del;
}

// This delegate method will fired each time we got a location
-(void)gotPeriodicLocation:(KLLocationValue *)location
{
    // EXAMPLE - we will give local push notification (Application must be in background to get the notification)
    CLLocationCoordinate2D cord = CLLocationCoordinate2DMake([location fLatitude], [location fLongitude]);
    _currentCordinates = cord;
    NSString *strText = [NSString stringWithFormat:@"Location Lat: %f Lon: %f Acc: %f",[location fLatitude], [location fLongitude], [location fAccuracy]];
       NSLog(@"Location : %@", strText );
    if (_delegate && [_delegate respondsToSelector:@selector(updatePeriodicLocation:)]) {
        [_delegate updatePeriodicLocation:cord];
    }
}

- (CLLocationCoordinate2D)getCurrentCordinates {
    return _currentCordinates;
}
// This method is invoked after initKitLocate is finished successfully
-(void)didSuccessInitKitLocate:(int)status
{
    [KLLocation registerPeriodicLocation];
    if ([DataUtility getTimeIntervalForKey]!=nil) {
        float  timeInterval = [DataUtility getTimeIntervalForKey].floatValue;
        [KLLocation setPeriodicMinimumTimeInterval:timeInterval];
    }else{
        [KLLocation setPeriodicMinimumTimeInterval:60];
    }
    
    NSLog(@"didSuccessInitKitLocate - status: %d",status);
}

-(void)setPeriodicTimeInterval:(int)period{
    
    [KLLocation setPeriodicMinimumTimeInterval:period];
}

// This method is invoked if initKitLocate fails
-(void)didFailInitKitLocate:(int)error
{
    NSLog(@"didFailInitKitLocate - error: %d",error);
}

@end
