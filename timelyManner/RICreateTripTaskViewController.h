//
//  RICreateTripTaskViewController.h
//  timelyManner
//
//  Created by Dan Vingo on 7/8/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RICreateTripTaskViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UISwitch *currentLocationSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *endLocationSwitch;

- (IBAction)createButtonWasPressed:(id)sender;

@end
