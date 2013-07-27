//
//  RITripCell.h
//  timelyManner
//
//  Created by Dan Vingo on 7/27/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Instance.h"

#define kTripInstanceCellIdentifier @"TripInstanceCell"

@interface RITripCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *elapsedTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *clockTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (void)populateCellWithInstance:(Instance *)instance rowNumber:(int)rowNumber;

@end
