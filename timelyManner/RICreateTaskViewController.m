//
//  RICreateTaskViewController.m
//  timelyManner
//
//  Created by Dan Vingo on 7/8/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import "RICreateTaskViewController.h"
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
    UIImage *buttonImage = [[UIImage imageNamed:kOrangeButtonImage]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(3.0, 3.0, 3.0, 3.0)];
    UIImage *selectedImage = [[UIImage imageNamed:kOrangeButtonHighlightedImage]
                              resizableImageWithCapInsets:UIEdgeInsetsMake(3.0, 3.0, 3.0, 3.0)];
    self.stopWatchButton.backgroundColor = [UIColor clearColor];
    [self.stopWatchButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [self.stopWatchButton setBackgroundImage:selectedImage forState:UIControlStateSelected];
    [self.stopWatchButton setBackgroundImage:selectedImage forState:UIControlStateHighlighted];
    [self.stopWatchButton setTitleColor:kDarkBlueColor forState:UIControlStateNormal];
    [self.stopWatchButton setTitleColor:kDarkBlueColor forState:UIControlStateSelected];
    self.stopWatchButton.titleLabel.font = [UIFont fontWithName:kRIFontBold size:50.0];
    
    self.timerButton.backgroundColor = [UIColor clearColor];
    self.timerButton.tintColor = kDarkBlueColor;
    [self.timerButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [self.timerButton setBackgroundImage:selectedImage forState:UIControlStateSelected];
    [self.timerButton setBackgroundImage:selectedImage forState:UIControlStateHighlighted];
    [self.timerButton setTitleColor:kDarkBlueColor forState:UIControlStateNormal];
    [self.timerButton setTitleColor:kDarkBlueColor forState:UIControlStateSelected];
    self.timerButton.titleLabel.font = [UIFont fontWithName:kRIFontBold size:50.0];
    
    self.tripButton.backgroundColor = [UIColor clearColor];
    [self.tripButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [self.tripButton setBackgroundImage:selectedImage forState:UIControlStateSelected];
    [self.tripButton setBackgroundImage:selectedImage forState:UIControlStateHighlighted];
    [self.tripButton setTitleColor:kDarkBlueColor forState:UIControlStateNormal];
    [self.tripButton setTitleColor:kDarkBlueColor forState:UIControlStateSelected];
    self.tripButton.titleLabel.font = [UIFont fontWithName:kRIFontBold size:50.0];

    self.navigationItem.titleView = [[RIViewsHelper sharedInstance] titleLabelWithText:@"New Task"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
