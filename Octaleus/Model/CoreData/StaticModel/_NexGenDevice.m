// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NexGenDevice.m instead.

#import "_NexGenDevice.h"

@implementation NexGenDeviceID
@end

@implementation _NexGenDevice

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"NexGenDevice" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"NexGenDevice";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"NexGenDevice" inManagedObjectContext:moc_];
}

- (NexGenDeviceID*)objectID {
	return (NexGenDeviceID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic serial_id;

@dynamic tracker_id;

@end

@implementation NexGenDeviceAttributes 
+ (NSString *)serial_id {
	return @"serial_id";
}
+ (NSString *)tracker_id {
	return @"tracker_id";
}
@end

