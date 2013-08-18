//
//  RIStartInstanceViewController.m
//  timelyManner
//
//  Created by Dan Vingo on 7/16/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import "RIStartInstanceViewController.h"
#import "RIActiveInstancesViewController.h"
#import "RITaskManager.h"
#import "RIConstants.h"

@implementation RIStartInstanceViewController
@synthesize taskNameLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.taskNameLabel.text = [NSString stringWithFormat:@"\"%@\"", self.task.name];
    UIImage *buttonImage = [[UIImage imageNamed:kOrangeButtonImage] resizableImageWithCapInsets:UIEdgeInsetsMake(6.0, 6.0, 6.0, 6.0)];
    self.goButton.backgroundColor = [UIColor clearColor];
    
    [self.goButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [self.goButton setBackgroundImage:buttonImage forState:UIControlStateSelected];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)goButtonPressed:(id)sender {
    NSLog(@"creating new instance");
    [[RITaskManager sharedInstance] createInstanceWithTask:self.task];
    [self.tabBarController setSelectedIndex:1];
    [self.navigationController popToRootViewControllerAnimated:NO];
}

@end
