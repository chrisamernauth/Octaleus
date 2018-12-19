//
//  CircuitNavigationBar.m
//  Circuit
//
//  Created by Samir Khatri on 7/12/14.
//  Copyright (c) 2014 Samir Khatri. All rights reserved.
//

#import "CircuitNavigationBar.h"

@implementation CircuitNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)awakeFromNib{

}
#pragma mark - UINavigationBarDelegate

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPushItem:(UINavigationItem *)item
{
    
    if (item.leftBarButtonItems == nil) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setBackgroundColor:[UIColor whiteColor]];
        backButton.tintColor = [UIColor whiteColor];
         [backButton setImage:[UIImage imageNamed:@"back_button.png"] forState:UIControlStateNormal];        backButton.frame = CGRectMake(10, 0, 30, 30);
        [backButton addTarget:[AppDelegate appDelegate] action:@selector(navigationPop) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        item.leftBarButtonItem.tintColor = [UIColor blueColor];
        [item setLeftBarButtonItem:back];
        
    }
    
    if ([_secondDelegate respondsToSelector:@selector(navigationBar:shouldPushItem:)])
        return TRUE && [_secondDelegate navigationBar:navigationBar shouldPushItem:item];
    else
        return TRUE;
}


- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item{
    return  YES;
}
- (void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(UINavigationItem *)item
{
        // return YES;
}

@end
