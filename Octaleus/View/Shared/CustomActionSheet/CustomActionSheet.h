

#import <UIKit/UIKit.h>
#import "AMTTimePicker.h"

#import "CustomActionSheetDelegate.h"
@class CustomActionSheet;

#define IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad



@interface CustomActionSheet : UIView
{
    IBOutlet UIPickerView * _pickerView;
    id<CustomActionSheetDelegate> _delegate;
    UIView *_view;
    NSInteger tag;
    IBOutlet UILabel * _lblTitle;
    IBOutlet UIBarButtonItem * _doneBarButton;
    IBOutlet UIBarButtonItem * _cancelBarButton;
    BOOL _isViewOpen;
    IBOutlet UIDatePicker * _datePicker;
    BOOL isFromDatePicker;
    
    
    float hideYPOS;
    float showYPOS;
    float pickerViewWidth;
    
}
@property (nonatomic ,assign) float pickerViewWidth;
@property (nonatomic ,assign) float hideYPOS;
@property (nonatomic ,assign) float showYPOS;
@property (nonatomic, retain) UIPickerView *pickerView;
@property (nonatomic, assign) NSInteger tag;
@property (nonatomic ,retain) UILabel * lblTitle;
@property (nonatomic ,retain) UIView * view;
@property (nonatomic ,retain) id<CustomActionSheetDelegate> delegate;
@property (nonatomic ,retain) UIBarButtonItem * doneBarButton;
@property (nonatomic ,retain) UIBarButtonItem * cancelBarButton;
@property (nonatomic ,retain) UIDatePicker * datePicker;
@property (nonatomic ,assign) BOOL isViewOpen;
@property (nonatomic ,assign) BOOL isFromDatePicker;
+ (id)initIPadUIPickerWithTitle:(NSString *)title delegate:(id<CustomActionSheetDelegate>)delegate doneButtonTitle:(NSString *)doneButtonTitle cancelButtonTitle:(NSString *)cancelButtonTitle pickerView:(UIPickerView *)picker inView:(UIView *)view;

+ (id)initIPadUIDatePickerWithTitle:(NSString *)title delegate:(id<CustomActionSheetDelegate>)delegate doneButtonTitle:(NSString *)doneButtonTitle cancelButtonTitle:(NSString *)cancelButtonTitle DatepickerView:(UIDatePicker *)picker inView:(UIView *)view withCustomDate:(NSDate *)date;

- (IBAction)doneClicked:(id)sender;
- (IBAction)cancelClicked:(id)sender;

//- (IBAction)datePickerSelected:(id)sender;

- (void)show;
- (void)showDatePicker;
@end
