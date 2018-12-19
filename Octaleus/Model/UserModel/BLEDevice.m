#import "BLEDevice.h"

@interface BLEDevice ()

// Private interface goes here.

@end

@implementation BLEDevice
+(BLEDevice *)newEntity{
    BLEDevice *appt = [BLEDevice MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
    return appt;
}


+(void) saveDevice
{
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

+(NSArray *)fetchAll{
    return [BLEDevice MR_findAll];
}

- (void) discard
{
    [self MR_deleteEntityInContext:[NSManagedObjectContext MR_defaultContext]];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

+(NSMutableArray *)fetchIdentifiers{
    return [[BLEDevice fetchAll] valueForKey:@"identifier"];
}

+(BLEDevice *)getPeripheralFromUUID:(NSString *)uuid{
    return [BLEDevice MR_findFirstByAttribute:@"identifier" withValue:uuid];
}
+(BOOL)isPeripheralExist:(NSString *)udid{
    NSArray *arr = [BLEDevice MR_findByAttribute:@"identifier" withValue:udid];
    if (arr.count > 0) {
        return true;
    }else{
        return false;
    }
    
}

// Custom logic goes here.

@end
