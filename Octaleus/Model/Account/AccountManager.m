


#import "AccountManager.h"
#import "LOAccount.h"
NSString *kActiveUserKey = @"EncodedActiveLOK8User";

@implementation AccountManager


+(AccountManager*)Instance
{
    static AccountManager* singleton = nil;
    
    if (singleton == nil)
        singleton = [[AccountManager alloc] init];
    
    return singleton;
    
}

-(NSString*)accountFilename
{
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, TRUE) lastObject];
    return [documentsPath stringByAppendingPathComponent:@"LOAccountInformation.dat"];
}

-(id)init
{
    self = [super init];
    
    if (self)
    {
        NSData *accountData = [[NSUserDefaults standardUserDefaults] objectForKey:kActiveUserKey];
        
        if (accountData)
        {
            _activeAccount = [NSKeyedUnarchiver unarchiveObjectWithData:accountData];
        }
        
        _savedAccounts = [NSKeyedUnarchiver unarchiveObjectWithFile:[self accountFilename]];
        
        if (_savedAccounts == nil)
            _savedAccounts = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

-(void)saveAccounts
{
    [NSKeyedArchiver archiveRootObject:_savedAccounts toFile:[self accountFilename]];
}

-(void)saveAccount
{
    NSData *data = nil;
    
    if (_activeAccount)
        data = [NSKeyedArchiver archivedDataWithRootObject:_activeAccount];
    
    if (data)
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:kActiveUserKey];
    else
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kActiveUserKey];
    
    if (_activeAccount)
    {
        [_savedAccounts setObject:_activeAccount forKey:_activeAccount.user_id];
        [self saveAccounts];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark Properties

@synthesize activeAccount = _activeAccount;

-(void)setActiveAccount:(LOAccount *)activeAccount
{
    _activeAccount = activeAccount;
    
    [self saveAccount];
}




@end
