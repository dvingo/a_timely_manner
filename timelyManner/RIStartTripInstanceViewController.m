//
//  RIStartTripInstanceViewController.m
//  timelyManner
//
//  Created by Dan Vingo on 7/27/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import "RIStartTripInstanceViewController.h"
#import "RITaskManager.h"

@interface RIStartTripInstanceViewController ()

@end

@implementation RIStartTripInstanceViewController
@synthesize task;
@synthesize taskNameLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)goButtonPressed:(id)sender {
    NSLog(@"creating new instance");

    [[RITaskManager sharedInstance] createInstanceWithTask:self.task
        startLocation:<#(CLLocation *)#> endLocation:<#(CLLocation *)#>];
    
    [[RITaskManager sharedInstance] createInstanceWithTask:self.task
                              usingCurrentLocationAsStartLocation:^{
                                  [self.tabBarController setSelectedIndex:1];
                                  [self.navigationController popToRootViewControllerAnimated:NO];
                              }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
