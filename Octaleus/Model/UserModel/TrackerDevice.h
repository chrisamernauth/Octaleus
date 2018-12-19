#import "_TrackerDevice.h"
#import <FastEasyMapping/FastEasyMapping.h>
#import <MagicalRecord/MagicalRecord.h>
@interface TrackerDevice : _TrackerDevice {}
+ (FEMMapping *)defaultMapping;
+(NSArray *)fetchAll;
- (void) discard;
- (void)saveDevice;
// Custom logic goes here.
@end
