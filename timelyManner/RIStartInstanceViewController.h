//
//  RIStartInstanceViewController.h
//  timelyManner
//
//  Created by Dan Vingo on 7/16/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import "Task.h"
#import <UIKit/UIKit.h>

#define kStartInstanceScene @"startInstanceScene"

@interface RIStartInstanceViewController : UIViewController

@property (strong, nonatomic) Task *task;
@property (weak, nonatomic) IBOutlet UILabel *taskNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *goButton;

- (IBAction)goButtonPressed:(id)sender;

@end
