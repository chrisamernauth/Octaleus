//
//  LoginViewController.h
//  PallySmartFinder
//
//  Created by Rahul Soni on 21/11/15.
//  Copyright (c) 2015 Rahul Soni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountAuthenticateDelegate.h"
#import "LOAccount.h"
#import "AccountManager.h"
@interface LoginViewController : UIViewController<AccountAuthenticateDelegate>

@property(nonatomic,weak)IBOutlet UITextField *txtEmail;
@property(nonatomic,weak)IBOutlet UITextField *txtPassword;
@property(nonatomic,weak)IBOutlet UILabel *lblVersion;
+(LoginViewController *)initViewController;
-(IBAction)btnLoginClicked:(id)sender;
@end
