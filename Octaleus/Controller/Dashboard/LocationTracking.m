//
//  LocationTracking.m
//  Octaleus
//
//  Created by Rahul Soni on 15/07/18.
//  Copyright © 2018 Rahul Soni. All rights reserved.
//

#import "LocationTracking.h"
#import "MyLocation.h"
#import "DeviceInfo.h"
#import "KitLocateTasker.h"
#import "DeviceManager.h"
#import "TrackerAccount.h"
#import "TrackerDevice.h"
#import "LMGeocoder.h"
#import "SVProgressHUD.h"
#import <INTULocationManager/INTULocationManager.h>

@interface LocationTracking ()
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)TrackerDevice *device;
@end

@implementation LocationTracking
@synthesize _mapView;


+(LocationTracking *)initViewController:(TrackerDevice *)dev{
    LocationTracking *controller = [[LocationTracking alloc]initWithNibName:@"LocationTracking" bundle:nil];
    controller.device = dev;
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Location Tracker";
    //[SVProgressHUD showWithStatus:@"Fetching Location"];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)pollData{
    TrackerAccount *account = [TrackerAccount getAccount];
    __weak LocationTracking *weakSelf = self;
    if (account != nil) {
        [[DeviceManager sharedInstance]getDeviceInfoWithSavedBlock:self.device.device_id.integerValue and:^(BOOL success, id data, NSError *error) {
            if (success) {
                DeviceInfo *dinfo = [[DeviceManager sharedInstance] getDeviceInfo];
                [weakSelf plotITRAQPositions:dinfo];
            }
            [SVProgressHUD dismiss];
        }];
    }
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (_timer != nil){
        [_timer invalidate];
        _timer = nil;
    }
}

-(void)runiTraqTimer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:60.0
                                              target:self
                                            selector:@selector(pollData)
                                            userInfo:nil
                                             repeats:YES];
}

#pragma mark - View lifecycle


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    static NSString *identifier = @"MyLocation";
    if ([annotation isKindOfClass:[MyLocation class]]) {
        
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        } else {
            annotationView.annotation = annotation;
        }
        
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        annotationView.image=[UIImage imageNamed:@"track"];//here we use a nice image instead of the default pins
        
        return annotationView;
    }
    
    return nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 1
    CLLocationCoordinate2D coord = [[KitLocateTasker Instance] getCurrentCordinates];
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = coord.latitude;
    zoomLocation.longitude= coord.longitude;
    _mapView.showsUserLocation = true;
    MyLocation *annotation = [[MyLocation alloc] initWithName:@"Current Location" address:@"" coordinate:coord] ;
    [_mapView addAnnotation:annotation];
    MKCoordinateRegion viewRegion = MKCoordinateRegionMake(zoomLocation, MKCoordinateSpanMake(0.5, 0.5)); //MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    // 3
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
    // 4
    [_mapView setRegion:adjustedRegion animated:YES];
    [self getCoordinates];
    [self performSelector:@selector(runiTraqTimer) withObject:nil afterDelay:15.0];
    
}

-(void)getCoordinates{
    __weak LocationTracking *weakSelf = self;
    INTULocationManager *locMgr = [INTULocationManager sharedInstance];
    [locMgr requestLocationWithDesiredAccuracy:INTULocationAccuracyHouse
                                       timeout:5.0
                          delayUntilAuthorized:YES    // This parameter is optional, defaults to NO if omitted
                                         block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
                                             if (status == INTULocationStatusSuccess) {
                                                 // Request succeeded, meaning achievedAccuracy is at least the requested accuracy, and
                                                 // currentLocation contains the device's current location.
                                                 [weakSelf fetchAddressFromApple:currentLocation.coordinate];
                                             }
                                             else if (status == INTULocationStatusTimedOut) {
                                                 // Wasn't able to locate the user with the requested accuracy within the timeout interval.
                                                 // However, currentLocation contains the best location available (if any) as of right now,
                                                 // and achievedAccuracy has info on the accuracy/recency of the location in currentLocation.
                                                 [weakSelf fetchAddressFromApple:currentLocation.coordinate];
                                             }
                                             else {
                                                 // An error occurred, more info is available by looking at the specific status returned.
                                             }
                                         }];
}

- (void)plotITRAQPositions:(DeviceInfo *)info {
    
    for (id<MKAnnotation> annotation in _mapView.annotations) {
        [_mapView removeAnnotation:annotation];
    }
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = info.latitude;
    coordinate.longitude = info.longitude;
    MyLocation *annotation = [[MyLocation alloc] initWithName:@"Current Device" address:@"" coordinate:coordinate] ;
    [_mapView addAnnotation:annotation];
    MKCoordinateRegion viewRegion = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.5, 0.5));
    // 3
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
    // 4
    [_mapView setRegion:adjustedRegion animated:YES];
    [self fetchAddress:coordinate];
}


-(void)fetchAddress:(CLLocationCoordinate2D)coordinate{
    __weak LocationTracking *weakSelf = self;
    [[DeviceManager sharedInstance] getAddressFromCombain:coordinate and:^(BOOL success, id data, NSError *error) {
        if (success){
            NSMutableArray *arr = (NSMutableArray *)data;
            if (arr != nil){
                NSString *address = [arr componentsJoinedByString:@","];
                _lblAddress.text = address;
            }else{
                [weakSelf fetchAddressFromApple:coordinate];
            }
        }else{
            [weakSelf fetchAddressFromApple:coordinate];
        }
    }];
    
}

- (void)fetchAddressFromApple:(CLLocationCoordinate2D)coordinate{
    [[LMGeocoder sharedInstance] cancelGeocode];
    [[LMGeocoder sharedInstance] reverseGeocodeCoordinate:coordinate
                                                  service:kLMGeocoderAppleService
                                        completionHandler:^(NSArray *results, NSError *error) {
                                            
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                if (results.count && !error) {
                                                    LMAddress *address = [results firstObject];
                                                    _lblAddress.text = address.formattedAddress;
                                                }
                                                else {
                                                    _lblAddress.text = @"-";
                                                }
                                            });
                                        }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
