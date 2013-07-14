//
//  RIActiveTasksViewController.m
//  timelyManner
//
//  Created by Dan Vingo on 7/8/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import "RIActiveTasksViewController.h"
#import "RIActiveTaskCell.h"
#import "RITaskManager.h"

#define kActiveTaskCellIdentifier @"ActiveTaskCell"

@interface RIActiveTasksViewController ()
@property (strong, nonatomic) NSArray *activeTasks;
@end

@implementation RIActiveTasksViewController
@synthesize activeTasks;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    self.activeTasks = [[RITaskManager sharedInstance] loadTasks];
    NSLog(@"Active tasks are: %@", self.activeTasks);
    [self.tableView reloadData];
}

- (void)setupTableView {
    // Register Task Cell
    UINib *taskCellNib = [UINib nibWithNibName:kActiveTaskCellIdentifier bundle:nil];
    [self.tableView registerNib:taskCellNib forCellReuseIdentifier:kActiveTaskCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.activeTasks.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RIActiveTaskCell *cell = (RIActiveTaskCell *)[tableView dequeueReusableCellWithIdentifier:kActiveTaskCellIdentifier forIndexPath:indexPath];
    cell.taskLabel.text = @"Commute";
    cell.timerLengthLabel.text = @"45.24";
    
    if (self.activeTasks && self.activeTasks.count > 0) {
        Task *task = (Task *)[self.activeTasks objectAtIndex:indexPath.row];
        cell.taskLabel.text = task.name;
        cell.timerLengthLabel.text = @"abc";//[formatter stringFromDate:task.lastRun];
        return cell;
    }
    
    // TODO Set no data view
    
    return cell;
}

@end
