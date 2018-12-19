//  Octaleus
//
//  Created by Rahul Soni on 07/01/16.
//  Copyright (c) 2016 Rahul Soni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@class CBPeripheral;
@class LGCentralManager;

#pragma mark - Notification identifiers -

/**
 * NSNotification which will be triggered by this identifier when
 * Peripheral will be connected
 */
extern NSString * const kLGPeripheralDidConnect;

/**
 * NSNotification which will be triggered by this identifier when
 * a connected peripheral will be disconnected from us.
 * NOTE : Notification will be posted only if there is no an active handler (disconnect completion)
 *
 * e.g. after calling disconnectWithCompletion: and giving complition
 * will NOT post `kLGPeripheralDidDisconnect` notification
 */
extern NSString * const kLGPeripheralDidDisconnect;

#pragma mark - Error Domains -

/**
 * Error domains for Connection errors
 */
extern NSString * const kLGPeripheralConnectionErrorDomain;

#pragma mark - Error Codes -
/**
 * Connection timeout error code
 */
extern const NSInteger kConnectionTimeoutErrorCode;

/**
 * Connection missing error code
 */
extern const NSInteger kConnectionMissingErrorCode;

#pragma mark - Error Messages -

/**
 * Error message for connection timeouts
 */
extern NSString * const kConnectionTimeoutErrorMessage;

/**
 * Error message for missing connections
 */
extern NSString * const kConnectionMissingErrorMessage;


#pragma mark - Callback types -

typedef void(^LGPeripheralConnectionCallback)(NSError *error);
typedef void(^LGPeripheralDiscoverServicesCallback)(NSArray *services, NSError *error);
typedef void(^LGPeripheralRSSIValueCallback)(NSNumber *RSSI, NSError *error);

#pragma mark - Public Interface -

@interface LGPeripheral : NSObject

#pragma mark - Public Properties -

/**
 * Core Bluetooth's CBPeripheral instance
 */
@property (strong, nonatomic, readonly) CBPeripheral *cbPeripheral;

/**
 * LGCentralManager's instance used to connect to peripherals
 */
@property (weak, nonatomic, readonly) LGCentralManager *manager;

/**
 * Flag to indicate discovering services or not
 */
@property (assign, nonatomic, readonly, getter = isDiscoveringServices) BOOL discoveringServices;

/**
 * Available services for this service,
 * will be updated after calling discoverServicesWithCompletion:
 */
@property (strong, nonatomic, readonly) NSArray *services;

/**
 * UUID Identifier of peripheral
 */
@property (weak, nonatomic, readonly) NSString *UUIDString;

/**
 * Name of peripheral
 */
@property (weak, nonatomic, readonly) NSString *name;

/**
 * Indicates if latest disconect was made by watchdog
 * note : that watchdog works only by calling connectWithTimeout:completion:
 */
@property (assign, nonatomic, readonly) BOOL watchDogRaised;

/**
 * Signal strength of peripheral
 */
@property (assign, nonatomic) NSInteger RSSI;

/**
 * The advertisement data that was tracked from peripheral
 */
@property (strong, nonatomic) NSDictionary *advertisingData;


@property(nonatomic,readonly,assign)BOOL isConnected;
#pragma mark - Public Methods -

/**
 * Opens connection WITHOUT timeout to this peripheral
 * @param aCallback Will be called after successfull/failure connection
 */
- (void)connectWithCompletion:(LGPeripheralConnectionCallback)aCallback;

/**
 * Opens connection WITH timeout to this peripheral
 * @param aWatchDogInterval timeout after which, connection will be closed (if it was in stage isConnecting)
 * @param aCallback Will be called after successfull/failure connection
 */
- (void)connectWithTimeout:(NSUInteger)aWatchDogInterval
                completion:(LGPeripheralConnectionCallback)aCallback;

/**
 * Disconnects from peripheral peripheral
 * @param aCallback Will be called after successfull/failure disconnect
 */
- (void)disconnectWithCompletion:(LGPeripheralConnectionCallback)aCallback;

/**
 * Discoveres All services of this peripheral
 * @param aCallback Will be called after successfull/failure discovery
 */
- (void)discoverServicesWithCompletion:(LGPeripheralDiscoverServicesCallback)aCallback;

/**
 * Discoveres Input services of this peripheral
 * @param serviceUUIDs Array of CBUUID's that contain service UUIDs which
 * we need to discover
 * @param aCallback Will be called after successfull/failure ble-operation
 */
- (void)discoverServices:(NSArray *)serviceUUIDs
              completion:(LGPeripheralDiscoverServicesCallback)aCallback;


/**
 * Reads current RSSI of this peripheral, (note : requires active connection to peripheral)
 * @param aCallback Will be called after successfull/failure ble-operation
 */
- (void)readRSSIValueCompletion:(LGPeripheralRSSIValueCallback)aCallback;

#pragma mark - Private Handlers -

// ----- Used for input events -----/

- (void)handleConnectionWithError:(NSError *)anError;

- (void)handleDisconnectWithError:(NSError *)anError;

#pragma mark - Private Initializer -
/**
 * @return Wrapper object over Core Bluetooth's CBPeripheral
 */
- (instancetype)initWithPeripheral:(CBPeripheral *)aPeripheral manager:(LGCentralManager *)manager;

@end
