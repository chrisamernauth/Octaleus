//
//  DataUtility.m
//  JiuJitsu
//
//  Created by Rahul Soni on 06/07/15.
//  Copyright (c) 2015 Rahul Soni. All rights reserved.
//

#import "DataUtility.h"
#import "NSData+FastHex.h"
@implementation DataUtility

+(BOOL)isEmailValid:(NSString *)emailAddress{
    BOOL isValid = NO;
    NSString *emailString = emailAddress;
    NSString *emailReg = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailReg];
    if (([emailTest evaluateWithObject:emailString] != YES) || [emailString isEqualToString:@""]){
        isValid = YES;
    }
    return  isValid;
}

+(NSString *)getAppVersion{
    NSString * version = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
    return version;
}

+(NSString *)getBatteryStatus:(NSData *)data{
    unsigned int result = 0;
    NSScanner *scanner = [NSScanner scannerWithString:[NSString stringWithFormat:@"%@",[data hexStringRepresentationUppercase:YES]]];
    //[scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&result];
    return [NSString stringWithFormat:@"%d%%",result];

}

+(NSMutableArray *)getTimerArray{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i=1;i<60;i++) {
        [arr addObject:[NSString stringWithFormat:@"%d",i]];
    }
    return arr;
}
+(void)saveTimeIntervalForKey:(NSString *)key{
    NSUserDefaults *standardDefault = [NSUserDefaults standardUserDefaults];
    [standardDefault setObject:key forKey:KIT_LOCATE_PERIODIC_INTERVAL];
    [standardDefault synchronize];
}

+(NSString *)getTimeIntervalForKey{
    NSUserDefaults *standardDefault = [NSUserDefaults standardUserDefaults];
    NSString *timeInterval = [standardDefault valueForKey:KIT_LOCATE_PERIODIC_INTERVAL];
    return timeInterval;
}
@end
