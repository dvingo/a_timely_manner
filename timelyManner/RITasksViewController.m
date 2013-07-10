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
#import "RITaskCell.h"
#import "Task.h"
#import "RITaskManager.h"

#define kTaskCellIdentifier @"TaskCell"
#define kBackgroundColor [UIColor colorWithRed:236.0/255.0f green:236.0/255.0f blue:236.0/255.0f alpha:1.0f]
#define kRowHeight 80.0f

@interface RITasksViewController ()
@property (strong, nonatomic) NSArray *tasks;
@property (strong, nonatomic) NSDateFormatter *formatter;
@end

@implementation RITasksViewController
@synthesize tasks, formatter;

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.frame = self.view.frame;
    self.tasks = [[RITaskManager sharedInstance] loadTasks];
    
    self.formatter = [NSDateFormatter new];
    self.formatter.dateFormat = @"MMM d";
    
    self.navigationItem.title = @"Tasks";
    
    [self setupTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    // Use notifications to only update when needed, not every appearance
    self.tasks = [[RITaskManager sharedInstance] loadTasks];
    [self.tableView reloadData];
}

- (void)setupTableView {
    // Register Task Cell
    UINib *taskCellNib = [UINib nibWithNibName:@"TaskCell" bundle:nil];
    [self.tableView registerNib:taskCellNib forCellReuseIdentifier:kTaskCellIdentifier];
    self.tableView.backgroundColor = kBackgroundColor;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RITaskCell *cell = [tableView dequeueReusableCellWithIdentifier:kTaskCellIdentifier forIndexPath:indexPath];
    cell.taskNameLabel.text = @"Commute";
    cell.dayLabel.text = @"today";
    
    if (self.tasks && self.tasks.count > 0) {
        Task *task = (Task *)[self.tasks objectAtIndex:indexPath.row];
        cell.taskNameLabel.text = task.name;
        cell.dayLabel.text = [formatter stringFromDate:task.lastRun];
        return cell;
    }
    
    // TODO Set no data view
    
    return nil;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RIStopWatchDetailViewController *stopWatchDetailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"stopWatchDetailScene"];
    stopWatchDetailViewController.task = (Task *)self.tasks[indexPath.row];
    [self.navigationController pushViewController:stopWatchDetailViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRowHeight;
}

- (IBAction)newTaskButtonPressed:(id)sender {
    RICreateTaskViewController *createTaskViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"createTaskScene"];
    [self.navigationController pushViewController:createTaskViewController animated:YES ];
}

@end
