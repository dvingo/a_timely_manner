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
    NSLog(@"STOP TIMER PRESSED for cell with task: %@", self.taskLabel.text);
    [UIView animateWithDuration:0.7f
                     animations:^ {
                         self.stopButton.alpha = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         [self.stopButton removeFromSuperview];
                     }];
    self.instance.end = [NSDate date];
    [[RITaskManager sharedInstance] saveContext];
    [[RITaskManager sharedInstance] refreshTask:self.instance.task];
}

- (void)populateViews {
    self.taskLabel.text = self.instance.task.name;
    self.timerLengthLabel.text = [[RITaskManager sharedInstance] timeElapsedSinceDate:self.instance.start];
}

@end
