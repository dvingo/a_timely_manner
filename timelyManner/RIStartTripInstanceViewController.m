//
//  RIStartTripInstanceViewController.m
//  timelyManner
//
//  Created by Dan Vingo on 7/27/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import "RIStartTripInstanceViewController.h"
#import "RITaskManager.h"

@interface RIStartTripInstanceViewController ()
@property (strong, nonatomic) CLLocationManager *locationManager;
@end

@implementation RIStartTripInstanceViewController
@synthesize task;
@synthesize taskNameLabel;
@synthesize locationManager;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    self.locationManager.distanceFilter = 500;
}

- (IBAction)goButtonPressed:(id)sender {
    NSLog(@"creating new instance");
    [self.locationManager startUpdatingLocation];
}

#pragma mark - LocationManager delegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];
    NSDate *eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0) {
        NSLog(@"latitude %+.6f, longitude %+.6f\n",
              location.coordinate.latitude,
              location.coordinate.longitude);
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Location failed");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
