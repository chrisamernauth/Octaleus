//
//  NSManagedObject+Mapping.m
//  Octaleus
//
//  Created by Rahul Soni on 03/03/16.
//  Copyright (c) 2016 Rahul Soni. All rights reserved.
//

#import "NSManagedObject+Mapping.h"
#import "NSDate+Extension.h"
@implementation NSManagedObject (Mapping)
+ (FEMAttribute*) floatAttributeFor:(NSString*)property andKeyPath:(NSString*)keyPath
{
    FEMAttribute *attr = [[FEMAttribute alloc] initWithProperty:property keyPath:keyPath map:^id(id value) {
        if ([value isKindOfClass:[NSString class]]) {
            return [NSNumber numberWithFloat:[value floatValue]];
        }
        return value;
    } reverseMap:^id(id value) {
        return [NSString stringWithFormat:@"%.02f", [value floatValue]];
    }];
    return attr;
}

+ (FEMAttribute*) doubleAttributeFor:(NSString*)property andKeyPath:(NSString*)keyPath
{
    
    FEMAttribute *attr = [[FEMAttribute alloc] initWithProperty:property keyPath:keyPath map:^id(id value) {
        if ([value isKindOfClass:[NSString class]]) {
            NSLog(@"Narendra %f",[value doubleValue]);
            return [NSNumber numberWithDouble:[value doubleValue]];
        }
        return value;
    } reverseMap:^id(id value) {
        NSLog(@"Narendra %f",[value doubleValue]);
        return [NSString stringWithFormat:@"%.02f", [value doubleValue]];
    }];
    return attr;
}

+ (FEMAttribute*) intAttributeFor:(NSString*)property andKeyPath:(NSString*)keyPath
{
    FEMAttribute *attr = [[FEMAttribute alloc] initWithProperty:property keyPath:keyPath map:^id(id value) {
        if ([value isKindOfClass:[NSString class]]) {
            return [NSNumber numberWithInt:[value floatValue]];
        }
        return value;
    } reverseMap:^id(id value) {
        return [NSString stringWithFormat:@"%d", [value intValue]];
    }];
    return attr;
}

+ (FEMAttribute*) boolAttributeFor:(NSString*)property andKeyPath:(NSString*)keyPath
{
    FEMAttribute *attr = [[FEMAttribute alloc] initWithProperty:property keyPath:keyPath map:^id(id value) {
        if ([value isKindOfClass:[NSString class]]) {
            return [NSNumber numberWithBool:[value boolValue]];
        }
        return value;
    } reverseMap:^id(id value) {
        return [NSString stringWithFormat:@"%d", [value boolValue]];
    }];
    return attr;
}

+ (FEMAttribute*) dateTimeAttributeFor:(NSString*)property andKeyPath:(NSString*)keyPath
{
    FEMAttribute *attr = [[FEMAttribute alloc] initWithProperty:property keyPath:keyPath map:^id(id value) {
        if ([value isKindOfClass:[NSString class]]) {
            return [NSDate getDateFromJSONString:value];
        }
        return value;
    } reverseMap:^id(id value) {
        return [NSString stringWithFormat:@"%@", value];
    }];
    return attr;
}

+ (FEMAttribute*) timeAttributeFor:(NSString*)property andKeyPath:(NSString*)keyPath
{
    FEMAttribute *attr = [[FEMAttribute alloc] initWithProperty:property keyPath:keyPath map:^id(id value) {
        if ([value isKindOfClass:[NSString class]]) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"HH:mm"];
            
            NSDate *dt = [formatter dateFromString:value];
            [formatter setDateFormat:@"hh:mm a"];
            return [formatter stringFromDate:dt];
        }
        return value;
    } reverseMap:^id(id value) {
        return [NSString stringWithFormat:@"%@", value];
    }];
    return attr;
}@end
