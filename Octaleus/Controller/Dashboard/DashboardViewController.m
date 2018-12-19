//
//  DashboardViewController.m
//  Octaleus
//
//  Created by Rahul Soni on 07/01/16.
//  Copyright (c) 2016 Rahul Soni. All rights reserved.
//

#import "DashboardViewController.h"
#import "AMTTimePicker.h"
#import "CustomActionSheet.h"
#import "TrackerAccount.h"
#import "TrackerDevice.h"
#import "DeviceManager.h"
#import "SideMenuViewController.h"
#import "MFSideMenu.h"
#import "iConsole.h"
#import <Parse/Parse.h>
#import "ServiceList.h"
#import "Constant.h"
#import "LOAccount.h"
#import "NexGenDevice.h"
#import "LGBluetooth.h"
#import "AccountManager.h"
#import "BLEDevice.h"
#import "SVProgressHUD.h"
#import "Constant.h"
#import "DataUtility.h"
#import "KitLocateTasker.h"
#import "AppDelegate.h"
#import "NSData+FastHex.h"
#import "LocationTracking.h"
#import "BleCell.h"
@interface DashboardViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDelegate,UITableViewDataSource,PeriodicLocationUpdater,UIAlertViewDelegate,iConsoleDelegate,SideMenuDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ZBarReaderDelegate,CustomActionSheetDelegate,AMTTimePickerDelegate>{
    NSString *systemId;
    NSString *batteryLevel;
}
@property (nonatomic, strong)AMTTimePicker *timepicker;
@property (nonatomic, strong) NSMutableArray *discoveredPeripherals;
@property (nonatomic, strong) NSMutableArray *connectedPeripherals;
@property (nonatomic, strong) NSMutableArray *peripheralsRSSI;

@property(nonatomic, strong) UIAlertView *logoutAlertView;
@property(nonatomic) NSUInteger logoutTimeRemaining;
@property(nonatomic,strong)UIPickerView *picker;
@property(nonatomic,strong)NSMutableArray *pickerArray;
@property(nonatomic,assign)BOOL isNexGenDevice;
@end

@implementation DashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isNexGenDevice = false;
    [self setupMenuBarButtonItems];
    [LGCentralManager sharedInstance];
    LOAccount *account = [AccountManager Instance].activeAccount;
    [[KitLocateTasker Instance]initWithKitDelegate:self];
    if (account != nil) {
        
    }
    self.timepicker = [[AMTTimePicker alloc]init];
    self.timepicker.delegate = self;
    NSString *str = [DataUtility getTimeIntervalForKey];
    [self.timepicker setTimeInterval:[str integerValue]];
    reader = [[OCZBarViewController alloc] init];
    reader.readerDelegate = self;
    reader.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    scanner = reader.scanner;
    reader.cameraOverlayView=[self setOverlayButton];
    [scanner setSymbology: ZBAR_I25 config: ZBAR_CFG_ENABLE to: 0];
    [iConsole sharedConsole].delegate = self;
    //[self.sensorsTable setEditing:YES animated:YES];
    self.isAlertOpen = NO;
    _pickerArray = [DataUtility getTimerArray];
   
    self.connectedPeripherals = [@[] mutableCopy];
    self.peripheralsRSSI = [@[] mutableCopy];
    [self reconnectOldPeripheralOnStarting];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(peripheralDidDisconnect:) name:kLGPeripheralDidDisconnect object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reconnectWithOldPeripheralWithTimer) name:k_RECONNECT_DEVICE object:nil];
    [self setNavigationItem];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)setNavigationItem{
//    UIButton *buttonLogout = [UIButton buttonWithType:UIButtonTypeCustom];
//    buttonLogout.frame = CGRectMake(0,0,30,30);
//    [buttonLogout setImage:[UIImage imageNamed:@"1450827682_on-off.png"] forState:UIControlStateNormal];
//    [buttonLogout addTarget:self action:@selector(Logout) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *logout = [[UIBarButtonItem alloc]initWithCustomView:buttonLogout];
//    //
    UIButton *leftMenuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftMenuButton setImage:[UIImage imageNamed:@"menu-icon.png"] forState:UIControlStateNormal];
    
    leftMenuButton.frame = CGRectMake(0, 0, 40, 30);
    [leftMenuButton addTarget:self action:@selector(leftSideMenuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftMenuBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftMenuButton];
    
    UIButton *buttonTimer = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [[buttonTimer.widthAnchor constraintEqualToConstant:30] setActive:true];
    [[buttonTimer.heightAnchor constraintEqualToConstant:30] setActive:true];
    
    [buttonTimer setImage:[UIImage imageNamed:@"1450833619_miscellaneous-23.png"] forState:UIControlStateNormal];
    //[buttonTimer addTarget:self action:@selector(openTimePicker) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *timer = [[UIBarButtonItem alloc]initWithCustomView:buttonTimer];
    
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [fixedSpace setWidth:15.0f];
    int mins = [[NSString stringWithFormat:@"%@ Mins",[DataUtility getTimeIntervalForKey]] intValue]/60;
    UIBarButtonItem *timerLabel = [[UIBarButtonItem alloc]initWithTitle:[NSString stringWithFormat:@"%d Mins",mins] style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItems = @[leftMenuBarButtonItem,fixedSpace,timer,timerLabel];
    
    UIBarButtonItem *add_button = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addMultipleDevice)];
    self.navigationItem.rightBarButtonItems = @[add_button];
}




