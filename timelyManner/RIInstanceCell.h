//
//  RIInstanceCell.h
//  timelyManner
//
//  Created by Dan Vingo on 7/16/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kInstanceCellIdentifier @"InstanceCell"
#define kInstanceCellHeight 80.0f

@interface RIInstanceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *elapsedTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *clockTimeLabel;
@property (weak, nonatomic) IBOutlet UIView *cellContainerView;

- (void)populateCellWithInstance:(Instance *)instance rowNumber:(int)rowNumber;

@end
