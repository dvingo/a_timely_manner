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

@interface RITaskDetailViewController ()
@property (strong, nonatomic) NSArray *instances;
@property (strong, nonatomic) NSString *CellIdentifier;
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
    [self setupNavBar];
    [self setupTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    self.instances = [self.task.instances allObjects];
}

#pragma mark - Setup helpers

- (void)setupNavBar {
    self.navigationItem.title = self.task.name;
    
    // Create instance button
    UIBarButtonItem *addInstanceButton = [[UIBarButtonItem alloc]
                                          initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                          target:self
                                          action:@selector(createNewInstanceButtonPressed)];
    self.navigationItem.rightBarButtonItem = addInstanceButton;
}

- (void)createNewInstanceButtonPressed {
    if ([self.task isTripTask]) {
        RIStartInstanceViewController *startTripInstanceViewController =
            [self.storyboard instantiateViewControllerWithIdentifier:kStartTripInstanceScene];
        startTripInstanceViewController.task = self.task;
        [self.navigationController pushViewController:startTripInstanceViewController animated:YES];
    } else {
        RIStartInstanceViewController *startInstanceViewController = [self.storyboard
                                                                      instantiateViewControllerWithIdentifier:kStartInstanceScene];
        startInstanceViewController.task = self.task;
        [self.navigationController pushViewController:startInstanceViewController animated:YES];
    }
}

- (void)setupTableView {
    // Register tableview cells
    if ([self.task isStopWatchTask]) {
        self.CellIdentifier = kInstanceCellIdentifier;
        UINib *instanceCellNib = [UINib nibWithNibName:kInstanceCellIdentifier bundle:nil];
        [self.tableView registerNib:instanceCellNib forCellReuseIdentifier:kInstanceCellIdentifier];
    } else if ([self.task isTripTask]) {
        self.CellIdentifier = kTripInstanceCellIdentifier;
        UINib *tripCellNib = [UINib nibWithNibName:@"TripCell" bundle:nil];
        [self.tableView registerNib:tripCellNib forCellReuseIdentifier:kTripInstanceCellIdentifier];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.task.instances.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.CellIdentifier forIndexPath:indexPath];
    if (self.instances && self.instances.count > 0) {
        Instance *instance = self.instances[indexPath.row];

        // StopWatch cell
        if ([self.task isStopWatchTask]) {
            // Config StopWatchCell
            RIInstanceCell *cell = [tableView dequeueReusableCellWithIdentifier:self.CellIdentifier
                                                                   forIndexPath:indexPath];
            [cell populateCellWithInstance:instance rowNumber:indexPath.row];
        // Trip cell
        } else if ([self.task isTripTask]) {
            RITripCell *cell = [tableView dequeueReusableCellWithIdentifier:self.CellIdentifier
                                                               forIndexPath:indexPath];
            [cell populateCellWithInstance:instance rowNumber:indexPath.row];
        }
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.task.instances && self.task.instances.count > 0) {
        Instance *instance = self.instances[indexPath.row];
        NSLog(@"Got instance: %@", instance);
        // Go to instance detail view
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
