//
//  UIViewController+MFSideMenuAdditions.m
//  MFSideMenuDemoBasic
//
//

#import "UIViewController+MFSideMenuAdditions.h"
#import "MFSideMenuContainerViewController.h"

@implementation UIViewController (MFSideMenuAdditions)

@dynamic menuContainerViewController;

- (MFSideMenuContainerViewController *)menuContainerViewController {
    id containerView = self;
    while (![containerView isKindOfClass:[MFSideMenuContainerViewController class]] && containerView) {
        if ([containerView respondsToSelector:@selector(parentViewController)])
            containerView = [containerView parentViewController];
        if ([containerView respondsToSelector:@selector(splitViewController)] && !containerView)
            containerView = [containerView splitViewController];
    }
    return containerView;
}

@end