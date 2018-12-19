#import "NexGenDevice.h"

@interface NexGenDevice ()

// Private interface goes here.

@end

@implementation NexGenDevice
+(NexGenDevice *)newEntity{
    NexGenDevice *appt = [NexGenDevice MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
    return appt;
}
// Custom logic goes here.
+(void) saveDevice
{
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

+(NSArray *)fetchAll{
    return [NexGenDevice MR_findAll];
}

- (void) discard
{
    [self MR_deleteEntityInContext:[NSManagedObjectContext MR_defaultContext]];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

@end
