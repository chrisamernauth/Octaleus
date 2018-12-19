// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TrackerAccount.m instead.

#import "_TrackerAccount.h"

const struct TrackerAccountAttributes TrackerAccountAttributes = {
	.account_id = @"account_id",
	.deviceCount = @"deviceCount",
	.distanceType = @"distanceType",
	.email = @"email",
	.isExternalUser = @"isExternalUser",
	.name = @"name",
	.timezone = @"timezone",
};

@implementation TrackerAccountID
@end

@implementation _TrackerAccount

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"TrackerAccount" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"TrackerAccount";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"TrackerAccount" inManagedObjectContext:moc_];
}

- (TrackerAccountID*)objectID {
	return (TrackerAccountID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"account_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"account_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"deviceCountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"deviceCount"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"isExternalUserValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isExternalUser"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic account_id;

- (int32_t)account_idValue {
	NSNumber *result = [self account_id];
	return [result intValue];
}

- (void)setAccount_idValue:(int32_t)value_ {
	[self setAccount_id:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveAccount_idValue {
	NSNumber *result = [self primitiveAccount_id];
	return [result intValue];
}

- (void)setPrimitiveAccount_idValue:(int32_t)value_ {
	[self setPrimitiveAccount_id:[NSNumber numberWithInt:value_]];
}

@dynamic deviceCount;

- (int16_t)deviceCountValue {
	NSNumber *result = [self deviceCount];
	return [result shortValue];
}

- (void)setDeviceCountValue:(int16_t)value_ {
	[self setDeviceCount:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveDeviceCountValue {
	NSNumber *result = [self primitiveDeviceCount];
	return [result shortValue];
}

- (void)setPrimitiveDeviceCountValue:(int16_t)value_ {
	[self setPrimitiveDeviceCount:[NSNumber numberWithShort:value_]];
}

@dynamic distanceType;

@dynamic email;

@dynamic isExternalUser;

- (BOOL)isExternalUserValue {
	NSNumber *result = [self isExternalUser];
	return [result boolValue];
}

- (void)setIsExternalUserValue:(BOOL)value_ {
	[self setIsExternalUser:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveIsExternalUserValue {
	NSNumber *result = [self primitiveIsExternalUser];
	return [result boolValue];
}

- (void)setPrimitiveIsExternalUserValue:(BOOL)value_ {
	[self setPrimitiveIsExternalUser:[NSNumber numberWithBool:value_]];
}

@dynamic name;

@dynamic timezone;

@end

