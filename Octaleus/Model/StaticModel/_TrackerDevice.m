// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TrackerDevice.m instead.

#import "_TrackerDevice.h"

@implementation TrackerDeviceID
@end

@implementation _TrackerDevice

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"TrackerDevice" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"TrackerDevice";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"TrackerDevice" inManagedObjectContext:moc_];
}

- (TrackerDeviceID*)objectID {
	return (TrackerDeviceID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"batteryChargeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"batteryCharge"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"device_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"device_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"firmwareVersionValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"firmwareVersion"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"isOwnValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isOwn"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"panicModeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"panicMode"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"schedulePendingValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"schedulePending"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"shareCountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"shareCount"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic activationStatus;

@dynamic batteryCharge;

- (float)batteryChargeValue {
	NSNumber *result = [self batteryCharge];
	return [result floatValue];
}

- (void)setBatteryChargeValue:(float)value_ {
	[self setBatteryCharge:@(value_)];
}

- (float)primitiveBatteryChargeValue {
	NSNumber *result = [self primitiveBatteryCharge];
	return [result floatValue];
}

- (void)setPrimitiveBatteryChargeValue:(float)value_ {
	[self setPrimitiveBatteryCharge:@(value_)];
}

@dynamic communicationProtocol;

@dynamic device_id;

- (int16_t)device_idValue {
	NSNumber *result = [self device_id];
	return [result shortValue];
}

- (void)setDevice_idValue:(int16_t)value_ {
	[self setDevice_id:@(value_)];
}

- (int16_t)primitiveDevice_idValue {
	NSNumber *result = [self primitiveDevice_id];
	return [result shortValue];
}

- (void)setPrimitiveDevice_idValue:(int16_t)value_ {
	[self setPrimitiveDevice_id:@(value_)];
}

@dynamic firmwareVersion;

- (int16_t)firmwareVersionValue {
	NSNumber *result = [self firmwareVersion];
	return [result shortValue];
}

- (void)setFirmwareVersionValue:(int16_t)value_ {
	[self setFirmwareVersion:@(value_)];
}

- (int16_t)primitiveFirmwareVersionValue {
	NSNumber *result = [self primitiveFirmwareVersion];
	return [result shortValue];
}

- (void)setPrimitiveFirmwareVersionValue:(int16_t)value_ {
	[self setPrimitiveFirmwareVersion:@(value_)];
}

@dynamic imei;

@dynamic isOwn;

- (BOOL)isOwnValue {
	NSNumber *result = [self isOwn];
	return [result boolValue];
}

- (void)setIsOwnValue:(BOOL)value_ {
	[self setIsOwn:@(value_)];
}

- (BOOL)primitiveIsOwnValue {
	NSNumber *result = [self primitiveIsOwn];
	return [result boolValue];
}

- (void)setPrimitiveIsOwnValue:(BOOL)value_ {
	[self setPrimitiveIsOwn:@(value_)];
}

@dynamic name;

@dynamic panicMode;

- (BOOL)panicModeValue {
	NSNumber *result = [self panicMode];
	return [result boolValue];
}

- (void)setPanicModeValue:(BOOL)value_ {
	[self setPanicMode:@(value_)];
}

- (BOOL)primitivePanicModeValue {
	NSNumber *result = [self primitivePanicMode];
	return [result boolValue];
}

- (void)setPrimitivePanicModeValue:(BOOL)value_ {
	[self setPrimitivePanicMode:@(value_)];
}

@dynamic schedule;

@dynamic schedulePending;

- (BOOL)schedulePendingValue {
	NSNumber *result = [self schedulePending];
	return [result boolValue];
}

- (void)setSchedulePendingValue:(BOOL)value_ {
	[self setSchedulePending:@(value_)];
}

- (BOOL)primitiveSchedulePendingValue {
	NSNumber *result = [self primitiveSchedulePending];
	return [result boolValue];
}

- (void)setPrimitiveSchedulePendingValue:(BOOL)value_ {
	[self setPrimitiveSchedulePending:@(value_)];
}

@dynamic serialId;

@dynamic shareCount;

- (int16_t)shareCountValue {
	NSNumber *result = [self shareCount];
	return [result shortValue];
}

- (void)setShareCountValue:(int16_t)value_ {
	[self setShareCount:@(value_)];
}

- (int16_t)primitiveShareCountValue {
	NSNumber *result = [self primitiveShareCount];
	return [result shortValue];
}

- (void)setPrimitiveShareCountValue:(int16_t)value_ {
	[self setPrimitiveShareCount:@(value_)];
}

@dynamic simNumber;

@end

@implementation TrackerDeviceAttributes 
+ (NSString *)activationStatus {
	return @"activationStatus";
}
+ (NSString *)batteryCharge {
	return @"batteryCharge";
}
+ (NSString *)communicationProtocol {
	return @"communicationProtocol";
}
+ (NSString *)device_id {
	return @"device_id";
}
+ (NSString *)firmwareVersion {
	return @"firmwareVersion";
}
+ (NSString *)imei {
	return @"imei";
}
+ (NSString *)isOwn {
	return @"isOwn";
}
+ (NSString *)name {
	return @"name";
}
+ (NSString *)panicMode {
	return @"panicMode";
}
+ (NSString *)schedule {
	return @"schedule";
}
+ (NSString *)schedulePending {
	return @"schedulePending";
}
+ (NSString *)serialId {
	return @"serialId";
}
+ (NSString *)shareCount {
	return @"shareCount";
}
+ (NSString *)simNumber {
	return @"simNumber";
}
@end