-(void)addMultipleDevice{
    __weak DashboardViewController *weakself = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:ALERT_TITLE message:@"Please add one of the following Device" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *addPally = [UIAlertAction actionWithTitle:@"Add Octal Blue Device" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [weakself addDevice];
    }];
    UIAlertAction *addiTraq = [UIAlertAction actionWithTitle:@"Add Octal Cell Device" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        weakself.isNexGenDevice = false;
        [weakself scanForDevice];
    }];
    UIAlertAction *addNexGen = [UIAlertAction actionWithTitle:@"Add Nexgen Device" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        weakself.isNexGenDevice = true;
        [weakself scanForDevice];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    [alertController addAction:addPally];
    [alertController addAction:addiTraq];
    [alertController addAction:addNexGen];
    [alertController addAction:cancel];
    [self presentViewController:alertController  animated:YES completion:nil];
}

-(void)scanForDevice{
    [self presentViewController:reader animated:YES completion:^{
        
    }];
}

- (void)setupMenuBarButtonItems {
    if(self.menuContainerViewController.menuState == MFSideMenuStateClosed &&
       ![[self.navigationController.viewControllers objectAtIndex:0] isEqual:self]) {
    } else {
        //self.navigationItem.leftBarButtonItem = [self leftMenuBarButtonItem];
    }
}
//- (UIBarButtonItem *)leftMenuBarButtonItem {
//    UIButton *leftMenuButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [leftMenuButton setImage:[UIImage imageNamed:@"menu-icon.png"] forState:UIControlStateNormal];
//    leftMenuButton.frame = CGRectMake(0, 0, 40, 30);
//    [leftMenuButton addTarget:self action:@selector(leftSideMenuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *leftMenuBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftMenuButton];
//    return leftMenuBarButtonItem;
//}

- (void)leftSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
        [self setupMenuBarButtonItems];
    }];
}

- (UIView *)setOverlayButton{
    UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height)];
    [v setBackgroundColor:[UIColor clearColor]];
    
    UIButton * btntorch =[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 60, 20,60,60)];
    [btntorch addTarget:self action:@selector(torchButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage __autoreleasing *torch = [UIImage imageNamed:@"torch.png"];
    [btntorch setImage:torch forState:UIControlStateNormal];
    [btntorch setImage:torch forState:UIControlStateHighlighted];
    [v addSubview:btntorch];
    torch = nil;
    btntorch = nil;
    return  v;
}

-(void)torchButtonClicked{
    if (reader.cameraFlashMode == UIImagePickerControllerCameraFlashModeOff) {
        reader.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn;
    }else{
        reader.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
    }
}

-(void)Logout{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:ALERT_TITLE message:@"Are you sure you want to logout?" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[AppDelegate appDelegate]logout];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    [alertController addAction:ok];
    [alertController addAction:cancel];
    [self presentViewController:alertController  animated:YES completion:nil];
}

