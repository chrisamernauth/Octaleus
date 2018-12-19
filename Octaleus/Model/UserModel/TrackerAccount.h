#import "_TrackerAccount.h"
#import <FastEasyMapping/FastEasyMapping.h>
#import <MagicalRecord/MagicalRecord.h>
@interface TrackerAccount : _TrackerAccount {}
// Custom logic goes here.
+(FEMMapping *)defaultMapping;
+(TrackerAccount *)getAccount;
-(void)saveAccountOnLocal;
+(NSMutableArray *)fetchAll;
@end
