//  Octaleus
//
//  Created by Rahul Soni on 07/01/16.
//  Copyright (c) 2016 Rahul Soni. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@class CBCharacteristic;
@class CBService;
@class CBPeripheral;
@class LGCharacteristic;

typedef void(^LGServiceDiscoverCharacterisitcsCallback)(NSArray *characteristics, NSError *error);

@interface LGService : NSObject

/**
 * Core Bluetooth's CBService instance
 */
@property (strong, nonatomic, readonly) CBService *cbService;

/**
 * Core Bluetooth's CBPeripheral instance, which this instance belongs
 */
@property (weak, nonatomic, readonly) CBPeripheral *cbPeripheral;

/**
 * NSString representation of 16/128 bit CBUUID
 */
@property (weak, nonatomic, readonly) NSString *UUIDString;

/**
 * Flag to indicate discovering characteristics or not
 */
@property (assign, nonatomic, readonly, getter = isDiscoveringCharacteristics) BOOL discoveringCharacteristics;

/**
 * Available characteristics for this service, 
 * will be updated after discoverCharacteristicsWithCompletion: call
 */
@property (strong, nonatomic) NSArray *characteristics;

/**
 * Discoveres All characteristics of this service
 * @param aCallback Will be called after successfull/failure ble-operation
 */
- (void)discoverCharacteristicsWithCompletion:(LGServiceDiscoverCharacterisitcsCallback)aCallback;


/**
 * Discoveres Input characteristics of this service
 * @param uuids Array of CBUUID's that contain characteristic UUIDs which
 * we need to discover
 * @param aCallback Will be called after successfull/failure ble-operation
 */
- (void)discoverCharacteristicsWithUUIDs:(NSArray *)uuids
                              completion:(LGServiceDiscoverCharacterisitcsCallback)aCallback;


// ----- Used for input events -----/

- (void)handleDiscoveredCharacteristics:(NSArray *)aCharacteristics error:(NSError *)aError;

- (LGCharacteristic *)wrapperByCharacteristic:(CBCharacteristic *)aChar;

/**
 * @return Wrapper object over Core Bluetooth's CBService
 */
- (instancetype)initWithService:(CBService *)aService;

@end