//-(void)openTimePicker{
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Select Time Interval\n\n\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    _picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0,10, alertController.view.frame.size.width, alertController.view.frame.size.height)];
//    ;
//    _picker.delegate = self;
//    _picker.dataSource = self;
//    if ([_pickerArray containsObject:[DataUtility getTimeIntervalForKey]]) {
//        int index = (int)[_pickerArray indexOfObject:[DataUtility getTimeIntervalForKey]];
//        [_picker selectRow:index inComponent:0 animated:YES];
//    }
//    [alertController.view addSubview:_picker];
//    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        NSLog(@"OK");
//        int index = (int)[_picker selectedRowInComponent:0];
//        NSString *timeInterval = [_pickerArray objectAtIndex:index];
//        [DataUtility saveTimeIntervalForKey:timeInterval];
//        [[KitLocateTasker Instance]setPeriodicTimeInterval:timeInterval.intValue*60];
//        [self setNavigationItem];
//    }];
//    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//        
//    }];
//    [alertController addAction:action];
//    [alertController addAction:cancel];
//    [self presentViewController:alertController  animated:YES completion:nil];
//}
-(void)reconnectOldPeripheralOnStarting{
    NSArray	*storedDevices	= [BLEDevice fetchIdentifiers];
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (NSString *str in storedDevices) {
        NSUUID *identifier = [[NSUUID alloc]initWithUUIDString:str];
        [arr addObject:identifier];
    }
   NSArray *foundPeripherals = [[LGCentralManager sharedInstance]retrievePeripheralsWithIdentifiers:arr];
    if (foundPeripherals.count>0) {
        for (LGPeripheral *peripheral in foundPeripherals) {
            if ([BLEDevice isPeripheralExist:peripheral.UUIDString]) {
                [self reConnectPeripheral:peripheral];
            }
        }
    }
}
-(void)openPickerWithTag:(NSInteger)tag{
    CustomActionSheet *actionsheet = [CustomActionSheet initIPadUIPickerWithTitle:@"Select Time" delegate:self doneButtonTitle:@"Done" cancelButtonTitle:@"Cancel" pickerView:self.timepicker inView:self.view];
    actionsheet.delegate = self;
    actionsheet.isViewOpen = YES;
    actionsheet.tag = tag;
    [actionsheet show];
}

-(void)actionSheetDoneClickedWithActionSheet:(CustomActionSheet *)actionSheet{
    [DataUtility saveTimeIntervalForKey:[NSString stringWithFormat:@"%d",(int)self.timeInterval]];
    [[KitLocateTasker Instance]setPeriodicTimeInterval:self.timeInterval];
    [self setNavigationItem];
}

-(void)actionSheetCancelClickedWithActionSheet:(CustomActionSheet *)actionSheet{
    
}

-(void)amtTimePicker:(AMTTimePicker *)picker didSelectTime:(NSTimeInterval)timeInterval{
    self.timeInterval = timeInterval;
}
-(void)retrievePeripheralWithIdentifier:(NSString *)identifier{
    NSMutableArray *arr = [[NSMutableArray alloc]initWithObjects:identifier, nil];
    
    NSArray *foundPeripherals = [[LGCentralManager sharedInstance]retrievePeripheralsWithIdentifiers:arr];
    if (foundPeripherals.count>0) {
        for (LGPeripheral *peripheral in foundPeripherals) {
            if ([BLEDevice isPeripheralExist:peripheral.UUIDString]) {
                [self reConnectPeripheral:peripheral];
            }
        }
    }
}

