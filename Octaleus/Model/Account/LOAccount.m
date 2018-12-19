//
//  LOAccount.m
//  PallySmartFinder
//
//  Created by Rahul Soni on 21/11/15.
//  Copyright (c) 2015 Rahul Soni. All rights reserved.
//

#import "LOAccount.h"
#define ENCODING_VERSION        2
@implementation LOAccount
-(id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self)
    {
        if ([aDecoder decodeIntForKey:@"version"] == ENCODING_VERSION)
        {
            _auth_token = [aDecoder decodeObjectForKey:@"authToken"];
            _user_id = [aDecoder decodeObjectForKey:@"userId"];
            _user_name = [aDecoder decodeObjectForKey:@"user_name"];
            _password = [aDecoder decodeObjectForKey:@"password"];
        }
    }
    
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:ENCODING_VERSION forKey:@"version"];
    [aCoder encodeObject:_user_id forKey:@"userId"];
    [aCoder encodeObject:_auth_token forKey:@"authToken"];
    [aCoder encodeObject:_user_name forKey:@"user_name"];
    [aCoder encodeObject:_password forKey:@"password"];
}
-(void)authenticateWithusername:(NSString *)email andPassword:(NSString *)password withDelegate:(id<AccountAuthenticateDelegate>)del{
    _delegate = del;
    _user_name = email;
    _password = password;
     OCRequest *request = [[OCRequest alloc]initWithUrlPart:LOGIN andDelegate:self andMethod:POST];
    [request setParameter:email forKey:@"email"];
    [request setParameter:password forKey:@"password"];
    request.Tag = LOGIN;
    [request startRequest];
}

#pragma mark -OCRequestDelegate
-(void)OCRequestDidSucceed:(OCRequest *)request{
    NSDictionary *dict = [request.responseData objectForKey:@"data"];
    if ([dict objectForKey:@"userId"]) {
        _user_id = [dict objectForKey:@"userId"];
    }
    if ([dict objectForKey:@"authToken"]) {
        _auth_token = [dict objectForKey:@"authToken"];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(accountAuthenticatedWithAccount:)]) {
        [_delegate accountAuthenticatedWithAccount:self];
    }
}

-(void)OCRequestDidFail:(OCRequest *)request withError:(NSError *)error{
    if (_delegate && [_delegate respondsToSelector:@selector(accountAuthenticatedWithAccount:)]) {
        [_delegate accountDidFailAuthentication:error];
    }
}


@end
