//
//  OCRequestDelegate.h
//  Octaleus
//
//  Created by Rahul Soni on 25/02/16.
//  Copyright (c) 2016 Rahul Soni. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OCRequest;
@protocol OCRequestDelegate <NSObject>

-(void)OCRequestDidSucceed:(OCRequest *)request;

-(void)OCRequestDidFail:(OCRequest *)request withError:(NSError*) error;
@end
