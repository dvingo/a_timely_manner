//
//  RICreateTripTaskViewController.m
//  timelyManner
//
//  Created by Dan Vingo on 7/8/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import "RIConstants.h"
#import "RICreateTripTaskViewController.h"
#import "RITaskManager.h"

@implementation RICreateTripTaskViewController
@synthesize currentLocationSwitch;
@synthesize endLocationSwitch;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameField.delegate = self;
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

- (IBAction)createButtonWasPressed:(id)sender {
    // Create the task
    if (self.nameField.text.length > 0) {
        [[RITaskManager sharedInstance] saveTaskWithName:self.nameField.text taskType:kTripTask];
        NSLog(@"after create instance");
        [self.navigationController popToRootViewControllerAnimated:YES];
        NSLog(@"after pop to root");
    } else {
        // TODO display error label
    }
}

- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
    NSLog(@"in shouldrelace");
    if (self.nameField.text.length > kMaxNameLength) {
        NSLog(@"in return no");
        return NO;
    }
    NSLog(@"in return yes");
    return YES;
}

@end
