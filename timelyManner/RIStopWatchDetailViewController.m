//
//  RIStopWatchDetailViewController.m
//  timelyManner
//
//  Created by Dan Vingo on 7/9/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import "Instance.h"
#import "RIStartInstanceViewController.h"
#import "RIStopWatchDetailViewController.h"
#import "RIInstanceCell.h"
#import "RITaskManager.h"
#import "RITimeHelper.h"

@interface RIStopWatchDetailViewController ()
@property (strong, nonatomic) NSArray *instances;
@end

@implementation RIStopWatchDetailViewController
@synthesize task, instances;

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *addInstanceButton = [[UIBarButtonItem alloc]
                                          initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                               target:self
                                                               action:@selector(createNewInstance)];
    self.navigationItem.title = self.task.name;
    self.navigationItem.rightBarButtonItem = addInstanceButton;
    
    [self setupTableView];
}

- (void)setupTableView {
    // Register Instance Cell
    UINib *instanceCellNib = [UINib nibWithNibName:kInstanceCellIdentifier bundle:nil];
    [self.tableView registerNib:instanceCellNib forCellReuseIdentifier:kInstanceCellIdentifier];
}

- (void)viewWillAppear:(BOOL)animated {
    self.instances = [self.task.instances allObjects];
}

- (void)createNewInstance {
    RIStartInstanceViewController *startInstanceViewController = [self.storyboard
                                                                  instantiateViewControllerWithIdentifier:kStartInstanceScene];
    startInstanceViewController.task = self.task;
    [self.navigationController pushViewController:startInstanceViewController animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.task.instances.count;
}


#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RIInstanceCell *cell = [tableView dequeueReusableCellWithIdentifier:kInstanceCellIdentifier forIndexPath:indexPath];

    if (self.instances) {
        [cell populateCellWithInstance:(Instance *)self.instances[indexPath.row] rowNumber:indexPath.row];
    }

    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
