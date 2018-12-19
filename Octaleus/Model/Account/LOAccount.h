//
//  LOAccount.h
//  PallySmartFinder
//
//  Created by Rahul Soni on 21/11/15.
//  Copyright (c) 2015 Rahul Soni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountAuthenticateDelegate.h"
#import "URLSchemea.h"
#import "OCRequest.h"
@interface LOAccount : NSObject<OCRequestDelegate>


@property(nonatomic,strong)NSString *user_id;
@property(nonatomic,strong)NSString *user_name;
@property(nonatomic,strong)NSString *password;
@property(nonatomic,strong)NSString *auth_token;
@property(nonatomic,strong)id<AccountAuthenticateDelegate>delegate;

-(void)authenticateWithusername:(NSString *)email andPassword:(NSString *)password withDelegate:(id<AccountAuthenticateDelegate>)del;
@end
