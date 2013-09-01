//
//  RIInstanceCell.m
//  timelyManner
//
//  Created by Dan Vingo on 7/16/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import "Instance.h"
#import "RIConstants.h"
#import "RIInstanceCell.h"
#import "RITimeHelper.h"

#define kCellColorOne [UIColor colorWithRed:78.0/255.0f green:89.0/255.0f blue:104.0/255.0f alpha:1.0]
#define kCellColorTwo [UIColor colorWithRed:250.0/255.0f green:250.0/255.0f blue:250.0/255.0f alpha:1.0]
#define kTextColorOne [UIColor colorWithRed:124.0/255.0f green:231.0/255.0f blue:237.0/255.0f alpha:1.0]
#define kTextColorTwo [UIColor colorWithRed:124.0/255.0f green:87.0/255.0f blue:237.0/255.0f alpha:1.0]

@implementation RIInstanceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)populateCellWithInstance:(Instance *)instance rowNumber:(int)rowNumber {
    self.elapsedTimeLabel.font = [UIFont fontWithName:kRIFontBold size:36.0];
    self.clockTimeLabel.font = [UIFont fontWithName:kRIFontRegular size:26.0];
    self.clockTimeLabel.textColor = kDarkBlueColor;
    self.dateLabel.font = [UIFont fontWithName:kRIFontRegular size:17.0];
    self.dateLabel.textColor = kDarkBlueColor;
    
    self.elapsedTimeLabel.textColor = kDarkBlueColor;
    self.elapsedTimeLabel.textColor = kDarkBlueColor;
    self.elapsedTimeLabel.textColor = kDarkBlueColor;

    
    if (instance.end) {
        self.elapsedTimeLabel.text = [[RITimeHelper sharedInstance] timeBetweenStartDate:instance.start
                                                                                 endDate:instance.end
                                                                              withFormat:kHoursMinutesSeconds];
        
        self.dateLabel.text = [[RITimeHelper sharedInstance] dateStringFromDate:instance.end];
        self.clockTimeLabel.text = [[RITimeHelper sharedInstance] timeBetweenStartDate:instance.start
                                                                               endDate:instance.end
                                                                            withFormat:kstartEndHours];
    } else {
        NSDate *now = [NSDate date];
        self.elapsedTimeLabel.text = [[RITimeHelper sharedInstance] timeBetweenStartDate:instance.start
                                                                                 endDate:now
                                                                              withFormat:kHoursMinutesSeconds];
        self.dateLabel.text = [[RITimeHelper sharedInstance] dateStringFromDate:now];
        self.clockTimeLabel.text = [[RITimeHelper sharedInstance] timeBetweenStartDate:instance.start
                                                                               endDate:now
                                                                            withFormat:kstartEndHours];
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

BOOL numberIsEven(int number) {
    return number % 2 == 0;
}

@end