-(void)reconnectWithOldPeripheralWithTimer{
    NSArray	*storedDevices	= [BLEDevice fetchIdentifiers];
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (NSString *str in storedDevices) {
        NSUUID *identifier = [[NSUUID alloc]initWithUUIDString:str];
        [arr addObject:identifier];
    }
    NSArray *foundPeripherals = [[LGCentralManager sharedInstance]retrievePeripheralsWithIdentifiers:arr];
    if (foundPeripherals.count>0) {
        for (LGPeripheral *peripheral in foundPeripherals) {
            if ([BLEDevice isPeripheralExist:peripheral.UUIDString]) {
                if (!peripheral.isConnected) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                         [self connnectLostPeripheral:peripheral];
                    });
                    
                   
                }
                
            }
        }
    }
}
-(void)reConnectPeripheral:(LGPeripheral *)peripheral{
    __weak DashboardViewController *weakSelf = self;
    [peripheral connectWithCompletion:^(NSError *error) {
        // Discovering services of peripheral
        [peripheral discoverServicesWithCompletion:^(NSArray *services, NSError *error) {
            for (LGService *service in services) {
                
                NSLog(@"XXXX%@",service.UUIDString);
                if ([service.UUIDString isEqualToString:@"ace0"]) {
                    // Discovering characteristics of our service
                    [service discoverCharacteristicsWithCompletion:^(NSArray *characteristics, NSError *error) {
                        for (LGCharacteristic *charact in characteristics) {
                            NSLog(@"XXXX%@",charact.UUIDString);
                            // cef9 is a writabble characteristic, lets test writting
                            if ([charact.UUIDString isEqualToString:@"ace4"]) {
                                [charact setNotifyValue:YES completion:^(NSError *error) {
                                    NSString *passCode = @"10EB786235";
                                    NSData *hexdata = [NSData dataWithHexString:passCode];
                                    [LGUtils writeData:hexdata charactUUID:@"ACE5" serviceUUID:@"ACE0" peripheral:peripheral completion:^(NSError *error) {
                                        if (![self.connectedPeripherals containsObject:peripheral]) {
                                            [self.connectedPeripherals addObject:peripheral];
                                            [weakSelf.sensorsTable reloadData];
                                        }
                                        
                                        
                                    }];
                                } onUpdate:^(NSData *data, NSError *error) {
                                    
                                }];
                                
                                
                                
                            }
                        }
                    }];
                }
            }
        }];
    }];
}
-(void)addDevice{
    self.logoutAlertView = [[UIAlertView alloc] initWithTitle:@"Scanning"
                                                      message:@"Ready to add device.Please press the button on the device to activate them"
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:nil];
    [LGCentralManager sharedInstance].peripheralsCountToStop = 1;
    [[LGCentralManager sharedInstance] scanForPeripheralsByInterval:30
                                                         completion:^(NSArray *peripherals)
     {
         // If we found any peripherals sending to test
         if (peripherals.count) {
             if (![self.connectedPeripherals containsObject:peripherals]) {
                 [self testPeripheral:peripherals[0]];
             }
             
         }
     }];

    
    
    [self.logoutAlertView show];
}
- (void)testPeripheral:(LGPeripheral *)peripheral
{
    // First of all connecting to peripheral
  
        [peripheral connectWithCompletion:^(NSError *error) {
           
            // Discovering services of peripheral
            __block int i =0;
            __weak DashboardViewController *weakSelf = self;
            [peripheral discoverServicesWithCompletion:^(NSArray *services, NSError *error) {
                for (LGService *service in services) {
                    i++;
                    NSLog(@"Service %d",i);
                    // Finding out our service
                    NSLog(@"XXXX%@",service.UUIDString);
                    if ([service.UUIDString isEqualToString:@"ace0"]) {
                        // Discovering characteristics of our service
                        [service discoverCharacteristicsWithCompletion:^(NSArray *characteristics, NSError *error) {
                            for (LGCharacteristic *charact in characteristics) {
                                NSLog(@"XXXX%@",charact.UUIDString);
                                // cef9 is a writabble characteristic, lets test writting
                                if ([charact.UUIDString isEqualToString:@"ace4"]) {
                                     [weakSelf callTimer];
                                    [charact setNotifyValue:YES completion:^(NSError *error) {
                                        
                                    } onUpdate:^(NSData *data, NSError *error) {
                                        NSString *string = [data hexStringRepresentation];
                                        if ([string isEqual:@"01"]) {
                                            NSString *passCode = @"10EB786235";
                                            NSData *hexdata = [NSData dataWithHexString:passCode];
                                            [LGUtils writeData:hexdata charactUUID:@"ACE5" serviceUUID:@"ACE0" peripheral:peripheral completion:^(NSError *error) {
                                                if (![self.connectedPeripherals containsObject:peripheral]) {
                                                    [self.connectedPeripherals addObject:peripheral];
                                                    BLEDevice *ap = [BLEDevice newEntity];
                                                    ap.name = peripheral.name;
                                                    ap.identifier = peripheral.UUIDString;
                                                    [BLEDevice saveDevice];
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        
                                                        [weakSelf readSystemID:peripheral];
                                                        [weakSelf.sensorsTable reloadData];
                                                    });
                                                    
                                                    [weakSelf stopTimer];
                                                }
                                                
                                            }];
                                        }
                                    }];
                                    
                                    
                                    
                                }
                            }
                        }];
                    }
                }
            }];
        }];
    
}
-(void)readSystemID:(LGPeripheral *)peripheral{
    [LGUtils readDataFromCharactUUID:@"2A23" serviceUUID:@"180A" peripheral:peripheral completion:^(NSData *data, NSError *error) {
        NSString *string = [data hexStringRepresentation];
        NSLog(@"Syetem Id %@",string);
        BLEDevice *ap = [BLEDevice getPeripheralFromUUID:peripheral.UUIDString];
        ap.systemId = string;
        [BLEDevice saveDevice];
        [self readBatteryLevel:peripheral];
        [self.sensorsTable reloadData];
        
    }];
}

