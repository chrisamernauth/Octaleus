//
//  BleCell.h
//  PallySmartFinder
//
//  Created by Rahul Soni on 09/09/15.
//  Copyright (c) 2015 Rahul Soni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface BleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *uuid;
@property (weak, nonatomic) IBOutlet UIImageView *deviceimg;
@property (weak, nonatomic) IBOutlet UILabel *RSSI;
@property (weak, nonatomic) IBOutlet UILabel *status;


@end
