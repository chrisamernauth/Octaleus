// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BLEDevice.m instead.

#import "_BLEDevice.h"

const struct BLEDeviceAttributes BLEDeviceAttributes = {
	.batteryLevel = @"batteryLevel",
	.identifier = @"identifier",
	.name = @"name",
	.systemId = @"systemId",
};

@implementation BLEDeviceID
@end

@implementation _BLEDevice

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"BLEDevice" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"BLEDevice";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"BLEDevice" inManagedObjectContext:moc_];
}

- (BLEDeviceID*)objectID {
	return (BLEDeviceID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic batteryLevel;

@dynamic identifier;

@dynamic name;

@dynamic systemId;

@end