-(void)sendPushToDevice{
    PFQuery *pushQuery = [PFInstallation query];
    NSLog(@"User %@",[[PFUser currentUser]objectId]);
    [pushQuery whereKey:@"user" equalTo:[PFUser currentUser]];
    NSString * alert = [NSString stringWithFormat:@"You have a new message from %@!", [PFUser currentUser].username];
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                          alert, @"alert",
                          @"default", @"sound",
                          @"Increment", @"badge",
                          nil];
    PFPush *push = [[PFPush alloc] init];
    [push setQuery:pushQuery];
    [push setData:data];
    [push sendPushInBackground];
}

-(void)readBatteryLevel:(LGPeripheral *)peripheral{
    [LGUtils readDataFromCharactUUID:@"2A19" serviceUUID:@"180F" peripheral:peripheral completion:^(NSData *data, NSError *error) {
         uint8_t level;
        [data getBytes:&level length:sizeof(level)];
        NSString *string = [NSString stringWithFormat:@"%d%%",level];;
        NSLog(@"Battery Level %@",string);
        BLEDevice *ap = [BLEDevice getPeripheralFromUUID:peripheral.UUIDString];
        ap.batteryLevel = string;
        [BLEDevice saveDevice];
        [self.sensorsTable reloadData];
    }];
}
-(void)peripheralDidDisconnect:(NSNotification *)notification{
    
    if ([notification.object isKindOfClass:[LGPeripheral class]]) {
        LGPeripheral *peripheral = (LGPeripheral *)notification.object;
        if ([self isPeripheralExist:peripheral.UUIDString]) {
                //[self sendPushToDevice];
                [self.connectedPeripherals removeObject:peripheral];
                [self retrievePeripheralWithIdentifier:peripheral.UUIDString];
            }
        
        
            [self.sensorsTable reloadData];
    }
}
-(BOOL)isPeripheralExist:(NSString *)uuid{
    NSArray *arr = [self.connectedPeripherals valueForKey:@"UUIDString"];
    if ([arr containsObject:uuid]) {
        return YES;
    }
    return NO;
    
}
-(void)callTimer{
    self.logoutTimeRemaining = 14;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                  target:self
                                                selector:@selector(updateAlert:)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)updateAlert:(NSTimer *)timer {
    self.logoutTimeRemaining--;
    NSLog(@"Timer %lu",(unsigned long)self.logoutTimeRemaining);
    self.logoutAlertView.message = [NSString stringWithFormat:@"Please press the button on device until bonding is confirmed %lu seconds", (unsigned long)self.logoutTimeRemaining];
    
    if (self.logoutTimeRemaining <= 0 || self.logoutTimeRemaining > 13) {
        [self stopTimer];
    }
}
-(void)stopTimer{
    _isAlertOpen = false;
    if ([self.timer isValid]) {
        [self.timer invalidate];
        self.logoutTimeRemaining = 14;
        self.timer = nil;
        [self.logoutAlertView dismissWithClickedButtonIndex:0 animated:YES];
           }else{
        [self.timer invalidate];
        self.logoutTimeRemaining = 14;
        self.timer = nil;
        
        [self.logoutAlertView dismissWithClickedButtonIndex:0 animated:YES];
    }
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"Octal Blue Device";
    }else if (section == 1){
        return @"Octal Cell Device";
    }else{
        return @"Nexgen Device";
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     NSInteger	res = 0;
    if (section == 0) {
        res = [[BLEDevice fetchAll]count];
    }else if (section == 1){
        res = [[TrackerDevice fetchAll]count];
    }else{
        res = [[NexGenDevice fetchAll]count];
    }
   
    return res;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier = @"CustomCellIdentifier";
    BleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"BleCell" owner:self options:nil];
        
        for (id currentObject in topLevelObjects){
            if ([currentObject isKindOfClass:[UITableViewCell class]])
            {
                cell =  (BleCell *) currentObject;
                break;
            }
        }
    }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        LGPeripheral	*peripheral;
        NSArray			*devices;
        NSArray         *connectedperipheral;
        NSInteger		row	= [indexPath row];
        devices = [BLEDevice fetchAll];//[[LeDiscovery sharedInstance] connectedPeripherals];
        connectedperipheral = [self.connectedPeripherals valueForKey:@"UUIDString"];
        BLEDevice *ble = [devices objectAtIndex:row];
        [cell.name setText:ble.name];
        [cell.uuid setText:ble.systemId];
        
        
        if ([connectedperipheral containsObject:ble.identifier]) {
            
            int index = (int)[connectedperipheral indexOfObject:ble.identifier];
            peripheral = [_connectedPeripherals objectAtIndex:index];
            if ([peripheral isConnected]) {
                [cell.status setText:@"Connected"];
                cell.status.textColor = [UIColor greenColor];
                
            }else{
                [cell.status setText:@"Not Connected"];
                cell.status.textColor = [UIColor redColor];
            }
            
            //[peripheral readRSSI];
        }else{
            [cell.status setText:@"Not Connected"];
            cell.status.textColor = [UIColor redColor];
        }
    }else if (indexPath.section == 1){
        TrackerDevice *dev = [[TrackerDevice fetchAll] objectAtIndex:indexPath.row];
        [cell.name setText:dev.name];
        [cell.uuid setText:dev.serialId];
        [cell.status setText:@"Connected"];
        cell.status.textColor = [UIColor greenColor];
    }
    else{
        NexGenDevice *dev = [[NexGenDevice fetchAll] objectAtIndex:indexPath.row];
        [cell.name setText:dev.serial_id];
        [cell.uuid setText:dev.tracker_id];
        [cell.status setText:@"Connected"];
        cell.status.textColor = [UIColor greenColor];
    }
   
        //cell.RSSI.text = [NSString stringWithFormat:@"%@",[peripheral RSSI]];
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (indexPath.section == 0) {
            LGPeripheral    *peripheral;
            NSArray            *devices;
            NSArray         *connectedperipheral;
            devices = [BLEDevice fetchAll];
            BLEDevice *ble = [devices objectAtIndex:indexPath.row];
            
            connectedperipheral = [self.connectedPeripherals valueForKey:@"UUIDString"];
            __weak DashboardViewController *weakSelf = self;
            if ([connectedperipheral containsObject:ble.identifier]) {
                int index = (int)[connectedperipheral indexOfObject:ble.identifier];
                peripheral = [_connectedPeripherals objectAtIndex:index];
                [peripheral disconnectWithCompletion:^(NSError *error) {
                    if ([self isPeripheralExist:peripheral.UUIDString]) {
                        [self.connectedPeripherals removeObject:peripheral];
                        //[self sendPushToDevice];
                    }
                    [ble discard];
                    [weakSelf.sensorsTable reloadData];
                }];
                [ble discard];
                
            }else{
                [ble discard];
                
            }
        }
        else if (indexPath.section == 1){
            NSArray  *devices;
            devices = [TrackerDevice fetchAll];
            TrackerDevice *ble = [devices objectAtIndex:indexPath.row];
            [ble discard];
        }
        else if (indexPath.section == 2){
            NSArray  *devices;
            devices = [NexGenDevice fetchAll];
            NexGenDevice *ble = [devices objectAtIndex:indexPath.row];
            [ble discard];
        }
    }
    [self.sensorsTable reloadData];
    
}
-(void)reloadTable{
    [self.sensorsTable reloadData];
}
#pragma mark-PeriodicLocationUpdater
-(void)updatePeriodicLocation:(CLLocationCoordinate2D)coord{
    if(CLLocationCoordinate2DIsValid(coord)){
        [self reconnectWithOldPeripheralWithTimer];
        [self sendTrackerInfoToserver];
        [self sendNexGenDeviceInfoToServer];
        NSArray *peripheralList = self.connectedPeripherals;
                for (LGPeripheral *peripheral in peripheralList) {
                    if([peripheral isConnected]){
                    BLEDevice *ap = [BLEDevice getPeripheralFromUUID:peripheral.UUIDString];
                    if (ap != nil) {
                        CommonInfo *info = [[CommonInfo alloc]init];
                        NSLog(@"%@",ap.systemId);
                        info.trackerId = ap.systemId;
                        info.latitude = coord.latitude;
                        info.longitude = coord.longitude;
                        info.batteryLevel = ap.batteryLevel;
                       // [[ServiceList Instance]updateLocation:info withDelegate:nil];
                    }
                }
                    NSLog(@"Location Updated");
        }
    }
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
    NSArray			*devices;
    NSInteger		row	= [indexPath row];
    NSArray         *connectedperipherals;
    devices = [BLEDevice fetchAll];//[[LeDiscovery sharedInstance] connectedPeripherals];
    BLEDevice *ble = [devices objectAtIndex:row];
    connectedperipherals = [_connectedPeripherals valueForKey:@"UUIDString"];
    if (![connectedperipherals containsObject:ble.identifier]) {
         NSArray *foundPeripherals = [[LGCentralManager sharedInstance]retrievePeripheralsWithIdentifiers:[NSArray arrayWithObjects:[[NSUUID alloc]initWithUUIDString:ble.identifier], nil]];
        if (foundPeripherals.count > 0) {
            [self reConnectPeripheral:[foundPeripherals objectAtIndex:0]];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:ALERT_TITLE message:@"Device out of range." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    }else if (indexPath.section == 1){
        TrackerDevice *dev = [[TrackerDevice fetchAll] objectAtIndex:indexPath.row];
        LocationTracking *controller = [LocationTracking initViewController:dev];
        [self.navigationController pushViewController:controller animated:true];
    }
}


#pragma mark-UIPickerViewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component ==0) {
        return [_pickerArray count];
    }else{
        return 1;
    }
}

