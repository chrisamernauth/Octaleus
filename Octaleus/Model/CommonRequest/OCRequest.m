//
//  OCRequest.m
//  Octaleus
//
//  Created by Rahul Soni on 25/02/16.
//  Copyright (c) 2016 Rahul Soni. All rights reserved.
//

#import "OCRequest.h"
#import "TrackerAccount.h"
#import "OCRequestManager.h"
#import "DeviceRequestManager.h"
#import "AccountManager.h"
#import "LOAccount.h"
#import "URLSchemea.h"
@implementation OCRequest
@synthesize postData = _postData;
@synthesize httpHeaderField = _httpHeaderField;
@synthesize responseData = _responseData;
@synthesize rawResponse = _rawResponse;
@synthesize StatusCode = _StatusCode;
@synthesize IsSuccess = _IsSuccess;
@synthesize Tag = _Tag;

- (id)initWithUrl:(NSString *)urlString andDelegate:(id<OCRequestDelegate>)del {
    return [self initWithUrlPart:urlString andDelegate:del andMethod:GET];
}

- (id)initWithUrlPart:(NSString *)urlString andDelegate:(id<OCRequestDelegate>)del andMethod:(RequestMethod)method {
    self = [super init];
    
    if (self)
    {
        _urlPart = urlString;
        _methodType = method;
        _postParameters = [[NSMutableDictionary alloc] init];
        _delegate = del;
    }
    
    return self;
}

- (void)setParameter:(id)parameter forKey:(NSString *)key {
    [_postParameters setObject:parameter forKey:key];
}

- (void) setPostParameters:(NSMutableDictionary*)dict
{
    _postParameters = dict;
}

- (void)startRequest
{
    _urlPart = [NSString stringWithFormat:@"%@",_urlPart];
    
    if (_methodType == GET) {
        if ([_Tag isEqual:DEVICES]||[_Tag isEqual:DEVICES_ACTIVATED] || [_Tag isEqual:@"DeviceTag"]) {
            TrackerAccount *account = [TrackerAccount getAccount];
             [[[DeviceRequestManager Instance] requestManager].requestSerializer setValue:account.auth_token forHTTPHeaderField:@"X-AUTH-TOKEN"];
            [[[DeviceRequestManager Instance] requestManager] GET:_urlPart parameters:_postParameters success:^void(NSURLSessionDataTask * task, id responseObject) {
                
                _responseData = responseObject;
                NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
                self.StatusCode = r.statusCode;
                self.IsSuccess = YES;
                [self requestSuccess];
            } failure:^void(NSURLSessionDataTask * task, NSError *error) {
                NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
                self.StatusCode = r.statusCode;
                self.IsSuccess = NO;
                self.responseData = nil;
                [self requestFailedWithError:error];
            }];
        }else{
            [[[OCRequestManager Instance] requestManager] GET:_urlPart parameters:_postParameters success:^void(NSURLSessionDataTask * task, id responseObject) {
                
                _responseData = responseObject;
                NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
                self.StatusCode = r.statusCode;
                self.IsSuccess = YES;
                [self requestSuccess];
            } failure:^void(NSURLSessionDataTask * task, NSError *error) {
                NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
                self.StatusCode = r.statusCode;
                self.IsSuccess = NO;
                self.responseData = nil;
                [self requestFailedWithError:error];
            }];

        }
            }else if (_methodType == POST){
       
        if ([_Tag isEqual:BASE_URL_ITRAQ]||[_Tag isEqual:ADD_DEVICES] || [_Tag isEqual:COMBAIN]) {
            
            [[[DeviceRequestManager Instance] requestManager] POST:_urlPart parameters:_postParameters success:^void(NSURLSessionDataTask * task, id responseObject) {
                _responseData = responseObject;
                NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
                self.StatusCode = r.statusCode;
                self.httpHeaderField = r.allHeaderFields;
                self.IsSuccess = YES;
                [self requestSuccess];
            } failure:^void(NSURLSessionDataTask * task, NSError * error) {
                NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
                self.StatusCode = r.statusCode;
                self.httpHeaderField = r.allHeaderFields;
                self.IsSuccess = NO;
                self.responseData = nil;
                [self requestFailedWithError:error];
            }];
        }else{
            if ([_Tag isEqual:REGISTRATION]) {
                LOAccount *account = [AccountManager Instance].activeAccount;
                [[[OCRequestManager Instance] requestManager].requestSerializer setValue:account.auth_token forHTTPHeaderField:@"X-Auth-Token"];
                [[[OCRequestManager Instance] requestManager].requestSerializer setValue:account.user_id forHTTPHeaderField:@"X-User-Id"];
            }
            [[[OCRequestManager Instance] requestManager] POST:_urlPart parameters:_postParameters success:^void(NSURLSessionDataTask * task, id responseObject) {
                _responseData = responseObject;
                NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
                self.StatusCode = r.statusCode;
                self.IsSuccess = YES;
                [self requestSuccess];
            } failure:^void(NSURLSessionDataTask * task, NSError * error) {
                NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
                self.StatusCode = r.statusCode;
                self.IsSuccess = NO;
                self.responseData = nil;
                [self requestFailedWithError:error];
            }];
        }
        
    }else if (_methodType == PUT) {
        [[[OCRequestManager Instance] requestManager] PUT:_urlPart parameters:_postParameters success:^void(NSURLSessionDataTask * task, id responseObject) {
            _responseData = responseObject;
            NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
            self.StatusCode = r.statusCode;
            self.IsSuccess = YES;
            [self requestSuccess];
        } failure:^void(NSURLSessionDataTask * task, NSError * error) {
            NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
            self.StatusCode = r.statusCode;
            self.IsSuccess = NO;
            self.responseData = nil;
            [self requestFailedWithError:error];
        }];
    }else if (_methodType == DELETE) {
        [[[OCRequestManager Instance] requestManager] DELETE:_urlPart parameters:_postParameters success:^void(NSURLSessionDataTask * task, id responseObject) {
            _responseData = responseObject;
            NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
            self.StatusCode = r.statusCode;
            self.IsSuccess = YES;
            [self requestSuccess];
        } failure:^void(NSURLSessionDataTask * task, NSError *error) {
            NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
            self.StatusCode = r.statusCode;
            self.IsSuccess = NO;
            self.responseData = nil;
            [self requestFailedWithError:error];
        }];
    }
}

- (void) requestSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(OCRequestDidSucceed:)]) {
        [_delegate OCRequestDidSucceed:self];
    }
}

- (void) requestFailedWithError:(NSError*)error
{
    if (_delegate && [_delegate respondsToSelector:@selector(OCRequestDidFail:withError:)]) {
        [_delegate OCRequestDidFail:self withError:error];
    }
}
@end
