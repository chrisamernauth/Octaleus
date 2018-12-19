#import "_NexGenDevice.h"
#import <MagicalRecord/MagicalRecord.h>

@interface NexGenDevice : _NexGenDevice
+(NexGenDevice *)newEntity;
+(NSArray *)fetchAll;
- (void)saveDevice;
- (void)discard;
// Custom logic goes here.
@end
