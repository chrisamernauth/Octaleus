//
//  OCRequest.h
//  Octaleus
//
//  Created by Rahul Soni on 25/02/16.
//  Copyright (c) 2016 Rahul Soni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "OCRequestDelegate.h"
typedef enum {
    GET = 1,
    POST = 2,
    PUT = 3,
    DELETE = 4,
    PATCH = 5,
}RequestMethod;
@interface OCRequest : NSObject
{
    id<OCRequestDelegate> _delegate;
    
    NSString *_urlPart;
    
    NSMutableDictionary *_postParameters;
    
    RequestMethod _methodType;
    
    NSString *_postData;
    
    id _responseData;
    
    NSString *_rawResponse;
    
    BOOL _IsSuccess;
    
    NSInteger _StatusCode;
    
    NSString *_Tag;
    
    NSDictionary *_httpHeaderField;
    
}
@property (nonatomic, retain, readwrite) NSString *postData;

@property (nonatomic, retain, readwrite) id responseData;

@property (nonatomic, retain, readwrite) NSString *rawResponse;

@property (nonatomic, assign) NSInteger StatusCode;

@property (nonatomic, assign) BOOL IsSuccess;

@property (nonatomic, retain, readwrite) NSString *Tag;

@property (nonatomic, retain, readwrite) NSDictionary *httpHeaderField;




@property (nonatomic, retain, readwrite)NSMutableDictionary *postParameters;
- (id) initWithUrl:(NSString*) urlString andDelegate:(id<OCRequestDelegate>) del;

- (id) initWithUrlPart:(NSString*) urlString andDelegate:(id<OCRequestDelegate>) del andMethod:(RequestMethod) method;

- (void)setParameter:(id)parameter forKey:(NSString *)key;

- (void) setPostParameters:(NSMutableDictionary*)dict;

- (void)startRequest;
@end
