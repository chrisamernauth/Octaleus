//
//  CircuitNavigationBar.h
//  Circuit
//
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface CircuitNavigationBar : UINavigationBar< UINavigationBarDelegate>
{
    BOOL _shouldAcceptItem;
    id<UINavigationBarDelegate> _secondDelegate;
}


@end
