//
//  RIActiveInstanceCell.m
//  timelyManner
//
//  Created by Dan Vingo on 7/13/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import "RIActiveInstanceCell.h"
#import "RIConstants.h"
#import "RITaskManager.h"
#import "RILocationManager.h"
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
    
    [[RITaskManager sharedInstance] saveContext];
    [[RITaskManager sharedInstance] refreshTask:self.instance.task];
    
    if ([self.instance.task isTripTask]) {
        [[RILocationManager sharedInstance] populateEndLocationWithInstance: self.instance];
    }
}

- (void)populateViews {
    NSLog(@"In populate views");
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.taskLabel.text = self.instance.task.name;
    self.taskLabel.font = [UIFont fontWithName:kRIFontBold size:24.0];
    self.taskLabel.textColor = kDarkBlueColor;
    self.taskLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.taskLabel.numberOfLines = 0;
    self.taskLabel.backgroundColor = [UIColor clearColor];

    if (self.instance.end == nil) {
        self.stopButton.alpha = 1.0f;
        self.stopButton.enabled = YES;
    }

    self.timerLengthLabel.text = [[RITaskManager sharedInstance] timeElapsedSinceDate:self.instance.start];
    self.timerLengthLabel.font = [UIFont fontWithName:kRIFontBold size:30.0];
    self.timerLengthLabel.textColor = kDarkBlueColor;
    self.timerLengthLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.timerLengthLabel.numberOfLines = 0;
}

- (void)updateTimerLengthLabel {
    if (self.instance.end == nil) {
        self.timerLengthLabel.text = [[RITaskManager sharedInstance] timeElapsedSinceDate:self.instance.start];
    }
}

@end
