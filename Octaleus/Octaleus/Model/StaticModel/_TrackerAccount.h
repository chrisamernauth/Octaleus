// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TrackerAccount.h instead.

#import <CoreData/CoreData.h>

extern const struct TrackerAccountAttributes {
	__unsafe_unretained NSString *account_id;
	__unsafe_unretained NSString *deviceCount;
	__unsafe_unretained NSString *distanceType;
	__unsafe_unretained NSString *email;
	__unsafe_unretained NSString *isExternalUser;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *timezone;
} TrackerAccountAttributes;

@interface TrackerAccountID : NSManagedObjectID {}
@end

@interface _TrackerAccount : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TrackerAccountID* objectID;

@property (nonatomic, strong) NSNumber* account_id;

@property (atomic) int32_t account_idValue;
- (int32_t)account_idValue;
- (void)setAccount_idValue:(int32_t)value_;

//- (BOOL)validateAccount_id:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* deviceCount;

@property (atomic) int16_t deviceCountValue;
- (int16_t)deviceCountValue;
- (void)setDeviceCountValue:(int16_t)value_;

//- (BOOL)validateDeviceCount:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* distanceType;

//- (BOOL)validateDistanceType:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* email;

//- (BOOL)validateEmail:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* isExternalUser;

@property (atomic) BOOL isExternalUserValue;
- (BOOL)isExternalUserValue;
- (void)setIsExternalUserValue:(BOOL)value_;

//- (BOOL)validateIsExternalUser:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* timezone;

//- (BOOL)validateTimezone:(id*)value_ error:(NSError**)error_;

@end

@interface _TrackerAccount (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveAccount_id;
- (void)setPrimitiveAccount_id:(NSNumber*)value;

- (int32_t)primitiveAccount_idValue;
- (void)setPrimitiveAccount_idValue:(int32_t)value_;

- (NSNumber*)primitiveDeviceCount;
- (void)setPrimitiveDeviceCount:(NSNumber*)value;

- (int16_t)primitiveDeviceCountValue;
- (void)setPrimitiveDeviceCountValue:(int16_t)value_;

- (NSString*)primitiveDistanceType;
- (void)setPrimitiveDistanceType:(NSString*)value;

- (NSString*)primitiveEmail;
- (void)setPrimitiveEmail:(NSString*)value;

- (NSNumber*)primitiveIsExternalUser;
- (void)setPrimitiveIsExternalUser:(NSNumber*)value;

- (BOOL)primitiveIsExternalUserValue;
- (void)setPrimitiveIsExternalUserValue:(BOOL)value_;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSString*)primitiveTimezone;
- (void)setPrimitiveTimezone:(NSString*)value;

@end
