//  Octaleus
//
//  Created by Rahul Soni on 07/01/16.
//  Copyright (c) 2016 Rahul Soni. All rights reserved.
//

#import "LGCharacteristic.h"

#import "CBUUID+StringExtraction.h"
#if TARGET_OS_IPHONE
#import <CoreBluetooth/CoreBluetooth.h>
#elif TARGET_OS_MAC
#import <IOBluetooth/IOBluetooth.h>
#endif
#import "LGUtils.h"

@interface LGCharacteristic ()

@property (strong, nonatomic) NSMutableArray *notifyOperationStack;

@property (strong, nonatomic) NSMutableArray *readOperationStack;

@property (strong, nonatomic) NSMutableArray *writeOperationStack;

@property (strong, nonatomic) LGCharacteristicReadCallback updateCallback;

@end

@implementation LGCharacteristic

/*----------------------------------------------------*/
#pragma mark - Getter/Setter -
/*----------------------------------------------------*/

- (NSMutableArray *)notifyOperationStack
{
    if (!_notifyOperationStack) {
        _notifyOperationStack = [NSMutableArray new];
    }
    return _notifyOperationStack;
}

- (NSMutableArray *)readOperationStack
{
    if (!_readOperationStack) {
        _readOperationStack = [NSMutableArray new];
    }
    return _readOperationStack;
}

- (NSMutableArray *)writeOperationStack
{
    if (!_writeOperationStack) {
        _writeOperationStack = [NSMutableArray new];
    }
    return _writeOperationStack;
}

- (NSString *)UUIDString
{
    return [self.cbCharacteristic.UUID representativeString];
}

/*----------------------------------------------------*/
#pragma mark - Public Methods -
/*----------------------------------------------------*/

- (void)setNotifyValue:(BOOL)notifyValue
            completion:(LGCharacteristicNotifyCallback)aCallback
{
    [self setNotifyValue:notifyValue completion:aCallback onUpdate:nil];
}

- (void)setNotifyValue:(BOOL)notifyValue
            completion:(LGCharacteristicNotifyCallback)aCallback
              onUpdate:(LGCharacteristicReadCallback)uCallback
{
    if (!aCallback) {
        aCallback = ^(NSError *error){};
    }
    
    self.updateCallback = uCallback;
    
    [self push:aCallback toArray:self.notifyOperationStack];
    
    [self.cbCharacteristic.service.peripheral setNotifyValue:notifyValue
                                           forCharacteristic:self.cbCharacteristic];
}

- (void)writeValue:(NSData *)data
        completion:(LGCharacteristicWriteCallback)aCallback
{
    CBCharacteristicWriteType type =  aCallback ?
    CBCharacteristicWriteWithResponse : CBCharacteristicWriteWithoutResponse;
    
    if (aCallback) {
        [self push:aCallback toArray:self.writeOperationStack];
    }
    [self.cbCharacteristic.service.peripheral writeValue:data
                                       forCharacteristic:self.cbCharacteristic
                                                    type:type];
}

- (void)writeByte:(int8_t)aByte
       completion:(LGCharacteristicWriteCallback)aCallback
{
    [self writeValue:[NSData dataWithBytes:&aByte length:1] completion:aCallback];
}

- (void)readValueWithBlock:(LGCharacteristicReadCallback)aCallback
{
    // No need to read ;)
    if (!aCallback) {
        return;
    }
    [self push:aCallback toArray:self.readOperationStack];
    [self.cbCharacteristic.service.peripheral readValueForCharacteristic:self.cbCharacteristic];
}

/*----------------------------------------------------*/
#pragma mark - Private Methods -
/*----------------------------------------------------*/

- (void)push:(id)anObject toArray:(NSMutableArray *)aArray
{
    [aArray addObject:anObject];
}

- (id)popFromArray:(NSMutableArray *)aArray
{
    id aObject = nil;
    if ([aArray count] > 0) {
        aObject = [aArray objectAtIndex:0];
        [aArray removeObjectAtIndex:0];
    }
    return aObject;
}

/*----------------------------------------------------*/
#pragma mark - Handler Methods -
/*----------------------------------------------------*/

- (void)handleSetNotifiedWithError:(NSError *)anError
{
    LGLog(@"Characteristic - %@ notify changed with error - %@", self.cbCharacteristic.UUID, anError);
    LGCharacteristicNotifyCallback callback = [self popFromArray:self.notifyOperationStack];
    if (callback) {
        callback(anError);
    }
}

- (void)handleReadValue:(NSData *)aValue error:(NSError *)anError
{
    LGLog(@"Characteristic - %@ value - %s error - %@",
          self.cbCharacteristic.UUID, [aValue bytes], anError);
    
    if (self.updateCallback) {
        self.updateCallback(aValue, anError);
    }
    
    LGCharacteristicReadCallback callback = [self popFromArray:self.readOperationStack];
    if (callback) {
        callback(aValue, anError);
    }
}

- (void)handleWrittenValueWithError:(NSError *)anError
{
    LGLog(@"Characteristic - %@ wrote with error - %@", self.cbCharacteristic.UUID, anError);
    LGCharacteristicWriteCallback callback = [self popFromArray:self.writeOperationStack];
    if (callback) {
        callback(anError);
    }
}

/*----------------------------------------------------*/
#pragma mark - Lifecycle -
/*----------------------------------------------------*/

- (instancetype)initWithCharacteristic:(CBCharacteristic *)aCharacteristic
{
    if (self = [super init]) {
        _cbCharacteristic = aCharacteristic;
    }
    return self;
}

@end