#pragma mark-UIPickerViewDelegate
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        return  [_pickerArray objectAtIndex:row];
    }else{
        return @"Mins";
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == [alertView cancelButtonIndex]) {
        [self stopTimer];
    }
}
-(void)connnectLostPeripheral:(LGPeripheral *)peripheral{
    __weak DashboardViewController *weakSelf = self;
    __block LGPeripheral *lostperipheral = peripheral;
    [peripheral connectWithCompletion:^(NSError *error) {
        // Discovering services of peripheral
        [peripheral discoverServicesWithCompletion:^(NSArray *services, NSError *error) {
            for (LGService *service in services) {
                
                NSLog(@"XXXX%@",service.UUIDString);
                if ([service.UUIDString isEqualToString:@"ace0"]) {
                    // Discovering characteristics of our service
                    [service discoverCharacteristicsWithCompletion:^(NSArray *characteristics, NSError *error) {
                        for (LGCharacteristic *charact in characteristics) {
                            NSLog(@"XXXX%@",charact.UUIDString);
                            // cef9 is a writabble characteristic, lets test writting
                            if ([charact.UUIDString isEqualToString:@"ace4"]) {
                                [charact setNotifyValue:YES completion:^(NSError *error) {
                                    NSString *passCode = @"10EB786235";
                                    NSData *hexdata = [NSData dataWithHexString:passCode];
                                    [LGUtils writeData:hexdata charactUUID:@"ACE5" serviceUUID:@"ACE0" peripheral:peripheral completion:^(NSError *error) {
                                        if (![self.connectedPeripherals containsObject:peripheral]) {
                                            [self.connectedPeripherals addObject:peripheral];
                                            [weakSelf.sensorsTable reloadData];
                                        }
                                        [self sendPeripheralLocationToserver:peripheral];
                                        
                                    }];
                                } onUpdate:^(NSData *data, NSError *error) {
                                    
                                }];
                                
                                
                                
                            }
                        }
                    }];
                }
            }
        }];
    }];
}
-(void)sendPeripheralLocationToserver:(LGPeripheral *)peripheral{
    if([peripheral isConnected]){
        BLEDevice *ap = [BLEDevice getPeripheralFromUUID:peripheral.UUIDString];
        if (ap != nil) {
            CLLocationCoordinate2D coord = [[KitLocateTasker Instance] getCurrentCordinates];
            CommonInfo *info = [[CommonInfo alloc]init];
            info.trackerId = ap.systemId;
            info.latitude = coord.latitude;
            info.longitude = coord.longitude;
            info.batteryLevel = ap.batteryLevel;
            //[[ServiceList Instance]updateLocation:info withDelegate:nil];
        }
    }
}


