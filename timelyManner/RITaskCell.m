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
#import "RIConstants.h"

@interface RITaskCell ()
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@end

@implementation RITaskCell
@synthesize taskNameLabel;
@synthesize dayLabel;
@synthesize numActiveInstances;
@synthesize numTotalInstancesLabel;
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

- (void)populateViewsWithTask:(Task *)task {
    self.avgLabel.font = [UIFont fontWithName:kRIFontRegular size:13.0];
    self.taskNameLabel.text = task.name;
    self.taskNameLabel.font = [UIFont fontWithName:kRIFontBold size:24.0];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDateFormatter *f = [NSDateFormatter new];
    f.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    if (task.lastRun == nil) {
        [task updateLastRun];
    }
    
    if (task.activeInstances.count > 0) {
        self.whiteBackgroundView.backgroundColor = kOrangeColor;
    } else {
        self.whiteBackgroundView.backgroundColor = [UIColor whiteColor];
    }

    double avgTime = [task averageInstanceTime];
    self.averageInstanceTimeLabel.text = [[RITimeHelper sharedInstance] timeFormatFromSeconds:(int)avgTime];
    self.averageInstanceTimeLabel.font = [UIFont fontWithName:kRIFontRegular size:20.0];
    self.dayLabel.text = [self.dateFormatter stringFromDate:task.lastRun];
    self.dayLabel.font = [UIFont fontWithName:kRIFontBold size:14.0];
    self.numActiveInstances.text = [NSString stringWithFormat:@"%d active", task.activeInstances.count];
    self.numActiveInstances.font = [UIFont fontWithName:kRIFontRegular size:17.0];
    self.numTotalInstancesLabel.text = [NSString stringWithFormat:@"%d total", task.instances.count];
    self.numTotalInstancesLabel.font = [UIFont fontWithName:kRIFontRegular size:17.0];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    if (highlighted) {
        self.taskNameLabel.textColor = [UIColor whiteColor];
        self.averageInstanceTimeLabel.textColor = [UIColor whiteColor];
        self.dayLabel.textColor = [UIColor whiteColor];
        self.numActiveInstances.textColor = [UIColor whiteColor];
        self.numTotalInstancesLabel.textColor = [UIColor whiteColor];
        self.greyBackgroundView.backgroundColor = kDarkBlueColor;
    } else {
        self.taskNameLabel.textColor = kDarkBlueColor;
        self.averageInstanceTimeLabel.textColor = kDarkBlueColor;
        self.dayLabel.textColor = kDarkBlueColor;
        self.numActiveInstances.textColor = kDarkBlueColor;
        self.numTotalInstancesLabel.textColor = kDarkBlueColor;
        self.greyBackgroundView.backgroundColor = kLighterGreyColor;
    }
}

@end
