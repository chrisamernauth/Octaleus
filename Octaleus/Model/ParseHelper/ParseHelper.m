//
//  ParseHelper.m
//  Octaleus
//
//  Created by Rahul Soni on 08/02/16.
//  Copyright (c) 2016 Rahul Soni. All rights reserved.
//

#import "ParseHelper.h"
static ParseHelper *singleton = nil;
@implementation ParseHelper

+(ParseHelper *)sharedInstance{
    if (singleton == nil) {
        singleton = [[ParseHelper alloc]init];
    }
    return singleton;
}

-(void)loginWithUsername:(NSString *)username andPassword:(NSString *)password andblock:(loginWithCallback)block{
    PFQuery *query = [PFQuery queryWithClassName:kUserClassKey];
    [query whereKey:kUserFieldKey equalTo:username];
    [query whereKey:kPasswordFieldKey equalTo:password];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if (!error) {
            if (objects.count <= 0) {
                PFUser *user = [[PFUser alloc]init];
                user.username = username;
                user.password = password;
                user.email = username;
                [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
                    if (succeeded) {
                        block(succeeded,error);
                    }else{
                        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error){
                            if (!error) {
                                block(true,error);
                            }else{
                                block(false,error);
                            }
                        }];
                    }
                }];
            }
        }
        
    }];
    
}


@end
