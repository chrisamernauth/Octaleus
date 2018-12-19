#import "_BLEDevice.h"
#import <MagicalRecord/MagicalRecord.h>
@interface BLEDevice : _BLEDevice {}
// Custom logic goes here.
+(BLEDevice *)newEntity;
+(void) saveDevice;
+(NSArray *)fetchAll;
- (void) discard;
+(NSMutableArray *)fetchIdentifiers;
+(BLEDevice *)getPeripheralFromUUID:(NSString *)uuid;
+(BOOL)isPeripheralExist:(NSString *)udid;
@end
