//
//  DashboardViewController.h
//  Octaleus
//
//  Created by Rahul Soni on 07/01/16.
//  Copyright (c) 2016 Rahul Soni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCZBarViewController.h"
#import <ZBarSDK/ZBarSDK.h>
@interface DashboardViewController : UIViewController
{
    OCZBarViewController *reader;
    ZBarImageScanner *scanner;
}
@property (nonatomic,assign)NSTimeInterval timeInterval;
@property (weak, nonatomic) IBOutlet UITableView *sensorsTable;
@property (nonatomic, assign)BOOL isAlertOpen;
@property (nonatomic,strong)NSTimer *timer;
@end
