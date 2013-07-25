//
//  RITaskCell.m
//  timelyManner
//
//  Created by Dan Vingo on 6/29/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import "RITaskCell.h"
#import "RITimeHelper.h"
#import "Task.h"

@interface RITaskCell ()
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@end

@implementation RITaskCell
@synthesize taskNameLabel;
@synthesize dayLabel;
@synthesize numActiveInstances;
@synthesize averageInstanceTimeLabel;
@synthesize dateFormatter = _dateFormatter;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _dateFormatter = [NSDateFormatter new]; 
        _dateFormatter.dateFormat = @"MMM d";
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)populateViewsWithTask:(Task *)task {
    self.taskNameLabel.text = task.name;

    NSDateFormatter *f = [NSDateFormatter new];
    f.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    if (task.lastRun == nil) {
        [task updateLastRun];
    }
    NSLog(@"in RITaskCell populateViewsWithTask lastRUN: %@", [f stringFromDate:task.lastRun]);
    NSLog(@"TASK CELL dateFormatter: %@", self.dateFormatter);
    NSLog(@"TASK CELL DAY LABEL: %@", [self.dateFormatter stringFromDate:task.lastRun]);
    double avgTime = [task averageInstanceTime];
    NSLog(@"AVERAGE TASK INSTANCE TIME: %f", avgTime);
    NSString *avgTimeString =[[RITimeHelper sharedInstance] timeFormatFromSeconds:(int)avgTime];
    NSLog(@"avg time: %@", avgTimeString);
    self.averageInstanceTimeLabel.text = [[RITimeHelper sharedInstance] timeFormatFromSeconds:(int)avgTime];
    self.dayLabel.text = [self.dateFormatter stringFromDate:task.lastRun];
    self.numActiveInstances.text = [NSString stringWithFormat:@"%d active", task.activeInstances.count];
}

@end
