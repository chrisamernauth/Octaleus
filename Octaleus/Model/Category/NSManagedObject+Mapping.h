//
//  NSManagedObject+Mapping.h
//  Octaleus
//
//  Created by Rahul Soni on 03/03/16.
//  Copyright (c) 2016 Rahul Soni. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <FastEasyMapping/FastEasyMapping.h>
#import <objc/runtime.h>
@interface NSManagedObject (Mapping)
+ (FEMAttribute*) floatAttributeFor:(NSString*)property andKeyPath:(NSString*)keyPath;

+ (FEMAttribute*) doubleAttributeFor:(NSString*)property andKeyPath:(NSString*)keyPath;

+ (FEMAttribute*) intAttributeFor:(NSString*)property andKeyPath:(NSString*)keyPath;

+ (FEMAttribute*) boolAttributeFor:(NSString*)property andKeyPath:(NSString*)keyPath;

+ (FEMAttribute*) dateTimeAttributeFor:(NSString*)property andKeyPath:(NSString*)keyPath;

+ (FEMAttribute*) timeAttributeFor:(NSString*)property andKeyPath:(NSString*)keyPath;
@end
