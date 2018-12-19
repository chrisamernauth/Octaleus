//
//  ProfileCell.m
//  Octaleus
//
//  Created by Rahul Soni on 13/02/16.
//  Copyright (c) 2016 Rahul Soni. All rights reserved.
//

#import "ProfileCell.h"

@implementation ProfileCell

- (void)awakeFromNib {
    _profileImage.layer.cornerRadius = 25.0f;
    _profileImage.clipsToBounds = YES;
    _profileImage.layer.masksToBounds = YES;
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
