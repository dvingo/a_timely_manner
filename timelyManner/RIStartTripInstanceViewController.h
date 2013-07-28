//
//  RIStartTripInstanceViewController.h
//  timelyManner
//
//  Created by Dan Vingo on 7/27/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "Task.h"

#define kStartTripInstanceScene @"startTripInstanceScene"

@interface RIStartTripInstanceViewController : UIViewController <CLLocationManagerDelegate>
@property (strong, nonatomic) Task *task;
@property (weak, nonatomic) IBOutlet UILabel *taskNameLabel;

- (IBAction)goButtonPressed:(id)sender;

@end
