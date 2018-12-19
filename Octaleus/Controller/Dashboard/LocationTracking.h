//
//  LocationTracking.h
//  Octaleus
//
//  Created by Rahul Soni on 15/07/18.
//  Copyright © 2018 Rahul Soni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "TrackerDevice.h"

#define METERS_PER_MILE 1609.344
@interface LocationTracking : UIViewController<MKMapViewDelegate>{
    BOOL _doneInitialZoom;
    
}
@property (weak, nonatomic) IBOutlet MKMapView *_mapView;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
+(LocationTracking *)initViewController:(TrackerDevice *)dev;
@end
