//
//  DeviceInfo.h
//  Octaleus
//
//  Created by Rahul Soni on 02/03/16.
//  Copyright (c) 2016 Rahul Soni. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 "id": 348
 "name": "chris@example.com"
 "serialId": "100003PGFM1VFR8VEM"
 "imei": "866104023436457"
 "panicMode": false
 "activationStatus": "READY"
 "shareCount": 0
 "schedule": "{"schedule":[{ "start":0, "end":1440, "period":60 }],"timezone":-5}"
 "schedulePending": false
 "batteryCharge": 0.97
 "firmwareVersion": 2
 "simNumber": "8901000300000155425"
 "communicationProtocol": "USSD"
 "reports": 99194
 "balanceInfo": {
 "reports": 99194
 "reportsExpirationDate": 1469146908
 }-
 "nextWakeUpSeconds": 1456858800
 "isOwn": true
 "reportsExpirationDate": 1469146908
 }
 */
@interface DeviceInfo : NSObject
@property(nonatomic,assign)int device_id;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *serial_id;
@property(nonatomic,strong)NSString *imei;
@property(nonatomic,assign)BOOL panicMode;
@property(nonatomic,strong)NSString *activationStatus;
@property(nonatomic,assign)int shareCount;
@property(nonatomic,strong)NSString *schedule;
@property(nonatomic,assign)BOOL schedulePending;
@property(nonatomic,assign)float batteryCharge;
@property(nonatomic,assign)int firmwareVersion;
@property(nonatomic,strong)NSString *simNumber;
@property(nonatomic,strong)NSString *communicationProtocol;
@property(nonatomic,strong)NSString *reports;
@property(nonatomic,strong)NSString *nextWakeUpSeconds;
@property(nonatomic,assign)BOOL isOwn;
@property(nonatomic,strong)NSString *reportsExpirationDate;
@property(nonatomic,assign)double latitude;
@property(nonatomic,assign)double longitude;

+(DeviceInfo *)parseWithDict:(NSDictionary *)dict;
@end
