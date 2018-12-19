// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TrackerDevice.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface TrackerDeviceID : NSManagedObjectID {}
@end

@interface _TrackerDevice : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TrackerDeviceID *objectID;

@property (nonatomic, strong, nullable) NSString* activationStatus;

@property (nonatomic, strong, nullable) NSNumber* batteryCharge;

@property (atomic) float batteryChargeValue;
- (float)batteryChargeValue;
- (void)setBatteryChargeValue:(float)value_;

@property (nonatomic, strong, nullable) NSString* communicationProtocol;

@property (nonatomic, strong, nullable) NSNumber* device_id;

@property (atomic) int16_t device_idValue;
- (int16_t)device_idValue;
- (void)setDevice_idValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSNumber* firmwareVersion;

@property (atomic) int16_t firmwareVersionValue;
- (int16_t)firmwareVersionValue;
- (void)setFirmwareVersionValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSString* imei;

@property (nonatomic, strong, nullable) NSNumber* isOwn;

@property (atomic) BOOL isOwnValue;
- (BOOL)isOwnValue;
- (void)setIsOwnValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSString* name;

@property (nonatomic, strong, nullable) NSNumber* panicMode;

@property (atomic) BOOL panicModeValue;
- (BOOL)panicModeValue;
- (void)setPanicModeValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSString* schedule;

@property (nonatomic, strong, nullable) NSNumber* schedulePending;

@property (atomic) BOOL schedulePendingValue;
- (BOOL)schedulePendingValue;
- (void)setSchedulePendingValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSString* serialId;

@property (nonatomic, strong, nullable) NSNumber* shareCount;

@property (atomic) int16_t shareCountValue;
- (int16_t)shareCountValue;
- (void)setShareCountValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSString* simNumber;

@end

@interface _TrackerDevice (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSString*)primitiveActivationStatus;
- (void)setPrimitiveActivationStatus:(nullable NSString*)value;

- (nullable NSNumber*)primitiveBatteryCharge;
- (void)setPrimitiveBatteryCharge:(nullable NSNumber*)value;

- (float)primitiveBatteryChargeValue;
- (void)setPrimitiveBatteryChargeValue:(float)value_;

- (nullable NSString*)primitiveCommunicationProtocol;
- (void)setPrimitiveCommunicationProtocol:(nullable NSString*)value;

- (nullable NSNumber*)primitiveDevice_id;
- (void)setPrimitiveDevice_id:(nullable NSNumber*)value;

- (int16_t)primitiveDevice_idValue;
- (void)setPrimitiveDevice_idValue:(int16_t)value_;

- (nullable NSNumber*)primitiveFirmwareVersion;
- (void)setPrimitiveFirmwareVersion:(nullable NSNumber*)value;

- (int16_t)primitiveFirmwareVersionValue;
- (void)setPrimitiveFirmwareVersionValue:(int16_t)value_;

- (nullable NSString*)primitiveImei;
- (void)setPrimitiveImei:(nullable NSString*)value;

- (nullable NSNumber*)primitiveIsOwn;
- (void)setPrimitiveIsOwn:(nullable NSNumber*)value;

- (BOOL)primitiveIsOwnValue;
- (void)setPrimitiveIsOwnValue:(BOOL)value_;

- (nullable NSString*)primitiveName;
- (void)setPrimitiveName:(nullable NSString*)value;

- (nullable NSNumber*)primitivePanicMode;
- (void)setPrimitivePanicMode:(nullable NSNumber*)value;

- (BOOL)primitivePanicModeValue;
- (void)setPrimitivePanicModeValue:(BOOL)value_;

- (nullable NSString*)primitiveSchedule;
- (void)setPrimitiveSchedule:(nullable NSString*)value;

- (nullable NSNumber*)primitiveSchedulePending;
- (void)setPrimitiveSchedulePending:(nullable NSNumber*)value;

- (BOOL)primitiveSchedulePendingValue;
- (void)setPrimitiveSchedulePendingValue:(BOOL)value_;

- (nullable NSString*)primitiveSerialId;
- (void)setPrimitiveSerialId:(nullable NSString*)value;

- (nullable NSNumber*)primitiveShareCount;
- (void)setPrimitiveShareCount:(nullable NSNumber*)value;

- (int16_t)primitiveShareCountValue;
- (void)setPrimitiveShareCountValue:(int16_t)value_;

- (nullable NSString*)primitiveSimNumber;
- (void)setPrimitiveSimNumber:(nullable NSString*)value;

@end

@interface TrackerDeviceAttributes: NSObject 
+ (NSString *)activationStatus;
+ (NSString *)batteryCharge;
+ (NSString *)communicationProtocol;
+ (NSString *)device_id;
+ (NSString *)firmwareVersion;
+ (NSString *)imei;
+ (NSString *)isOwn;
+ (NSString *)name;
+ (NSString *)panicMode;
+ (NSString *)schedule;
+ (NSString *)schedulePending;
+ (NSString *)serialId;
+ (NSString *)shareCount;
+ (NSString *)simNumber;
@end

NS_ASSUME_NONNULL_END
