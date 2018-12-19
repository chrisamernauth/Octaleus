// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BLEDevice.h instead.

#import <CoreData/CoreData.h>

extern const struct BLEDeviceAttributes {
	__unsafe_unretained NSString *batteryLevel;
	__unsafe_unretained NSString *identifier;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *systemId;
} BLEDeviceAttributes;

@interface BLEDeviceID : NSManagedObjectID {}
@end

@interface _BLEDevice : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) BLEDeviceID* objectID;

@property (nonatomic, strong) NSString* batteryLevel;

//- (BOOL)validateBatteryLevel:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* identifier;

//- (BOOL)validateIdentifier:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* systemId;

//- (BOOL)validateSystemId:(id*)value_ error:(NSError**)error_;

@end

@interface _BLEDevice (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveBatteryLevel;
- (void)setPrimitiveBatteryLevel:(NSString*)value;

- (NSString*)primitiveIdentifier;
- (void)setPrimitiveIdentifier:(NSString*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSString*)primitiveSystemId;
- (void)setPrimitiveSystemId:(NSString*)value;

@end
