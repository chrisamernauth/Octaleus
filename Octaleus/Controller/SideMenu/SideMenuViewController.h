//
//  SideMenuViewController.h
//  Octaleus
//
//  Created by Rahul Soni on 13/02/16.
//  Copyright (c) 2016 Rahul Soni. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SideMenuDelegate <NSObject>

-(void)didSelectRowAtIndexPath:(NSIndexPath *)indexpath andNavigationController:(UINavigationController *)navigationController;

@end
@interface SideMenuViewController : UITableViewController

@property(nonatomic,strong)id<SideMenuDelegate>delegate;

+(SideMenuViewController *)initViewController:(id<SideMenuDelegate>)del;
@end
