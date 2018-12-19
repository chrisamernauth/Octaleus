//
//  DataUtility.h
//  JiuJitsu
//
//  Created by Rahul Soni on 06/07/15.
//  Copyright (c) 2015 Rahul Soni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LOAccount.h"
#define KIT_LOCATE_PERIODIC_INTERVAL @"TimeInterval"
@interface DataUtility : NSObject

+(BOOL)isEmailValid:(NSString *)emailAddress;
+(NSString *)getBatteryStatus:(NSData *)data;
+(void)saveTimeIntervalForKey:(NSString *)key;
+(NSString *)getTimeIntervalForKey;
+(NSMutableArray *)getTimerArray;
+(NSString *)getAppVersion;
@end
