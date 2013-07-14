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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
        NSDateFormatter *f = [NSDateFormatter new];
        f.dateFormat = @"yyyy-MM-dd";
        cell.textLabel.text = [f stringFromDate:instance.createdAt];
    }

    return cell;
}

@end
