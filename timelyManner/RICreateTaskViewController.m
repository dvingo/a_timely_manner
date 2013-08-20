//
//  RICreateTaskViewController.m
//  timelyManner
//
//  Created by Dan Vingo on 7/8/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import "RIButton.h"
#import "RICreateTaskViewController.h"
#import "RICreateStopWatchTaskViewController.h"
#import "RICreateTimerTaskViewController.h"
#import "RICreateTripTaskViewController.h"
#import "RIConstants.h"
#import "RIViewsHelper.h"

@implementation RICreateTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kLightGreyColor;
    self.stopWatchButton.titleLabel.font = [UIFont fontWithName:kRIFontBold size:50.0];
    self.timerButton.titleLabel.font = [UIFont fontWithName:kRIFontBold size:50.0];
    self.tripButton.titleLabel.font = [UIFont fontWithName:kRIFontBold size:50.0];
    self.navigationItem.titleView = [[RIViewsHelper sharedInstance] titleLabelWithText:@"New Task"];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"createStopWatchSegue"]) {
        RICreateStopWatchTaskViewController *createStopWatchViewController = segue.destinationViewController;
        createStopWatchViewController.navigationItem.leftBarButtonItem = [[RIViewsHelper sharedInstance]
                                                                     createBackButtonWithTarget:self action:@selector(back)];
        createStopWatchViewController.navigationItem.titleView = [[RIViewsHelper sharedInstance] titleLabelWithText:@"New Stopwatch"];

    } else if ([segue.identifier isEqualToString:@"createTimerSegue"]) {
        RICreateTimerTaskViewController *createTimerViewController = segue.destinationViewController;
        createTimerViewController.navigationItem.leftBarButtonItem = [[RIViewsHelper sharedInstance]
                                                                          createBackButtonWithTarget:self action:@selector(back)];
        createTimerViewController.navigationItem.titleView = [[RIViewsHelper sharedInstance] titleLabelWithText:@"New Timer"];

    } else if ([segue.identifier isEqualToString:@"createTripSegue"]) {
        RICreateTripTaskViewController *createTripViewController = segue.destinationViewController;
        createTripViewController.navigationItem.leftBarButtonItem = [[RIViewsHelper sharedInstance]
                                                                     createBackButtonWithTarget:self action:@selector(back)];
        createTripViewController.navigationItem.titleView = [[RIViewsHelper sharedInstance] titleLabelWithText:@"New Trip"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
