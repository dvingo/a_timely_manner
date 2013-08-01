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
    self.mapView.delegate = self;
    CLLocationCoordinate2D startLocation = CLLocationCoordinate2DMake(
                                        [instance.startLatitude doubleValue],
                                        [instance.startLongitude doubleValue]);
    CLLocationCoordinate2D endLocation = CLLocationCoordinate2DMake(
                                                [instance.endLatitude doubleValue],
                                                [instance.endLongitude doubleValue]);
    
    CLLocationCoordinate2D coordinateArray[2];
    coordinateArray[0] = startLocation;
    coordinateArray[1] = endLocation;
    
    // Create rectangle that fits the start and end point
    // TODO fit all point in instance.locations
    MKMapRect r = MKMapRectNull;    
    for (NSUInteger i=0; i<2; ++i) {
        MKMapPoint p = MKMapPointForCoordinate(coordinateArray[i]);
        NSLog(@"point x y: %f, %f", p.x, p.y);
        r = MKMapRectUnion(r, MKMapRectMake(p.x, p.y, 0, 0));
    }
    MKCoordinateRegion viewRegion = MKCoordinateRegionForMapRect(r);
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
    [self.mapView setRegion:adjustedRegion];
    
    // Make the rectangle twice as large, effectively zooming out the mapview
    MKCoordinateRegion region = self.mapView.region;
    region.center = self.mapView.centerCoordinate;
    region.span.longitudeDelta *= 2; // Bigger the value, closer the map view
    region.span.latitudeDelta *= 2;
    [self.mapView setRegion:region animated:YES];
    
    MKPolyline *line = [MKPolyline polylineWithCoordinates:coordinateArray count:2];
    [self.mapView addOverlay:line];
    
    MKPointAnnotation *startPoint = [[MKPointAnnotation alloc] init];
    startPoint.title = @"Start";
    startPoint.coordinate = startLocation;
    
    MKPointAnnotation *endPoint = [[MKPointAnnotation alloc] init];
    endPoint.coordinate = endLocation;
    endPoint.title = @"End";
    
    [self.mapView addAnnotation:startPoint];
    [self.mapView addAnnotation:endPoint];
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay {
    MKPolylineView *aView = [[MKPolylineView alloc] initWithPolyline:(MKPolyline *)overlay];
    aView.lineWidth = 7.0;
    aView.strokeColor = [UIColor redColor];
    return aView;
}

@end
