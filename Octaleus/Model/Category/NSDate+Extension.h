//
//  NSDate+Extension.h
//  Octaleus
//
//  Created by Rahul Soni on 03/03/16.
//  Copyright (c) 2016 Rahul Soni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
#define MMDDYYYY             @"MM/dd/yyyy"

+ (NSDate *) date2;
- (BOOL) isSameDayAs:(NSDate *)date2;

+ (NSString *)systemDateWithFormatter:(NSString *)format AddingDay:(int)day;

- (BOOL) isOneDayPrevious:(NSDate *)date2;
+ (NSDate *)getDateFromJSONString:(NSString *)str;
+ (NSDate *) date2With15MinutesInterval;
- (NSString*) getJSONDateString;
- (int)dateCompareValue;
+ (NSDate *)systemDate;
- (NSDate*) changeTimeZoneToLocal;
- (NSString *)stringWithFormat:(NSString *)format;@end
