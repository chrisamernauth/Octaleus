//
//  iConsole.h
//
//  Created by Rahul Soni on 12/02/16.
//  Copyright (c) 2015 Rahul Soni. All rights reserved.

#import <UIKit/UIKit.h>


#import <Availability.h>
#undef weak_delegate
#if __has_feature(objc_arc_weak)
#define weak_delegate weak
#else
#define weak_delegate unsafe_unretained
#endif


#define ICONSOLE_ADD_EXCEPTION_HANDLER 1 //add automatic crash logging
#define ICONSOLE_USE_GOOGLE_STACK_TRACE 1 //use GTM functions to improve stack trace


typedef enum
{
    iConsoleLogLevelNone = 0,
    iConsoleLogLevelCrash,
    iConsoleLogLevelError,
    iConsoleLogLevelWarning,
    iConsoleLogLevelInfo
}
iConsoleLogLevel;


@protocol iConsoleDelegate <NSObject>

- (void)handleConsoleCommand:(NSString *)command;

@end


@interface iConsole : UIViewController

//enabled/disable console features

@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, assign) BOOL saveLogToDisk;
@property (nonatomic, assign) NSUInteger maxLogItems;
@property (nonatomic, assign) iConsoleLogLevel logLevel;
@property (nonatomic, weak_delegate) id<iConsoleDelegate> delegate;

//console activation

@property (nonatomic, assign) NSUInteger simulatorTouchesToShow;
@property (nonatomic, assign) NSUInteger deviceTouchesToShow;
@property (nonatomic, assign) BOOL simulatorShakeToShow;
@property (nonatomic, assign) BOOL deviceShakeToShow;

//branding and feedback

@property (nonatomic, copy) NSString *infoString;
@property (nonatomic, copy) NSString *inputPlaceholderString;
@property (nonatomic, copy) NSString *logSubmissionEmail;

//styling

@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, assign) UIScrollViewIndicatorStyle indicatorStyle;

//methods

+ (iConsole *)sharedConsole;

+ (void)log:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
+ (void)info:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
+ (void)warn:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
+ (void)error:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
+ (void)crash:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);

+ (void)log:(NSString *)format args:(va_list)argList;
+ (void)info:(NSString *)format args:(va_list)argList;
+ (void)warn:(NSString *)format args:(va_list)argList;
+ (void)error:(NSString *)format args:(va_list)argList;
+ (void)crash:(NSString *)format args:(va_list)argList;

+ (void)clear;

+ (void)show;
+ (void)hide;

@end


@interface iConsoleWindow : UIWindow

@end