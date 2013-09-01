//
//  RITaskDetailViewController.m
//  timelyManner
//
//  Created by Dan Vingo on 7/27/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import "Instance.h"
#import "RITaskDetailViewController.h"
#import "RIStartInstanceViewController.h"
#import "RIStartTripInstanceViewController.h"
#import "RIInstanceCell.h"
#import "RITripCell.h"
#import "RIViewsHelper.h"
#import "RIConstants.h"

@interface RITaskDetailViewController ()
@property (strong, nonatomic) NSArray *instances;
@end

@implementation RITaskDetailViewController
@synthesize instances;
@synthesize task;

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kLightGreyColor;
    [self setupNavBar];
    [self setupTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    self.instances = [[self.task.instances allObjects] sortedArrayUsingComparator:^(id obj1, id obj2) {
        Instance *i1 = (Instance *)obj1;
        Instance *i2 = (Instance *)obj2;
        return [i2.start compare:i1.start];
    }];
    if (self.instances.count == 0) {
        UILabel *emptyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                        floorf(CGRectGetHeight(self.view.frame) * .20),
                                                                        CGRectGetWidth(self.view.frame), 100.0)];
        emptyLabel.text = NSLocalizedString(@"No Instances. Start one.", @"No Instances. Start one.");
        emptyLabel.font = [UIFont fontWithName:kRIFontBold size:45.0];
        emptyLabel.textColor = kDarkBlueColor;
        emptyLabel.lineBreakMode = NSLineBreakByWordWrapping;
        emptyLabel.numberOfLines = 0;
        emptyLabel.textAlignment = NSTextAlignmentCenter;
        emptyLabel.backgroundColor = [UIColor clearColor];
        [self.view addSubview:emptyLabel];
    }
}

#pragma mark - Setup helpers

- (void)setupNavBar {
    self.navigationItem.titleView = [[RIViewsHelper sharedInstance] titleLabelWithText:self.task.name];
    self.navigationItem.rightBarButtonItem = [[RIViewsHelper sharedInstance]
                                                  makeAddButtonWithTarget:self
                                                  action:@selector(createNewInstanceButtonPressed)];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Nav bar delegate

- (void)createNewInstanceButtonPressed {
    if ([self.task isTripTask]) {
        RIStartTripInstanceViewController *startTripInstanceViewController =
            [self.storyboard instantiateViewControllerWithIdentifier:kStartTripInstanceScene];
        
        
        startTripInstanceViewController.task = self.task;
        startTripInstanceViewController.navigationItem.leftBarButtonItem = [[RIViewsHelper sharedInstance]
                                                                     createBackButtonWithTarget:self action:@selector(back)];
        [self.navigationController pushViewController:startTripInstanceViewController animated:YES];
    } else {
        RIStartInstanceViewController *startInstanceViewController = [self.storyboard
                                                                      instantiateViewControllerWithIdentifier:kStartInstanceScene];
        startInstanceViewController.task = self.task;
        startInstanceViewController.navigationItem.leftBarButtonItem = [[RIViewsHelper sharedInstance]
                                                                            createBackButtonWithTarget:self action:@selector(back)];
        [self.navigationController pushViewController:startInstanceViewController animated:YES];
    }
}

- (void)setupTableView {
    UINib *instanceCellNib = [UINib nibWithNibName:kInstanceCellIdentifier bundle:nil];
    [self.tableView registerNib:instanceCellNib forCellReuseIdentifier:kInstanceCellIdentifier];

    UINib *tripCellNib = [UINib nibWithNibName:@"TripCell" bundle:nil];
    [self.tableView registerNib:tripCellNib forCellReuseIdentifier:kTripInstanceCellIdentifier];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.task.instances.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.instances && self.instances.count > 0) {
        Instance *instance = self.instances[indexPath.row];

        // StopWatch cell
        if ([self.task isStopWatchTask]) {
            // Config StopWatchCell
            RIInstanceCell *instanceCell = [tableView dequeueReusableCellWithIdentifier:kInstanceCellIdentifier forIndexPath:indexPath];
            [instanceCell populateCellWithInstance:instance rowNumber:indexPath.row];
            return instanceCell;

        // Trip cell
        } else if ([self.task isTripTask]) {
            RITripCell *tripCell = [tableView dequeueReusableCellWithIdentifier:kTripInstanceCellIdentifier
                                                               forIndexPath:indexPath];
            [tripCell populateCellWithInstance:instance rowNumber:indexPath.row];
            NSDateFormatter *f = [NSDateFormatter new];
            f.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            return tripCell;
        }
    }
    return nil;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.task isStopWatchTask]) {
        return kInstanceCellHeight;
    } else if ([self.task isTripTask]) {
        return kTripInstanceCellHeight;
    } else {
        return kInstanceCellHeight;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
