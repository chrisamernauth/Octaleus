//
//  BleCell.m
//  PallySmartFinder
//
//  Created by Rahul Soni on 09/09/15.
//  Copyright (c) 2015 Rahul Soni. All rights reserved.
//

#import "BleCell.h"

@implementation BleCell

- (void)awakeFromNib {
    self.deviceimg.layer.cornerRadius = 28.0f;
    self.deviceimg.clipsToBounds =YES;
    self.deviceimg.layer.masksToBounds = YES;
    self.layer.cornerRadius = 15.0f;

}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
