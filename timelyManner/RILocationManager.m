//
//  RILocationManager.m
//  timelyManner
//
//  Created by Dan Vingo on 7/31/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import "Instance.h"
#import "RILocationManager.h"
#import "RITaskManager.h"

@interface RILocationManager ()
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSArray *instances;
@end

@implementation RILocationManager
@synthesize locationManager;
@synthesize instances;

+ (id)sharedInstance {
    static RILocationManager *__sharedInstance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[RILocationManager alloc] init];
    });
    
    return __sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        instances = [NSArray new];
        locationManager = [CLLocationManager new];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        locationManager.distanceFilter = 500;
    }
    return self;
}

- (void)populateEndLocationWithInstance:(Instance *)instance {
    self.instances = [self.instances arrayByAddingObject:instance];
    [self.locationManager startUpdatingLocation];
}

#pragma mark - LocationManager delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];
    // TODO investigate this
//    NSDate *eventDate = location.timestamp;
//    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
//    if (abs(howRecent) < 15.0) {
//        NSLog(@"latitude %+.6f, longitude %+.6f\n",
//              location.coordinate.latitude,
//              location.coordinate.longitude);
//    }
    for (Instance *instance in self.instances) {
        NSLog(@"Setting end location for instance: %@", instance.task.name);
        instance.endLatitude = [NSNumber numberWithDouble:location.coordinate.latitude];
        instance.endLongitude = [NSNumber numberWithDouble:location.coordinate.longitude];
        [[RITaskManager sharedInstance] refreshTask:instance.task];
    }
    self.instances = [NSArray new];
    [[RITaskManager sharedInstance] saveContext];
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"LOCATION MANAGER failed");
}

@end
