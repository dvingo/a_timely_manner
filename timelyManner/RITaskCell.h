//
//  RITaskCell.h
//  timelyManner
//
//  Created by Dan Vingo on 6/29/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@interface RITaskCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *taskNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *numActiveInstances;
@property (weak, nonatomic) IBOutlet UILabel *averageInstanceTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *numTotalInstancesLabel;
@property (weak, nonatomic) IBOutlet UIView *greyBackgroundView;
@property (weak, nonatomic) IBOutlet UILabel *avgLabel;

- (void)populateViewsWithTask:(Task *)task;

@end
