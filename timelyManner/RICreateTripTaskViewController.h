//
//  RICreateTripTaskViewController.h
//  timelyManner
//
//  Created by Dan Vingo on 7/8/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RICreateTripTaskViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
@property (weak, nonatomic) IBOutlet UISwitch *currentLocationSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *endLocationSwitch;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)createButtonWasPressed:(id)sender;

@end
