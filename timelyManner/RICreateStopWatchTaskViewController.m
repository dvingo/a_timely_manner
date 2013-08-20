//
//  RICreateStopWatchTaskViewController.m
//  timelyManner
//
//  Created by Dan Vingo on 7/8/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import "RICreateStopWatchTaskViewController.h"
#import "RITaskManager.h"
#import "RIConstants.h"
#import "Task.h"

@implementation RICreateStopWatchTaskViewController
@synthesize nameLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.nameField becomeFirstResponder];
    self.nameField.frame = CGRectMake(self.nameField.frame.origin.x, self.nameField.frame.origin.y,
                                      self.nameField.frame.size.width, self.nameField.frame.size.height + 10);
    self.nameField.font = [UIFont fontWithName:kRIFontRegular size:24.0];
    self.nameField.textColor = kDarkBlueColor;
    self.nameLabel.font = [UIFont fontWithName:kRIFontBold size:30.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)createButtonPressed:(id)sender {
    if (self.nameField.text.length > 0) {
        [[RITaskManager sharedInstance] saveTaskWithName:self.nameField.text taskType:kStopWatchTask];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        // TODO display error label
    }
}

@end
