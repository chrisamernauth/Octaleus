//
//  ParseHelper.h
//  Octaleus
//
//  Created by Rahul Soni on 08/02/16.
//  Copyright (c) 2016 Rahul Soni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

#define kUserClassKey @"_User"
#define kUserFieldKey @"username"
#define kPasswordFieldKey @"password"
typedef void(^loginWithCallback)(BOOL success,NSError *error);

@interface ParseHelper : NSObject

+(ParseHelper *)sharedInstance;
-(void)loginWithUsername:(NSString *)username andPassword:(NSString *)password andblock:(loginWithCallback)block;

@end