-(void)sendNexGenDeviceInfoToServer{
    NSArray *arr = [NexGenDevice fetchAll];
    for (NexGenDevice *dev in arr) {
         CLLocationCoordinate2D coord = [[KitLocateTasker Instance] getCurrentCordinates];
        CommonInfo *info = [[CommonInfo alloc]init];
        info.trackerId = [NSString stringWithFormat:@"%@-%@",dev.serial_id,dev.tracker_id];
        info.latitude = coord.latitude;
        info.longitude = coord.longitude;
        info.batteryLevel = @"100";
       // [[ServiceList Instance]updateLocation:info withDelegate:nil];
    }
}

-(void)sendTrackerInfoToserver{
    TrackerAccount *account = [TrackerAccount getAccount];
    if (account != nil) {
        NSArray *arr = [TrackerDevice fetchAll];
        for (TrackerDevice *dev in arr) {
            NSInteger deviceid = dev.device_id.integerValue;
            [[DeviceManager sharedInstance]getDeviceInfoWithSavedBlock:deviceid and:^(BOOL success, id data, NSError *error) {
                if (success) {
                    DeviceInfo *dinfo = [[DeviceManager sharedInstance] getDeviceInfo];
                    CLLocationCoordinate2D coord = [[KitLocateTasker Instance] getCurrentCordinates];
                    CommonInfo *info = [[CommonInfo alloc]init];
                    info.trackerId = [NSString stringWithFormat:@"%@-%d",dinfo.serial_id,dinfo.device_id];
                    info.latitude = coord.latitude;
                    info.longitude = coord.longitude;
                    info.batteryLevel = [NSString stringWithFormat:@"%f",(dinfo.batteryCharge *100)];
                    //[[ServiceList Instance]updateLocation:info withDelegate:nil];
                }
            }];
        }
    }
}

