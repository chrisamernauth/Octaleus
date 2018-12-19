//
//  OCRequestManager.h
//  Octaleus
//
//  Created by Rahul Soni on 25/02/16.
//  Copyright (c) 2016 Rahul Soni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
@interface OCRequestManager : NSObject
{
    AFHTTPSessionManager *_manager;
}

+ (id) Instance;

- (AFHTTPSessionManager*) requestManager;
@end
