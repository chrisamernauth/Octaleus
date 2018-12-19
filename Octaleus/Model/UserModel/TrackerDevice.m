#import "TrackerDevice.h"
#import "NSManagedObject+Mapping.h"
#import "CDHelper.h"
@interface TrackerDevice ()

// Private interface goes here.

@end

@implementation TrackerDevice
+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[TrackerDevice entityName]];
    NSMutableDictionary *dict = [[CDHelper mappingForClass:[TrackerDevice class]] mutableCopy];
    [dict removeObjectForKey:@"device_id"];
    [dict removeObjectForKey:@"fimwareVersion"];
    [dict removeObjectForKey:@"batteryCharge"];
    [dict removeObjectForKey:@"isOwn"];
    [dict removeObjectForKey:@"panicMode"];
    [dict removeObjectForKey:@"schedulePending"];
    [dict removeObjectForKey:@"shareCount"];
    [mapping addAttribute:[TrackerDevice intAttributeFor:@"device_id" andKeyPath:@"id"]];
    [mapping addAttribute:[TrackerDevice intAttributeFor:@"deviceCount" andKeyPath:@"deviceCount"]];
    [mapping addAttribute:[TrackerDevice floatAttributeFor:@"batteryCharge" andKeyPath:@"batteryCharge"]];
    [mapping addAttribute:[TrackerDevice boolAttributeFor:@"isOwn" andKeyPath:@"isOwn"]];
     [mapping addAttribute:[TrackerDevice boolAttributeFor:@"panicMode" andKeyPath:@"panicMode"]];
    [mapping addAttribute:[TrackerDevice intAttributeFor:@"shareCount" andKeyPath:@"shareCount"]];
    
    [mapping addAttributesFromDictionary:dict];
    mapping.primaryKey = @"device_id";
    
    return mapping;
}



- (void) discard
{
    [self MR_deleteEntityInContext:[NSManagedObjectContext MR_defaultContext]];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

- (void)saveDevice{
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

+(NSArray *)fetchAll{
    return [TrackerDevice MR_findAll];
}
// Custom logic goes here.

@end
