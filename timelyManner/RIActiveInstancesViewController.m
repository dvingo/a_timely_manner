//
//  RIActiveInstancesViewController.m
//  timelyManner
//
//  Created by Dan Vingo on 7/8/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import "RIActiveInstancesViewController.h"
#import "RIActiveInstanceCell.h"
#import "RITaskManager.h"

#define kActiveInstanceCellIdentifier @"ActiveInstanceCell"

@interface RIActiveInstancesViewController ()
@property (strong, nonatomic) NSArray *activeInstances;
@end

@implementation RIActiveInstancesViewController
@synthesize activeInstances;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    self.activeInstances = [[RITaskManager sharedInstance] loadActiveInstances];
    NSLog(@"There are %d active instances", self.activeInstances.count);
    
    [self.tableView reloadData];
}

- (void)setupTableView {
    // Register Task Cell
    UINib *taskCellNib = [UINib nibWithNibName:kActiveInstanceCellIdentifier bundle:nil];
    [self.tableView registerNib:taskCellNib forCellReuseIdentifier:kActiveInstanceCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.activeInstances.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110.0;
}

#pragma mark - Table view delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RIActiveInstanceCell *cell = (RIActiveInstanceCell *)[tableView dequeueReusableCellWithIdentifier:kActiveInstanceCellIdentifier forIndexPath:indexPath];
    cell.taskLabel.text = @"Commute";
    cell.timerLengthLabel.text = @"45.24";
    
    if (self.activeInstances && self.activeInstances.count > 0) {
        Instance *instance = (Instance *)[self.activeInstances objectAtIndex:indexPath.row];
        cell.instance = instance;
        [cell populateViews];
    }
    
    // TODO Set no data view
    
    return cell;
}

@end
