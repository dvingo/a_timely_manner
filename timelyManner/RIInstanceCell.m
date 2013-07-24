//
//  RIInstanceCell.m
//  timelyManner
//
//  Created by Dan Vingo on 7/16/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import "Instance.h"
#import "RIInstanceCell.h"
#import "RITimeHelper.h"

#define kCellColorOne [UIColor colorWithRed:78.0/255.0f green:89.0/255.0f blue:104.0/255.0f alpha:1.0]
#define kCellColorTwo [UIColor colorWithRed:250.0/255.0f green:250.0/255.0f blue:250.0/255.0f alpha:1.0]
#define kTextColorOne [UIColor colorWithRed:124.0/255.0f green:231.0/255.0f blue:237.0/255.0f alpha:1.0]
#define kTextColorTwo [UIColor colorWithRed:124.0/255.0f green:87.0/255.0f blue:237.0/255.0f alpha:1.0]

@implementation RIInstanceCell
@synthesize elapsedTimeLabel = _elapsedTimeLabel;
@synthesize dateLabel = _dateLabel;
@synthesize clockTimeLabel = _clockTimeLabel;
@synthesize cellContainerView = _cellContainerView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)populateCellWithInstance:(Instance *)instance rowNumber:(int)rowNumber {
    UIColor *textColor;
    if (numberIsEven(rowNumber)) {
        self.cellContainerView.backgroundColor = kCellColorOne;
        textColor = kTextColorOne;
    } else {
        self.cellContainerView.backgroundColor = kCellColorTwo;
        textColor = kTextColorTwo;
    }
    
    self.elapsedTimeLabel.textColor = textColor;
    
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
        //            NSLog(@"instance does not have end date: %@", instance.end);
        //            NSLog(@"instance start date: %@", instance.start);
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

BOOL numberIsEven(int number) {
    return number % 2 == 0;
}

@end
