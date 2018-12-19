//  Octaleus
//
//  Created by Rahul Soni on 07/01/16.
//  Copyright (c) 2016 Rahul Soni. All rights reserved.
//
#import "LGService.h"

#import "CBUUID+StringExtraction.h"
#if TARGET_OS_IPHONE
#import <CoreBluetooth/CoreBluetooth.h>
#elif TARGET_OS_MAC
#import <IOBluetooth/IOBluetooth.h>
#endif
#import "LGCharacteristic.h"
#import "LGUtils.h"

@interface LGService ()

@property (copy, nonatomic) LGServiceDiscoverCharacterisitcsCallback discoverCharBlock;

@end

@implementation LGService

/*----------------------------------------------------*/
#pragma mark - Getter/Setter -
/*----------------------------------------------------*/

- (NSString *)UUIDString
{
    return [self.cbService.UUID representativeString];
}

/*----------------------------------------------------*/
#pragma mark - Public Methods -
/*----------------------------------------------------*/

- (void)discoverCharacteristicsWithCompletion:(LGServiceDiscoverCharacterisitcsCallback)aCallback
{
    [self discoverCharacteristicsWithUUIDs:nil
                                completion:aCallback];
}

- (void)discoverCharacteristicsWithUUIDs:(NSArray *)uuids
                              completion:(LGServiceDiscoverCharacterisitcsCallback)aCallback
{
    self.discoverCharBlock = aCallback;
    _discoveringCharacteristics = YES;
    [self.cbService.peripheral discoverCharacteristics:uuids
                                            forService:self.cbService];
}

- (LGCharacteristic *)wrapperByCharacteristic:(CBCharacteristic *)aChar
{
    LGCharacteristic *wrapper = nil;
    for (LGCharacteristic *discovered in self.characteristics) {
        if (discovered.cbCharacteristic == aChar) {
            wrapper = discovered;
            break;
        }
    }
    return wrapper;
}

/*----------------------------------------------------*/
#pragma mark - Private Methods -
/*----------------------------------------------------*/

- (void)updateCharacteristicWrappers
{
    NSMutableArray *updatedCharacteristics = [NSMutableArray new];
    for (CBCharacteristic *characteristic in self.cbService.characteristics) {
        [updatedCharacteristics addObject:[[LGCharacteristic alloc] initWithCharacteristic:characteristic]];
    }
    _characteristics = updatedCharacteristics;
}


/*----------------------------------------------------*/
#pragma mark - Handler Methods -
/*----------------------------------------------------*/

- (void)handleDiscoveredCharacteristics:(NSArray *)aCharacteristics error:(NSError *)aError
{
    _discoveringCharacteristics = NO;
    [self updateCharacteristicWrappers];
#if LG_ENABLE_BLE_LOGGING != 0
    for (LGCharacteristic *aChar in self.characteristics) {
        LGLog(@"Characteristic discovered - %@", aChar.cbCharacteristic.UUID);
    }
#endif
    if (self.discoverCharBlock) {
        self.discoverCharBlock(self.characteristics, aError);
    }
    self.discoverCharBlock = nil;
}

/*----------------------------------------------------*/
#pragma mark - Lifecycle -
/*----------------------------------------------------*/

- (instancetype)initWithService:(CBService *)aService
{
    if (self = [super init]) {
        _cbService = aService;
    }
    return self;
}

@end
