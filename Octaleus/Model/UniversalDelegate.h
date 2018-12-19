//
//  UniversalDelegate.h
//  Circuit
//
//  Created by Samir Khatri on 5/26/14.
//  Copyright (c) 2014 Samir Khatri. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UniversalDelegate <NSObject>

- (void) DataAddedSuccessfully:(NSString *)message;
- (void) DataAddFailedWithError:(NSString*) error;

@end
