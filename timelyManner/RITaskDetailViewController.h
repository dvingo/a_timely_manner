//
//  RITaskDetailViewController.h
//  timelyManner
//
//  Created by Dan Vingo on 7/27/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

#define ktaskDetailScene @"taskDetailScene"

@interface RITaskDetailViewController : UITableViewController
@property (strong, nonatomic) Task *task;
@end
