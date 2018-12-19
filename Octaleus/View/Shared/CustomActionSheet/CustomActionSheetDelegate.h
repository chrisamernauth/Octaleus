


#import <Foundation/Foundation.h>
@class CustomActionSheet;
@protocol CustomActionSheetDelegate <NSObject>

- (void)actionSheetDoneClickedWithActionSheet:(CustomActionSheet *)actionSheet;
- (void)actionSheetCancelClickedWithActionSheet:(CustomActionSheet *)actionSheet;


@end


