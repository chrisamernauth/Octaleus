//
//  CDHelper.m
//  Octaleus
//
//  Created by Rahul Soni on 03/03/16.
//  Copyright (c) 2016 Rahul Soni. All rights reserved.
//

#import "CDHelper.h"

@implementation CDHelper
+ (NSDictionary*) mappingForClass:(Class)cls
{
    NSDictionary *dictRoot = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Mapping" ofType:@"plist"]];
    NSDictionary *keys = [dictRoot objectForKey:NSStringFromClass(cls)];
    return keys;
}
@end