#pragma mark -iConsoleDelegate
- (void)handleConsoleCommand:(NSString *)command
{
    if ([command isEqualToString:@"version"])
    {
        [iConsole info:@"%@ version %@",
         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"],
         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]];
    }
    else if ([command isEqualToString:@"exit"]){
        [iConsole hide];
    }
    else
    {
        [iConsole error:@"unrecognised command, try 'version' instead"];
    }
}

#pragma mark -SideMenuDelegate
-(void)didSelectRowAtIndexPath:(NSIndexPath *)indexpath andNavigationController:(UINavigationController *)navigationController{
    if (indexpath.row == 0) {
        
    }else if (indexpath.row == 1){
         //[self openTimePicker];
        [self openPickerWithTag:5];
        
    }else if (indexpath.row == 2){
        [iConsole show];
    }else if (indexpath.row == 3){
        
    }else if (indexpath.row == 4){
        [self Logout];
    }
}

#pragma mark -UIImagePickerControllerDelegate

- (void) imagePickerController: (UIImagePickerController*)picker didFinishPickingMediaWithInfo: (NSDictionary*) info{
    if ([picker isKindOfClass:[ZBarReaderViewController class]]) {
        id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
        
        NSString * barcode_data = @"";
        
        for(ZBarSymbol *symbol in results)
        {
            
            barcode_data = symbol.data;
            
            
           // [self playBeep];
        }
        __weak DashboardViewController *weakself = self;
        //resultImage.image = [info objectForKey: UIImagePickerControllerOriginalImage];
        [reader dismissViewControllerAnimated:reader completion:^{
            
            if (_isNexGenDevice){
                __block NSString *barcodeString = barcode_data;
                [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
                    NexGenDevice *dev = [NexGenDevice MR_createEntityInContext:localContext];
                    dev.serial_id = @"NexGen";
                    dev.tracker_id = barcodeString;
                } completion:^(BOOL contextDidSave, NSError *error) {
                    [weakself reloadTable];
                }];
            }
            else{
                [[DeviceManager sharedInstance] getDeviceInfoDetailWithSavedBlock:3970 and:^(BOOL success, id data, NSError *error) {
                    if (success){
                        NSDictionary *dict = (NSDictionary *)data;
                        [[DeviceManager sharedInstance]saveDevice:dict andBlock:^(BOOL success, NSError *error) {
                            if (success) {
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    [weakself sendTrackerInfoToserver];
                                    [weakself performSelector:@selector(reloadTable) withObject:nil afterDelay:3.0f];
                                });
                                
                            }
                            
                        }];
                    }else{
                        
                    }
                }];
            /*
            [[DeviceManager sharedInstance]checkIfDevicesActivated:barcode_data andblock:^(BOOL success, id data, NSError *error) {
               
                NSString *barcodeString = barcode_data;
                if (!success) {
                    [[DeviceManager sharedInstance] addDeviceWithSerialId:barcodeString andName:@"chris@example.com" andBlock:^(BOOL success, NSError *error) {
                        if (!success) {
                            [[DeviceManager sharedInstance]checkIfDevicesActivated:barcode_data andblock:^(BOOL success, id data, NSError *error) {
                                if (success) {
                                    NSDictionary *dict = (NSDictionary *)data;
                                    [[DeviceManager sharedInstance]saveDevice:dict andBlock:^(BOOL success, NSError *error) {
                                        if (success) {
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                [weakself performSelector:@selector(reloadTable) withObject:nil afterDelay:3.0f];
                                            });
                                           
                                        }
                                        
                                    }];
                                
                                }
                            }];
                            
                        }
                    }];
                }else{
                    NSDictionary *dict = (NSDictionary *)data;
                    [[DeviceManager sharedInstance]saveDevice:dict andBlock:^(BOOL success, NSError *error) {
                        if (success) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [weakself performSelector:@selector(reloadTable) withObject:nil afterDelay:3.0f];
                            });
                            
                        }
                        
                    }];
                }
            }];*/
                
            }
            
        }];

    }
}
@end
