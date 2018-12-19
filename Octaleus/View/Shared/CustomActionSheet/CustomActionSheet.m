

#import "CustomActionSheet.h"

@implementation CustomActionSheet

@synthesize lblTitle=_lblTitle;
@synthesize doneBarButton=_doneBarButton;
@synthesize cancelBarButton=_cancelBarButton;
@synthesize isViewOpen=_isViewOpen;
@synthesize tag;
@synthesize view=_view;
@synthesize delegate=_delegate;
@synthesize isFromDatePicker;
@synthesize showYPOS;
@synthesize hideYPOS;
@synthesize pickerViewWidth;
//@synthesize Fadeview;

+ (id)initIPadUIPickerWithTitle:(NSString *)title delegate:(id<CustomActionSheetDelegate>)delegate doneButtonTitle:(NSString *)doneButtonTitle cancelButtonTitle:(NSString *)cancelButtonTitle pickerView:(UIPickerView *)picker inView:(UIView *)view;{
    CustomActionSheet * actionSheet;
    
    if (IPAD) {
        actionSheet = [[[NSBundle mainBundle] loadNibNamed:@"CustomActionSheet" owner:nil options:nil] objectAtIndex:0];
        actionSheet.frame = CGRectMake(0,+1500,actionSheet.frame.size.width,actionSheet.frame.size.height);
        actionSheet.hideYPOS = +1400.0;
        actionSheet.showYPOS = 720.0;
        actionSheet.pickerViewWidth = 768.0;
    } else {
        actionSheet = [[[NSBundle mainBundle] loadNibNamed:@"CustomActionSheet_IPhone" owner:nil options:nil] objectAtIndex:0];
        actionSheet.frame = CGRectMake(0,+1300,[UIScreen mainScreen].bounds.size.width,actionSheet.frame.size.height);
        actionSheet.hideYPOS = +1300.0;
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        if ([UIScreen mainScreen].scale == 2.f && screenHeight == 568.0f) {
            actionSheet.showYPOS = 320.0;
            
            
        } else {
            actionSheet.showYPOS = [UIScreen mainScreen].bounds.size.height - actionSheet.frame.size.height-44;//230.0
            
        }
        
        actionSheet.pickerViewWidth = [UIScreen mainScreen].bounds.size.width;
    }
    
    
    actionSheet.view = view;
    
    actionSheet.isFromDatePicker = NO;
    actionSheet.delegate = delegate;
    actionSheet.pickerView = picker;
    
    
    actionSheet.lblTitle.text = title;
    
    for (UIView * sView in view.subviews) {
        if ([sView isKindOfClass:[CustomActionSheet class]]) {
            [sView removeFromSuperview];
            
        }
    }
    
    [view addSubview:actionSheet];
    
    [actionSheet.doneBarButton setTitle:doneButtonTitle];
    [actionSheet.cancelBarButton setTitle:cancelButtonTitle];
    
    return actionSheet;

}

+ (id)initIPadUIDatePickerWithTitle:(NSString *)title delegate:(id<CustomActionSheetDelegate>)delegate doneButtonTitle:(NSString *)doneButtonTitle cancelButtonTitle:(NSString *)cancelButtonTitle DatepickerView:(UIDatePicker *)picker inView:(UIView *)view withCustomDate:(NSDate *)date{
    
    CustomActionSheet * actionSheet;
    
    if (IPAD) {
        actionSheet = [[[NSBundle mainBundle] loadNibNamed:@"CustomActionSheetWithDatePicker" owner:nil options:nil] objectAtIndex:0];
        actionSheet.frame = CGRectMake(0,+1500,actionSheet.frame.size.width,actionSheet.frame.size.height);
        actionSheet.hideYPOS = +1400.0;
        actionSheet.showYPOS = 680.0;
        actionSheet.pickerViewWidth = 768.0;
    }else{
        actionSheet = [[[NSBundle mainBundle] loadNibNamed:@"CustomActionSheetDatePcker_IPhone" owner:nil options:nil] objectAtIndex:0];
        actionSheet.frame = CGRectMake(0,+1300,actionSheet.frame.size.width,actionSheet.frame.size.height);
        actionSheet.hideYPOS = +1300.0;
        
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        if ([UIScreen mainScreen].scale == 2.f && screenHeight == 568.0f) {
            actionSheet.showYPOS = 320.0;
            
        } else {
            actionSheet.showYPOS = 220.0;
            
        }
        
        
        
        actionSheet.pickerViewWidth = 320.0;
    }
    
    
    actionSheet.isFromDatePicker = YES;
    
    actionSheet.delegate = delegate;
    actionSheet.datePicker = picker;
    actionSheet.view = view;
    actionSheet.lblTitle.text = title;
    
    for (UIView * sView in view.subviews) {
        if ([sView isKindOfClass:[CustomActionSheet class]]) {
            [sView removeFromSuperview];
            
        }
    }
    
    
    
    [view addSubview:actionSheet];
    [actionSheet addSubview:picker];
    
    [actionSheet.doneBarButton setTitle:doneButtonTitle];
    [actionSheet.cancelBarButton setTitle:cancelButtonTitle];
    
    return actionSheet;

}


-(void)show{
    
    if (_isViewOpen) {
        
        self.pickerView.frame = CGRectMake(0,40,pickerViewWidth,260);
        
        [self addSubview:_pickerView];
        
        self.frame = CGRectMake(0,hideYPOS,self.frame.size.width,self.frame.size.height);
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:nil];
        [UIView setAnimationDuration:0.7];
        
        
        self.frame = CGRectMake(0,showYPOS,self.frame.size.width,self.frame.size.height);
        
    }else{
        
        
        self.frame = CGRectMake(0,showYPOS,self.frame.size.width,self.frame.size.height);
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:nil];
        [UIView setAnimationDuration:1.0];
        
        
        self.frame = CGRectMake(0,hideYPOS,self.frame.size.width,self.frame.size.height);
        [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.0];
    }
    _isViewOpen = !_isViewOpen;
    
    [UIView commitAnimations];
}

-(void)showDatePicker{
    if (_isViewOpen) {
        
        
        self.datePicker.frame = CGRectMake(0,45,pickerViewWidth,260);
        
        self.frame = CGRectMake(0,hideYPOS,self.frame.size.width,self.frame.size.height);
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:nil];
        [UIView setAnimationDuration:0.7];
        
        
        if (IPAD) {
            
        }else{
            
        }
        self.frame = CGRectMake(0,showYPOS,self.frame.size.width,self.frame.size.height);
        
    }else{
        
        
        self.frame = CGRectMake(0,showYPOS,self.frame.size.width,self.frame.size.height);
        
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:nil];
        [UIView setAnimationDuration:1.0];
        
        self.frame = CGRectMake(0,hideYPOS,self.frame.size.width,self.frame.size.height);
        
        
        [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.0];
    }
    _isViewOpen = !_isViewOpen;
    
    [UIView commitAnimations];
}

-(void)doneClicked:(id)sender{
    
    _isViewOpen = NO;
    
    if (isFromDatePicker) {
        [self showDatePicker];
    }else{
        [self show];
    }
    

    
    if (_delegate && [_delegate respondsToSelector:@selector(actionSheetDoneClickedWithActionSheet:)]) {
        [_delegate actionSheetDoneClickedWithActionSheet:self];
    }
}
-(void)cancelClicked:(id)sender{
    _isViewOpen = NO;
    

    
    if (isFromDatePicker) {
        [self showDatePicker];
    }else{
        [self show];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(actionSheetCancelClickedWithActionSheet:)]) {
        [_delegate actionSheetCancelClickedWithActionSheet:self];
    }
}

@end
