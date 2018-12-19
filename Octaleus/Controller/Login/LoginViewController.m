//
//  LoginViewController.m
//  PallySmartFinder
//
//  Created by Rahul Soni on 21/11/15.
//  Copyright (c) 2015 Rahul Soni. All rights reserved.
//

#import "LoginViewController.h"
#import "DeviceManager.h"
#import <Parse/Parse.h>
#import "ParseHelper.h"
#import "SVProgressHUD.h"
#import "Constant.h"
#import "DataUtility.h"
#import "AppDelegate.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

+(LoginViewController *)initViewController{
    LoginViewController *controller = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _lblVersion.text = [NSString stringWithFormat:@"Version %@",[DataUtility getAppVersion]];
    // Do any additional setup after loading the view from its nib.
}

-(void)btnLoginClicked:(id)sender{
    NSString *message;
    if (_txtEmail.text.length <= 0) {
        message = @"Please enter email";
    }else if ([DataUtility isEmailValid:_txtEmail.text]){
        message = @"Please enter valid email";
    }else if (_txtPassword.text.length <= 0){
        message = @"Please enter password";
    }
    if (message.length > 0) {
        UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:ALERT_TITLE message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertview show];
    }else{
        LOAccount *account = [[LOAccount alloc]init];
        [SVProgressHUD showWithStatus:@"Logging in..."];
        [account authenticateWithusername:_txtEmail.text andPassword:_txtPassword.text withDelegate:self];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -AccountAuthenticateDelegate
-(void)accountAuthenticatedWithAccount:(LOAccount *)account{
    [SVProgressHUD dismiss];
    [AccountManager Instance].activeAccount = account;
    //[self loginWithParse:account];
    [[AppDelegate appDelegate]userdidLogin];
    [[DeviceManager sharedInstance]loginWithEmail:@"info@octaleus.com" andPassword:@"octaleus" andBlock:^(BOOL success,id data ,NSError *error) {
        
    }];
}

-(void)accountDidFailAuthentication:(NSError *)error{
    [SVProgressHUD dismiss];
    NSString *alert_error = [error.userInfo objectForKey:@"message"];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:ALERT_TITLE message:alert_error delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alertView show];
}

-(void)loginWithParse:(LOAccount *)account{
    [[ParseHelper sharedInstance]loginWithUsername:account.user_name andPassword:account.password andblock:^(BOOL success, NSError *error) {
        if (success) {
           PFInstallation *currentInstallation = [PFInstallation currentInstallation];
            [currentInstallation setObject:[PFUser currentUser] forKey:@"user"];
            [currentInstallation saveInBackground];
            NSLog(@"User Logged In");
        }
    }];
}

@end
