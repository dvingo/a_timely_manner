//
//  RICreateStopWatchTaskViewController.m
//  timelyManner
//
//  Created by Dan Vingo on 7/8/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import "RICreateStopWatchTaskViewController.h"
#import "RITaskManager.h"
#import "Task.h"

@interface RICreateStopWatchTaskViewController ()

@end

@implementation RICreateStopWatchTaskViewController
@synthesize nameLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.nameLabel becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)createButtonPressed:(id)sender {
    if (self.nameLabel.text.length > 0) {
        [[RITaskManager sharedInstance] saveTaskWithName:self.nameLabel.text taskType:kStopWatchTask];
//        self.tabBarController.selectedIndex = 1;
        
        UIView *fromView = self.tabBarController.selectedViewController.view;
        UIView *toView = [[self.tabBarController.viewControllers objectAtIndex:1] view];

        NSLog(@"to view is %@", toView);
        
        [UIView transitionFromView:fromView
                            toView:toView
                          duration:0.5
                           options:UIViewAnimationOptionCurveEaseIn
                        completion:^(BOOL finished) {
                            if (finished) {
                                [self.navigationController popToRootViewControllerAnimated:NO];
                                self.tabBarController.selectedIndex = 1;

                            }
                        }];
        
//        UINavigationController *tasksViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"tasksViewNavController"];
//        [self.tabBarController presentViewController:tasksViewController animated:YES completion:nil];
//        [self.navigationController presentViewController:tasksViewController animated:YES completion:nil];
    } else {
        // TODO display error label
    }
}

@end
