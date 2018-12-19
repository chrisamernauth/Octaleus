//
//  DeviceManager.h
//  Octaleus
//
//  Created by Rahul Soni on 02/03/16.
//  Copyright (c) 2016 Rahul Soni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeviceInfo.h"
#import "OCRequest.h"
#import <MapKit/MapKit.h>

typedef void(^DeviceBlock)(BOOL success,id data,NSError *error);
typedef void(^ADDeviceBlock)(BOOL success,NSError *error);
typedef void(^DeviceAddressBlock)(BOOL success,id data,NSError *error);
typedef void(^DeviceActivatedBlock)(BOOL success,id data,NSError *error);
typedef void(^DeviceSuccessfullyAddedToLocalBlock)(BOOL success,NSError *error);
@interface DeviceManager : NSObject<OCRequestDelegate>
{
    DeviceBlock savedblock;
    DeviceActivatedBlock activateBlock;
    ADDeviceBlock addDeviceblock;
    DeviceAddressBlock devAddressBlock;
    DeviceSuccessfullyAddedToLocalBlock deviceSavedblock;
}
@property(nonatomic,strong)NSMutableArray *deviceArr;

+(DeviceManager *)sharedInstance;
+(DeviceManager *)clearInstance;
-(DeviceInfo *)getDeviceInfo;
-(void)loginWithEmail:(NSString *)email andPassword:(NSString *)password andBlock:(DeviceBlock)block;
-(void)getDeviceInfoWithSavedBlock:(NSInteger)deviceid and:(DeviceBlock)block;
-(void)checkIfDevicesActivated:(NSString *)serialId andblock:(DeviceActivatedBlock)block;
-(void)addDeviceWithSerialId:(NSString *)serialId andName:(NSString *)name andBlock:(ADDeviceBlock)block;
-(void)getDeviceInfoDetailWithSavedBlock:(NSInteger)deviceid and:(DeviceBlock)block;
-(void)saveDevice:(NSDictionary *)data andBlock:(DeviceSuccessfullyAddedToLocalBlock)block;
-(void)getAddressFromCombain:(CLLocationCoordinate2D)coord and:(DeviceAddressBlock)block;
@end

