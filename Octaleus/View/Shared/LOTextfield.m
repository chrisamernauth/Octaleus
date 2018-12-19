//
//  LOTextfield.m
//  PallySmartFinder
//
//  Created by Rahul Soni on 21/11/15.
//  Copyright (c) 2015 Rahul Soni. All rights reserved.
//

#import "LOTextfield.h"

@implementation LOTextfield

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 10 , 10 );
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 10 , 10 );
}

@end
