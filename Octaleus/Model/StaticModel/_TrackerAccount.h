// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TrackerAccount.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface TrackerAccountID : NSManagedObjectID {}
@end

@interface _TrackerAccount : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TrackerAccountID *objectID;

@property (nonatomic, strong, nullable) NSNumber* account_id;

@property (atomic) int32_t account_idValue;
- (int32_t)account_idValue;
- (void)setAccount_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* auth_token;

@property (nonatomic, strong, nullable) NSNumber* deviceCount;

@property (atomic) int16_t deviceCountValue;
- (int16_t)deviceCountValue;
- (void)setDeviceCountValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSString* distanceType;

@property (nonatomic, strong, nullable) NSString* email;

@property (nonatomic, strong, nullable) NSNumber* isExternalUser;

@property (atomic) BOOL isExternalUserValue;
- (BOOL)isExternalUserValue;
- (void)setIsExternalUserValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSString* name;

@property (nonatomic, strong, nullable) NSNumber* timezone;

@property (atomic) int16_t timezoneValue;
- (int16_t)timezoneValue;
- (void)setTimezoneValue:(int16_t)value_;

@end

@interface _TrackerAccount (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSNumber*)primitiveAccount_id;
- (void)setPrimitiveAccount_id:(nullable NSNumber*)value;

- (int32_t)primitiveAccount_idValue;
- (void)setPrimitiveAccount_idValue:(int32_t)value_;

- (nullable NSString*)primitiveAuth_token;
- (void)setPrimitiveAuth_token:(nullable NSString*)value;

- (nullable NSNumber*)primitiveDeviceCount;
- (void)setPrimitiveDeviceCount:(nullable NSNumber*)value;

- (int16_t)primitiveDeviceCountValue;
- (void)setPrimitiveDeviceCountValue:(int16_t)value_;

- (nullable NSString*)primitiveDistanceType;
- (void)setPrimitiveDistanceType:(nullable NSString*)value;

- (nullable NSString*)primitiveEmail;
- (void)setPrimitiveEmail:(nullable NSString*)value;

- (nullable NSNumber*)primitiveIsExternalUser;
- (void)setPrimitiveIsExternalUser:(nullable NSNumber*)value;

- (BOOL)primitiveIsExternalUserValue;
- (void)setPrimitiveIsExternalUserValue:(BOOL)value_;

- (nullable NSString*)primitiveName;
- (void)setPrimitiveName:(nullable NSString*)value;

- (nullable NSNumber*)primitiveTimezone;
- (void)setPrimitiveTimezone:(nullable NSNumber*)value;

- (int16_t)primitiveTimezoneValue;
- (void)setPrimitiveTimezoneValue:(int16_t)value_;

@end

@interface TrackerAccountAttributes: NSObject 
+ (NSString *)account_id;
+ (NSString *)auth_token;
+ (NSString *)deviceCount;
+ (NSString *)distanceType;
+ (NSString *)email;
+ (NSString *)isExternalUser;
+ (NSString *)name;
+ (NSString *)timezone;
@end

NS_ASSUME_NONNULL_END
