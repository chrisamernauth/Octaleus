

#import <Foundation/Foundation.h>

@class LOAccount;

@interface AccountManager : NSObject
{
    LOAccount *_activeAccount;
    
    NSMutableDictionary *_savedAccounts;
}

@property (nonatomic, readwrite, retain) LOAccount *activeAccount;

+(AccountManager*)Instance;

-(void)saveAccount;



@end
