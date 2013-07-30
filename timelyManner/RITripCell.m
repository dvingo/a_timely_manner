//
//  RITripCell.m
//  timelyManner
//
//  Created by Dan Vingo on 7/27/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import "RITripCell.h"
#import "RITimeHelper.h"

#define METERS_PER_MILE 1609.344

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
    [self setupMapWithInstance:instance];
}

- (void)setupMapWithInstance:(Instance *)instance {
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(
                                        [instance.startLatitude doubleValue],
                                        [instance.startLongitude doubleValue]);
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coord,
                                                                0.5 * METERS_PER_MILE,
                                                                0.5 * METERS_PER_MILE);
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
    [self.mapView setRegion:adjustedRegion];
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = coord;
    [self.mapView addAnnotation:point];
}

@end
