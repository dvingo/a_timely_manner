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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RIInstanceCell *cell = [tableView dequeueReusableCellWithIdentifier:kInstanceCellIdentifier forIndexPath:indexPath];

    if (self.instances) {
        Instance *instance = self.instances[indexPath.row];
        
        if (instance.end) {
            NSLog(@"instance has end date: %@", instance.end);
//            cell.elapsedTimeLabel.text = [[RITimeHelper sharedInstance] timeBetweenStartDate:instance.start
//                                                                                     endDate:instance.end
//                                                                                  withFormat:kHoursMinutes];
            NSString *timeBetween = [[RITimeHelper sharedInstance] timeBetweenStartDate:instance.start
                                                                                     endDate:instance.end
                                                                                  withFormat:kHoursMinutes];
            
            cell.elapsedTimeLabel.text = timeBetween;
            
            NSLog(@"time between is :%@\n\n", timeBetween);
            
            
            cell.dateLabel.text = [[RITimeHelper sharedInstance] dateStringFromDate:instance.end];
            cell.clockTimeLabel.text = [[RITimeHelper sharedInstance] timeBetweenStartDate:instance.start
                                                                                   endDate:instance.end
                                                                                withFormat:kstartEndHours];
        } else {
            NSLog(@"instance does not have end date: %@", instance.end);
            NSLog(@"instance start date: %@", instance.start);
            NSDate *now = [NSDate date];
            cell.elapsedTimeLabel.text = [[RITimeHelper sharedInstance] timeBetweenStartDate:instance.start
                                                                                     endDate:now
                                                                                  withFormat:kHoursMinutes];
            
            cell.dateLabel.text = [[RITimeHelper sharedInstance] dateStringFromDate:now];
            
            cell.clockTimeLabel.text = [[RITimeHelper sharedInstance] timeBetweenStartDate:instance.start
                                                                                   endDate:now
                                                                                withFormat:kstartEndHours];
        }
    }

    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
