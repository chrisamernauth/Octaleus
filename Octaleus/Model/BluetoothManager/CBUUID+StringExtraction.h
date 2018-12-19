//  Octaleus
//
//  Created by Rahul Soni on 07/01/16.
//  Copyright (c) 2016 Rahul Soni. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE
#import <CoreBluetooth/CoreBluetooth.h>
#elif TARGET_OS_MAC
#import <IOBluetooth/IOBluetooth.h>
#endif

@interface CBUUID (StringExtraction)

/**
 * Converts 16bit and 128bit CBUUID to NSString representation
 * @return NSString representation of CBUUID
 */
- (NSString *)representativeString;

@end
