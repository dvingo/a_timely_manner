//
//  RIActiveTaskCell.h
//  timelyManner
//
//  Created by Dan Vingo on 7/13/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RIActiveTaskCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timerLengthLabel;
@property (weak, nonatomic) IBOutlet UILabel *taskLabel;

- (IBAction)stopTimerPressed:(id)sender;

@end
