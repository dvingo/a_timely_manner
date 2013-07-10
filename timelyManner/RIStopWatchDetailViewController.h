//
//  RIStopWatchDetailViewController.h
//  timelyManner
//
//  Created by Dan Vingo on 7/9/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@interface RIStopWatchDetailViewController : UITableViewController
@property (strong, nonatomic) Task *task;
@end
