// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NexGenDevice.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface NexGenDeviceID : NSManagedObjectID {}
@end

@interface _NexGenDevice : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) NexGenDeviceID *objectID;

@property (nonatomic, strong, nullable) NSString* serial_id;

@property (nonatomic, strong, nullable) NSString* tracker_id;

@end

@interface _NexGenDevice (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSString*)primitiveSerial_id;
- (void)setPrimitiveSerial_id:(nullable NSString*)value;

- (nullable NSString*)primitiveTracker_id;
- (void)setPrimitiveTracker_id:(nullable NSString*)value;

@end

@interface NexGenDeviceAttributes: NSObject 
+ (NSString *)serial_id;
+ (NSString *)tracker_id;
@end

NS_ASSUME_NONNULL_END
