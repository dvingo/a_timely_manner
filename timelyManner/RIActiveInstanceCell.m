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
@synthesize elapsedTimeTimer = _elapsedTimeTimer;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)stopTimerPressed:(id)sender {
    NSLog(@"STOP TIMER PRESSED for cell with task: %@", self.taskLabel.text);
    [self.elapsedTimeTimer invalidate];
    
    [UIView animateWithDuration:0.7f
                     animations:^ {
                         self.stopButton.alpha = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         self.stopButton.enabled = NO;
                     }];
    self.instance.end = [NSDate date];
    
    //    paramTask.lastRun = [self lastRunDateWithTask:paramTask];
    NSDate *lastRunDate = (NSDate *)[[RITaskManager sharedInstance] lastRunDateWithTask:self.instance.task];
    NSDateFormatter *f = [NSDateFormatter new];
    f.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSLog(@"Last Run DATE: %@", [f stringFromDate:lastRunDate]);
    self.instance.task.lastRun = lastRunDate;
    
    [[RITaskManager sharedInstance] saveContext];
    [[RITaskManager sharedInstance] refreshTask:self.instance.task];
}

- (void)populateViews {
    NSLog(@"In populate views");
    self.taskLabel.text = self.instance.task.name;
    self.stopButton.alpha = 1.0f;
    self.stopButton.enabled = YES;
    self.timerLengthLabel.text = [[RITaskManager sharedInstance] timeElapsedSinceDate:self.instance.start];
    
    self.elapsedTimeTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                                       target:self
                                                                     selector:@selector(updateElapsedTime:)
                                                                     userInfo:nil
                                                                      repeats:YES];
}

- (void)updateElapsedTime:(NSTimer *)timer {
    self.timerLengthLabel.text = [[RITaskManager sharedInstance] timeElapsedSinceDate:self.instance.start];
}

- (void)dealloc {
    if (self.elapsedTimeTimer) {
        [self.elapsedTimeTimer invalidate];
    }
}

@end
