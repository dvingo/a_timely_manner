//
//  RIActiveInstanceCell.m
//  timelyManner
//
//  Created by Dan Vingo on 7/13/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import "RIActiveInstanceCell.h"
#import "RITaskManager.h"
#import "Task.h"

@interface RIActiveInstanceCell ()
@property (strong, nonatomic) NSTimer *elapsedTimeTimer;
@end

@implementation RIActiveInstanceCell
@synthesize timerLengthLabel, taskLabel, instance;
@synthesize stopButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)stopTimerPressed:(id)sender {
    [UIView animateWithDuration:0.7f
                     animations:^ {
                         self.stopButton.alpha = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         self.stopButton.enabled = NO;
                     }];
    self.instance.end = [NSDate date];
    NSDate *lastRunDate = (NSDate *)[[RITaskManager sharedInstance] lastRunDateWithTask:self.instance.task];
    NSDateFormatter *f = [NSDateFormatter new];
    f.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSLog(@"Last Run DATE: %@", [f stringFromDate:lastRunDate]);
    self.instance.task.lastRun = lastRunDate;
    
    if ([self.instance.task isTripTask]) {
        CLLocationManager *locationManager = [CLLocationManager new];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        locationManager.distanceFilter = 500;
        [locationManager startUpdatingLocation];
    } else if ([self.instance.task isStopWatchTask]) {
        [[RITaskManager sharedInstance] saveContext];
        [[RITaskManager sharedInstance] refreshTask:self.instance.task];
    }
}

- (void)populateViews {
    NSLog(@"In populate views");
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.taskLabel.text = self.instance.task.name;
    self.stopButton.alpha = 1.0f;
    self.stopButton.enabled = YES;
    self.timerLengthLabel.text = [[RITaskManager sharedInstance] timeElapsedSinceDate:self.instance.start];
}

- (void)updateTimerLengthLabel {
    if (self.instance.end == nil) {
        self.timerLengthLabel.text = [[RITaskManager sharedInstance] timeElapsedSinceDate:self.instance.start];
    }
}

#pragma mark - Location manager delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];
    NSDate *eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0) {
        NSLog(@"latitude %+.6f, longitude %+.6f\n",
              location.coordinate.latitude,
              location.coordinate.longitude);
    }
    self.instance.endLatitude = [NSNumber numberWithDouble:location.coordinate.latitude];
    self.instance.endLongitude = [NSNumber numberWithDouble:location.coordinate.longitude];
    [[RITaskManager sharedInstance] saveContext];
    [[RITaskManager sharedInstance] refreshTask:self.instance.task];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Location failed");
}

@end
