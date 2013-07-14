//
//  RIActiveTaskCell.m
//  timelyManner
//
//  Created by Dan Vingo on 7/13/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import "RIActiveTaskCell.h"

@implementation RIActiveTaskCell
@synthesize timerLengthLabel, taskLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)stopTimerPressed:(id)sender {
    NSLog(@"STOP TIMER PRESSED for cell with task: %@", self.taskLabel.text);
}

@end
