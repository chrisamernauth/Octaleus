//
//  DeviceRequestManager.m
//  Octaleus
//
//  Created by Rahul Soni on 02/03/16.
//  Copyright (c) 2016 Rahul Soni. All rights reserved.
//

#import "DeviceRequestManager.h"
#import "URLSchemea.h"
@implementation DeviceRequestManager
+ (id) Instance {
    static DeviceRequestManager *__sharedDataModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedDataModel = [[DeviceRequestManager alloc] init];
    });
    
    return __sharedDataModel;
}


- (AFHTTPSessionManager*) requestManager
{
    if (_manager == nil) {
        NSURL *url = [NSURL URLWithString:BASE_URL_ITRAQ];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url sessionConfiguration:configuration];
        [_manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        

        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/x-www-form-urlencoded",@"application/javascript",@"application/json",@"text/plain", nil];
    }
    return _manager;
}
@end
