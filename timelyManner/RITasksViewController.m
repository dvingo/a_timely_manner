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
#import "RIViewsHelper.h"
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
    self.tasks = [[RITaskManager sharedInstance] sortedTasksByCreatedAtDescending:self.tasks];

    [self setupNavBar];
    [self setupTableView];
}

- (void)setupNavBar {
    self.navigationItem.titleView = [[RIViewsHelper sharedInstance] titleLabelWithText:@"Tasks"];
    self.navigationItem.rightBarButtonItem = [[RIViewsHelper sharedInstance] makeAddButtonWithTarget:self
                                              action:@selector(createNewTaskPressed:)];
}

- (void)viewWillAppear:(BOOL)animated {
    // TODO Use notifications to only update when needed, not every appearance
    self.tasks = [[RITaskManager sharedInstance] loadTasks];
    self.tasks = [[RITaskManager sharedInstance] sortedTasksByCreatedAtDescending:self.tasks];
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
        Task *t = (Task *)[self.tasks objectAtIndex:indexPath.row];
        NSLog(@"task created at: %@, %@", t.name, t.createdAt);
        [cell populateViewsWithTask:(Task *)[self.tasks objectAtIndex:indexPath.row]];
    }
    
    // TODO Set no data view
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Task *selectedTask = (Task *)self.tasks[indexPath.row];
    RITaskDetailViewController *taskDetailViewController =
        [self.storyboard instantiateViewControllerWithIdentifier:ktaskDetailScene];
    
    taskDetailViewController.navigationItem.leftBarButtonItem = [[RIViewsHelper sharedInstance]
                                                createBackButtonWithTarget:self action:@selector(back)];
    taskDetailViewController.task = selectedTask;
    [self.navigationController pushViewController:taskDetailViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRowHeight;
}

#pragma mark - Create New Task Button

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createNewTaskPressed:(id)sender {
    RICreateTaskViewController *createTaskViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"createTaskScene"];
    createTaskViewController.navigationItem.leftBarButtonItem = [[RIViewsHelper sharedInstance]
        createBackButtonWithTarget:self action:@selector(back)];
    [self.navigationController pushViewController:createTaskViewController animated:YES];
}

@end
