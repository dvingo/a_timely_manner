//
//  RIStartInstanceViewController.m
//  timelyManner
//
//  Created by Dan Vingo on 7/16/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import "RIActiveInstancesViewController.h"
#import "RIConstants.h"
#import "RIStartInstanceViewController.h"
#import "RITaskManager.h"
#import "RIViewsHelper.h"

@implementation RIStartInstanceViewController
@synthesize taskNameLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[RIViewsHelper sharedInstance] titleLabelWithText:@"New Instance"];
    self.startNewLabel.font = [UIFont fontWithName:kRIFontBold size:30.0];
    self.instanceLabel.font = [UIFont fontWithName:kRIFontBold size:30.0];
    self.goButton.titleLabel.font = [UIFont fontWithName:kRIFontBold size:60.0];
    
    self.taskNameLabel.text = [NSString stringWithFormat:@"%@", self.task.name];
    UIImage *buttonImage = [[UIImage imageNamed:kOrangeButtonImage]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(3.0, 3.0, 3.0, 3.0)];
    UIImage *selectedImage = [[UIImage imageNamed:kOrangeButtonHighlightedImage]
                              resizableImageWithCapInsets:UIEdgeInsetsMake(3.0, 3.0, 3.0, 3.0)];
    self.goButton.backgroundColor = [UIColor clearColor];
    
    [self.goButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [self.goButton setBackgroundImage:buttonImage forState:UIControlStateSelected];
    [self.goButton setBackgroundImage:selectedImage forState:UIControlStateHighlighted];
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
