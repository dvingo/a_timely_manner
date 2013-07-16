//
//  RIStopWatchDetailViewController.m
//  timelyManner
//
//  Created by Dan Vingo on 7/9/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import "RIStopWatchDetailViewController.h"
#import "RITaskManager.h"
#import "Instance.h"

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
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

- (void)viewWillAppear:(BOOL)animated {
    self.instances = [self.task.instances allObjects];
}

- (void)createNewInstance {
    NSLog(@"creating new instance");
    [[RITaskManager sharedInstance] createInstanceWithTask:self.task];
    // Display "About to start screen"
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.task.instances.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    if (self.instances) {
        Instance *instance = self.instances[indexPath.row];
        
        if (instance.end) {
            NSLog(@"instance has end date: %@", instance.end);
            cell.textLabel.text = [[RITaskManager sharedInstance] timeBetweenStartDate:instance.start endDate:instance.end];
        } else {
            NSLog(@"instance does not have end date: %@", instance.end);
            NSLog(@"instance start date: %@", instance.start);
            cell.textLabel.text = [[RITaskManager sharedInstance] timeElapsedSinceDate:instance.start];
        }
    }

    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
