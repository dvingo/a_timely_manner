//
//  RITasksViewController.m
//  timelyManner
//
//  Created by Dan Vingo on 6/29/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import "RIAppDelegate.h"
#import "RITasksViewController.h"
#import "RICreateTaskViewController.h"
#import "RIStopWatchDetailViewController.h"
#import "RITaskDetailViewController.h"
#import "RITripDetailViewController.h"
#import "RITaskCell.h"
#import "Task.h"
#import "RITaskManager.h"
#import "RIConstants.h"

#define kTaskCellIdentifier @"TaskCell"
#define kRowHeight 80.0f

@interface RITasksViewController ()
@property (strong, nonatomic) NSArray *tasks;
@end

@implementation RITasksViewController
@synthesize tasks;

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.frame = self.view.frame;
    self.tasks = [[RITaskManager sharedInstance] loadTasks];

    [self setupNavBar];
    [self setupTableView];
}

- (void)setupNavBar {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120.0, 44.0)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"Tasks";
    titleLabel.textColor = kDarkBlueColor;
    titleLabel.font = [UIFont fontWithName:kRIFontRegular size:24.0];
    self.navigationItem.titleView = titleLabel;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40.0, 30.0)];
    [button setBackgroundImage:[UIImage imageNamed:@"plus-sign-light"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(createNewTaskPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *plusButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = plusButton;
}

- (void)viewWillAppear:(BOOL)animated {
    // TODO Use notifications to only update when needed, not every appearance
    self.tasks = [[RITaskManager sharedInstance] loadTasks];
    [self.tableView reloadData];
}

- (void)setupTableView {
    // Register Task Cell
    UINib *taskCellNib = [UINib nibWithNibName:kTaskCellIdentifier bundle:nil];
    [self.tableView registerNib:taskCellNib forCellReuseIdentifier:kTaskCellIdentifier];
    self.tableView.backgroundColor = kLightGreyColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tasks.count;
}

#pragma mark - Table view delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RITaskCell *cell = [tableView dequeueReusableCellWithIdentifier:kTaskCellIdentifier forIndexPath:indexPath];
    cell.taskNameLabel.text = @"Commute";
    cell.dayLabel.text = @"today";
    
    if (self.tasks && self.tasks.count > 0) {
        NSLog(@"WE HAVE %d tasks", self.tasks.count);
        [cell populateViewsWithTask:(Task *)[self.tasks objectAtIndex:indexPath.row]];
    }
    
    // TODO Set no data view
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Task *selectedTask = (Task *)self.tasks[indexPath.row];
    RITaskDetailViewController *taskDetailViewController =
        [self.storyboard instantiateViewControllerWithIdentifier:ktaskDetailScene];
    taskDetailViewController.task = selectedTask;
    [self.navigationController pushViewController:taskDetailViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRowHeight;
}

#pragma mark - Create New Task Button

- (void)createNewTaskPressed:(id)sender {
    RICreateTaskViewController *createTaskViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"createTaskScene"];
    [self.navigationController pushViewController:createTaskViewController animated:YES];
}

@end
