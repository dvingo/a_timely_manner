//
//  RIActiveInstanceCell.h
//  timelyManner
//
//  Created by Dan Vingo on 7/13/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "Instance.h"

@interface RIActiveInstanceCell : UITableViewCell <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *timerLengthLabel;
@property (weak, nonatomic) IBOutlet UILabel *taskLabel;
@property (strong, nonatomic) Instance *instance;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;

- (IBAction)stopTimerPressed:(id)sender;
- (void)populateViews;
- (void)updateTimerLengthLabel;

@end
