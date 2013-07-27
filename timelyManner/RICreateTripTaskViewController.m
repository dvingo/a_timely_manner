//
//  RICreateTripTaskViewController.m
//  timelyManner
//
//  Created by Dan Vingo on 7/8/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import "RICreateTripTaskViewController.h"
#import "RITaskManager.h"

@interface RICreateTripTaskViewController ()

@end

@implementation RICreateTripTaskViewController
@synthesize nameLabel;
@synthesize currentLocationSwitch;
@synthesize endLocationSwitch;
@synthesize scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.frame = CGRectMake(0, 100.0, 320.0, 400.0);
    NSLog(@"scroll view y: %f", self.scrollView.frame.origin.y);
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * 2);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)createButtonWasPressed:(id)sender {
    // Create the task
    if (self.nameLabel.text.length > 0) {
        [[RITaskManager sharedInstance] saveTaskWithName:self.nameLabel.text taskType:kTripTask];
        NSLog(@"after create instance");
        [self.navigationController popToRootViewControllerAnimated:YES];
        NSLog(@"after pop to root");
    } else {
        // TODO display error label
    }
}

@end
