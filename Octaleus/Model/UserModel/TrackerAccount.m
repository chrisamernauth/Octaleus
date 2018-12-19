#import "TrackerAccount.h"
#import "NSManagedObject+Mapping.h"
#import "CDHelper.h"
@interface TrackerAccount ()

// Private interface goes here.

@end

@implementation TrackerAccount
+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[TrackerAccount entityName]];
    NSMutableDictionary *dict = [[CDHelper mappingForClass:[TrackerAccount class]] mutableCopy];
    [dict removeObjectForKey:@"account_id"];
    [dict removeObjectForKey:@"deviceCount"];
    [dict removeObjectForKey:@"isExternalUser"];
    [dict removeObjectForKey:@"timezone"];
    [mapping addAttribute:[TrackerAccount intAttributeFor:@"account_id" andKeyPath:@"id"]];
    [mapping addAttribute:[TrackerAccount intAttributeFor:@"timezone" andKeyPath:@"timezone"]];
    [mapping addAttribute:[TrackerAccount intAttributeFor:@"deviceCount" andKeyPath:@"deviceCount"]];
    [mapping addAttribute:[TrackerAccount boolAttributeFor:@"isExternalUser" andKeyPath:@"isExternalUser"]];
    
    [mapping addAttributesFromDictionary:dict];
    
    return mapping;
}


- (void)saveAccountOnLocal{
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

+(NSMutableArray *)fetchAll{
    return [[TrackerAccount MR_findAll] mutableCopy];
}

+(TrackerAccount *)getAccount{
    return [TrackerAccount MR_findFirst];
}
// Custom logic goes here.

@end
