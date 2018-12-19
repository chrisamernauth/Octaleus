//
//  UIViewController+MFSideMenuAdditions.h
//  MFSideMenuDemoBasic
//
//

#import <UIKit/UIKit.h>
@class MFSideMenuContainerViewController;

// category on UIViewController to provide reference to the menuContainerViewController in any of the contained View Controllers
@interface UIViewController (MFSideMenuAdditions)

@property(nonatomic,readonly,retain) MFSideMenuContainerViewController *menuContainerViewController;

@end

