//
//  SideMenuViewController.m
//  Octaleus
//
//  Created by Rahul Soni on 13/02/16.
//  Copyright (c) 2016 Rahul Soni. All rights reserved.
//

#import "SideMenuViewController.h"
#import "MFSideMenu.h"
#import "iConsole.h"
#import "ProfileCell.h"
#import "MenuCell.h"
@interface SideMenuViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SideMenuViewController

+(SideMenuViewController *)initViewController:(id<SideMenuDelegate>)del{
    SideMenuViewController *controller = [[SideMenuViewController alloc]init];
    controller.delegate = del;
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:59.0/255.0f green:64.0/255.0f blue:82.0/255.0f alpha:1.0f];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

        return 48.0f;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
        static NSString *identifier = @"CustomCellIdentifier";
        MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MenuCell" owner:self options:nil];
            
            for (id currentObject in topLevelObjects){
                if ([currentObject isKindOfClass:[UITableViewCell class]])
                {
                    cell =  (MenuCell *) currentObject;
                    break;
                }
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.iconImgView.image = [UIImage imageNamed:@"check-in-icon.png"];
        cell.lblTitle.text = @"BT-Connect";
    }else if (indexPath.row ==1){
        cell.iconImgView.image = [UIImage imageNamed:@"timer-48.png"];
        cell.lblTitle.text = @"Timer";
    }else if (indexPath.row ==2){
        cell.iconImgView.image = [UIImage imageNamed:@"quote.png"];
        cell.lblTitle.text = @"Log";
    }else if (indexPath.row == 3){
        cell.iconImgView.image = [UIImage imageNamed:@"about-icon.png"];
        cell.lblTitle.text = @"About";
    }else if (indexPath.row == 4){
        cell.iconImgView.image = [UIImage imageNamed:@"log-out-icon.png"];
        cell.lblTitle.text = @"Logout";
    }
        return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.menuContainerViewController toggleRightSideMenuCompletion:^{
        
    }];
    UINavigationController *navigationController;
    if ([self.menuContainerViewController.centerViewController isKindOfClass:[UINavigationController class]]) {
        navigationController = self.menuContainerViewController.centerViewController;
        if (_delegate && [_delegate respondsToSelector:@selector(didSelectRowAtIndexPath:andNavigationController:)]) {
            [_delegate didSelectRowAtIndexPath:indexPath andNavigationController:navigationController];
           
        }
    }
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
}

@end
