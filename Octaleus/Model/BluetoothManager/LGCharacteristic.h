//  Octaleus
//
//  Created by Rahul Soni on 07/01/16.
//  Copyright (c) 2016 Rahul Soni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@class CBCharacteristic;

@interface LGCharacteristic : NSObject

typedef void (^LGCharacteristicReadCallback)  (NSData *data, NSError *error);
typedef void (^LGCharacteristicNotifyCallback)(NSError *error);
typedef void (^LGCharacteristicWriteCallback) (NSError *error);

/**
 * Core Bluetooth's CBCharacteristic instance
 */
@property (strong, nonatomic, readonly) CBCharacteristic *cbCharacteristic;

/**
 * NSString representation of 16/128 bit CBUUID
 */
@property (weak, nonatomic, readonly) NSString *UUIDString;

/**
 * Enables or disables notifications/indications for the characteristic 
 * value of characteristic.
 * @param notifyValue Enable/Disable notifications
 * @param aCallback Will be called after successfull/failure ble-operation
 */
- (void)setNotifyValue:(BOOL)notifyValue
            completion:(LGCharacteristicNotifyCallback)aCallback;

/**
 * Enables or disables notifications/indications for the characteristic
 * value of characteristic.
 * @param notifyValue Enable/Disable notifications
 * @param aCallback Will be called after successfull/failure ble-operation
 * @param uCallback Will be called after every new successful update
 */
- (void)setNotifyValue:(BOOL)notifyValue
            completion:(LGCharacteristicNotifyCallback)aCallback
              onUpdate:(LGCharacteristicReadCallback)uCallback;

/**
 * Writes input data to characteristic
 * @param data NSData object representing bytes that needs to be written
 * @param aCallback Will be called after successfull/failure ble-operation
 */
- (void)writeValue:(NSData *)data
        completion:(LGCharacteristicWriteCallback)aCallback;

/**
 * Writes input byte to characteristic
 * @param aByte byte that needs to be written
 * @param aCallback Will be called after successfull/failure ble-operation
 */
- (void)writeByte:(int8_t)aByte
       completion:(LGCharacteristicWriteCallback)aCallback;

/**
 * Reads characteristic value
 * @param aCallback Will be called after successfull/failure 
 * ble-operation with response
 */
- (void)readValueWithBlock:(LGCharacteristicReadCallback)aCallback;


// ----- Used for input events -----/

- (void)handleSetNotifiedWithError:(NSError *)anError;

- (void)handleReadValue:(NSData *)aValue error:(NSError *)anError;

- (void)handleWrittenValueWithError:(NSError *)anError;


/**
 * @return Wrapper object over Core Bluetooth's CBCharacteristic
 */
- (instancetype)initWithCharacteristic:(CBCharacteristic *)aCharacteristic;

@end
