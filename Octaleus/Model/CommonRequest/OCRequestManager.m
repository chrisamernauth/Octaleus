//
//  OCRequestManager.m
//  Octaleus
//
//  Created by Rahul Soni on 25/02/16.
//  Copyright (c) 2016 Rahul Soni. All rights reserved.
//

#import "OCRequestManager.h"
#import "URLSchemea.h"
@implementation OCRequestManager
+ (id) Instance {
    static OCRequestManager *__sharedDataModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedDataModel = [[OCRequestManager alloc] init];
    });
    
    return __sharedDataModel;
}


- (AFHTTPSessionManager*) requestManager
{
    if (_manager == nil) {
        NSURL *url = [NSURL URLWithString:BASE_URL];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url sessionConfiguration:configuration];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/x-www-form-urlencoded",@"application/javascript",@"application/json", nil];
    }
    return _manager;
}



@end
