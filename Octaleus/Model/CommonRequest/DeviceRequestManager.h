//
//  DeviceRequestManager.h
//  Octaleus
//
//  Created by Rahul Soni on 02/03/16.
//  Copyright (c) 2016 Rahul Soni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
@interface DeviceRequestManager : NSObject
{
    AFHTTPSessionManager *_manager;
}

+ (id) Instance;

- (AFHTTPSessionManager*) requestManager;

@end
