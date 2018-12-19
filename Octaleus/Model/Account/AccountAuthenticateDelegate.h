

#import <Foundation/Foundation.h>

@class LOAccount;
@protocol AccountAuthenticateDelegate <NSObject>

-(void)accountAuthenticatedWithAccount:(LOAccount*) account;
-(void)accountDidFailAuthentication:(NSError*) error;

@end
