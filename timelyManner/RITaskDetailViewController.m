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
    self.instances = [[self.task.instances allObjects] sortedArrayUsingComparator:^(id obj1, id obj2) {
        Instance *i1 = (Instance *)obj1;
        Instance *i2 = (Instance *)obj2;
        return [i2.start compare:i1.start];
    }];
    if (self.instances.count == 0) {
        UILabel *emptyLabel = [[UILabel alloc] initWithFrame:CGRectMake(60.0, 100.0, 200.0, 40.0)];
        emptyLabel.text = @"No Instances. Start one.";
        [self.view addSubview:emptyLabel];
    } else {
        // first see if we need to set it to alpha = 0
        NSLog(@"here");
    }
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
        NSLog(@"ABOUT TO START TRIP INSTANCE");
        RIStartTripInstanceViewController *startTripInstanceViewController =
            [self.storyboard instantiateViewControllerWithIdentifier:kStartTripInstanceScene];
        startTripInstanceViewController.task = self.task;
        [self.navigationController pushViewController:startTripInstanceViewController animated:YES];
    } else {
        NSLog(@"ABOUT TO START STOPWATCH INSTANCE");
        RIStartInstanceViewController *startInstanceViewController = [self.storyboard
                                                                      instantiateViewControllerWithIdentifier:kStartInstanceScene];
        startInstanceViewController.task = self.task;
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
            NSLog(@"STOP WATCH CELL");
            RIInstanceCell *instanceCell = [tableView dequeueReusableCellWithIdentifier:kInstanceCellIdentifier forIndexPath:indexPath];

            [instanceCell populateCellWithInstance:instance rowNumber:indexPath.row];

            NSLog(@"Elapsed time: %@", instanceCell.elapsedTimeLabel.text);
            NSLog(@"date label: %@", instanceCell.dateLabel.text);
            NSLog(@"clock time label: %@", instanceCell.clockTimeLabel.text);
            NSLog(@"\n\n\n");
            return instanceCell;

        // Trip cell
        } else if ([self.task isTripTask]) {
            NSLog(@"TRIP CELL");
            RITripCell *tripCell = [tableView dequeueReusableCellWithIdentifier:kTripInstanceCellIdentifier
                                                               forIndexPath:indexPath];
            [tripCell populateCellWithInstance:instance rowNumber:indexPath.row];
            NSDateFormatter *f = [NSDateFormatter new];
            f.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            NSLog(@"TRIP CELL END DATE: %@", [f stringFromDate:instance.end]);
            NSLog(@"END LOC: %@, %@", instance.endLatitude, instance.endLongitude);
            return tripCell;
        }
    }
    return nil;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.task.instances && self.task.instances.count > 0) {
        Instance *instance = self.instances[indexPath.row];
        NSLog(@"Got instance: %@", instance);
        // Go to instance detail view
    }
}

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
