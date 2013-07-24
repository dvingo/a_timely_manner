//
//  RITaskCell.m
//  timelyManner
//
//  Created by Dan Vingo on 6/29/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import "RITaskCell.h"
#import "Task.h"

@interface RITaskCell ()
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@end

@implementation RITaskCell
@synthesize taskNameLabel;
@synthesize dayLabel;
@synthesize numActiveInstances;
@synthesize dateFormatter = _dateFormatter;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        self.dateFormatter = [NSDateFormatter new];
//        self.dateFormatter.dateFormat = @"MMM d";
//    }
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
//
//- (id)init {
//    self = [super init];
//    if (self) {
//        
//    }
//    return self;
//}

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
    self.dayLabel.text = [self.dateFormatter stringFromDate:task.lastRun];
    self.numActiveInstances.text = [NSString stringWithFormat:@"%d active", task.activeInstances.count];
}

@end
