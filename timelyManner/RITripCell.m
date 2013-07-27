//
//  RITripCell.m
//  timelyManner
//
//  Created by Dan Vingo on 7/27/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import "RITripCell.h"
#import "RITimeHelper.h"

@implementation RITripCell
@synthesize elapsedTimeLabel;
@synthesize clockTimeLabel;
@synthesize dateLabel;
@synthesize mapView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (void)populateCellWithInstance:(Instance *)instance rowNumber:(int)rowNumber {
    if (instance.end) {
        //            NSLog(@"instance has end date: %@", instance.end);
        self.elapsedTimeLabel.text = [[RITimeHelper sharedInstance] timeBetweenStartDate:instance.start
                                                                                 endDate:instance.end
                                                                              withFormat:kHoursMinutes];
        
        self.dateLabel.text = [[RITimeHelper sharedInstance] dateStringFromDate:instance.end];
        self.clockTimeLabel.text = [[RITimeHelper sharedInstance] timeBetweenStartDate:instance.start
                                                                               endDate:instance.end
                                                                            withFormat:kstartEndHours];
    } else {
        NSDate *now = [NSDate date];
        self.elapsedTimeLabel.text = [[RITimeHelper sharedInstance] timeBetweenStartDate:instance.start
                                                                                 endDate:now
                                                                              withFormat:kHoursMinutes];
        
        self.dateLabel.text = [[RITimeHelper sharedInstance] dateStringFromDate:now];
        
        self.clockTimeLabel.text = [[RITimeHelper sharedInstance] timeBetweenStartDate:instance.start
                                                                               endDate:now
                                                                            withFormat:kstartEndHours];
    }
}

@end
