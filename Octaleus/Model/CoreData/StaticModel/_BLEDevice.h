// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BLEDevice.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface BLEDeviceID : NSManagedObjectID {}
@end

@interface _BLEDevice : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) BLEDeviceID *objectID;

@property (nonatomic, strong, nullable) NSString* batteryLevel;

@property (nonatomic, strong, nullable) NSString* identifier;

@property (nonatomic, strong, nullable) NSString* name;

@property (nonatomic, strong, nullable) NSString* systemId;

@end

@interface _BLEDevice (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSString*)primitiveBatteryLevel;
- (void)setPrimitiveBatteryLevel:(nullable NSString*)value;

- (nullable NSString*)primitiveIdentifier;
- (void)setPrimitiveIdentifier:(nullable NSString*)value;

- (nullable NSString*)primitiveName;
- (void)setPrimitiveName:(nullable NSString*)value;

- (nullable NSString*)primitiveSystemId;
- (void)setPrimitiveSystemId:(nullable NSString*)value;

@end

@interface BLEDeviceAttributes: NSObject 
+ (NSString *)batteryLevel;
+ (NSString *)identifier;
+ (NSString *)name;
+ (NSString *)systemId;
@end

NS_ASSUME_NONNULL_END
