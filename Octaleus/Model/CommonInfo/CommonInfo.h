//
//  CommonInfo.h
//  PallySmartFinder
//
//  Created by Rahul Soni on 25/10/15.
//  Copyright (c) 2015 Rahul Soni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonInfo : NSObject

@property(nonatomic,strong)NSString *trackerId;
@property(nonatomic,assign)float latitude;
@property(nonatomic,assign)float longitude;
@property(nonatomic,retain)NSString *batteryLevel;

@end
