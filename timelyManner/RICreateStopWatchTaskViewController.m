//
//  RICreateStopWatchTaskViewController.m
//  timelyManner
//
//  Created by Dan Vingo on 7/8/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import "RICreateStopWatchTaskViewController.h"
#import "RITaskManager.h"
#import "Task.h"

@implementation RICreateStopWatchTaskViewController
@synthesize nameLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.nameLabel becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)createButtonPressed:(id)sender {
    if (self.nameLabel.text.length > 0) {
        [[RITaskManager sharedInstance] saveTaskWithName:self.nameLabel.text taskType:kStopWatchTask];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        // TODO display error label
    }
}

@end
