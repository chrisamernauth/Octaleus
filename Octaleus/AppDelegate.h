//
//  AppDelegate.h
//  Octaleus
//
//  Created by Rahul Soni on 07/01/16.
//  Copyright (c) 2016 Rahul Soni. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MagicalRecord/MagicalRecord.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic)IBOutlet UIWindow *window;
@property (nonatomic,strong)IBOutlet UINavigationController *navigationController;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

+(AppDelegate*)appDelegate;
-(void)showLogin:(BOOL)animated;
-(void)userdidLogin;
-(void)logout;
@end

