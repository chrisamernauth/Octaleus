//
//  ServiceList.h
//  PallySmartFinder
//
//  Created by Rahul Soni on 14/10/15.
//  Copyright (c) 2015 Rahul Soni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCRequest.h"
#import "URLSchemea.h"
#import "OCRequestDelegate.h"
#import "UniversalDelegate.h"
#import "ModelListLoadedDelegate.h"
#import "CommonInfo.h"
@interface ServiceList : NSObject<OCRequestDelegate>
{
    id<ModelListLoadedDelegate>_delegate;
}
@property(nonatomic,retain)id<ModelListLoadedDelegate>delegate;

+(ServiceList *)Instance;
+(ServiceList *)clearInstance;
-(void)updateLocation:(CommonInfo *)cInfo withDelegate:(id<ModelListLoadedDelegate>)del;
@end
