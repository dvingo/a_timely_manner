//
//  RIActiveInstancesViewController.m
//  timelyManner
//
//  Created by Dan Vingo on 7/8/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import "RIActiveInstancesViewController.h"
#import "RIActiveInstanceCell.h"
#import "RIConstants.h"
#import "RITaskManager.h"

#define kActiveInstanceCellIdentifier @"ActiveInstanceCell"

@interface RIActiveInstancesViewController ()
@property (strong, nonatomic) NSArray *activeInstances;
@property (strong, nonatomic) UIView *noDataView;
@property (strong, nonatomic) NSTimer *countingTimer;
@end

@implementation RIActiveInstancesViewController
@synthesize activeInstances;
@synthesize noDataView;
@synthesize countingTimer;

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
    if (self.activeInstances.count == 0) {
        NSLog(@"There are no active instances");
        self.noDataView.alpha = 1.0f;
        [self.tableView setUserInteractionEnabled:NO];
    } else {
        NSLog(@"There are %d active instances", self.activeInstances.count);
        self.noDataView.alpha = 0.0f;
        [self.tableView setUserInteractionEnabled:YES];
        [self setupTimer];
    }
    
    [self.tableView reloadData];
}

- (void)setupTableView {
    self.tableView.backgroundColor = kLightGreyColor;
    
    // Register Task Cell
    UINib *taskCellNib = [UINib nibWithNibName:kActiveInstanceCellIdentifier bundle:nil];
    [self.tableView registerNib:taskCellNib forCellReuseIdentifier:kActiveInstanceCellIdentifier];
    
    // Create empty data view
    self.noDataView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,
                                                               CGRectGetWidth(self.view.frame),
                                                               CGRectGetHeight(self.view.frame))];
    self.noDataView.backgroundColor = [UIColor whiteColor];
    [self.noDataView setUserInteractionEnabled:NO];
    self.noDataView.alpha = 0.0f;

    UILabel *emptyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                    floorf(CGRectGetHeight(self.view.frame) * .20),
                                                                    CGRectGetWidth(self.view.frame), 100.0)];
    emptyLabel.text = NSLocalizedString(@"No active instances", @"No active instances");
    emptyLabel.font = [UIFont fontWithName:kRIFontBold size:45.0];
    emptyLabel.textColor = kDarkBlueColor;
    emptyLabel.lineBreakMode = NSLineBreakByWordWrapping;
    emptyLabel.numberOfLines = 0;
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    [self.noDataView addSubview:emptyLabel];
    [self.view addSubview:self.noDataView];
}

- (void)setupTimer {
    NSLog(@"in setupTimer");
    if (self.countingTimer == nil) {
        NSLog(@"Starting timer");
        self.countingTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                              target:self
                                                            selector:@selector(countingTimerDidFire:)
                                                            userInfo:nil
                                                             repeats:YES];
    }
}

- (void)countingTimerDidFire:(NSTimer *)timer {
    NSArray *visibleCells = self.tableView.visibleCells;
    for (RIActiveInstanceCell *cell in visibleCells) {
        [cell updateTimerLengthLabel];
    }
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
    return 120.0;
}

#pragma mark - Table view delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RIActiveInstanceCell *cell = (RIActiveInstanceCell *)[tableView dequeueReusableCellWithIdentifier:kActiveInstanceCellIdentifier forIndexPath:indexPath];
    cell.taskLabel.text = @"Commute";
    cell.timerLengthLabel.text = @"45.24";
    
    if (self.activeInstances && self.activeInstances.count > 0) {
        Instance *instance = (Instance *)[self.activeInstances objectAtIndex:indexPath.row];
        // This should be changed to [cell populateViewsWithInstance:instance];
        cell.instance = instance;
        [cell populateViews];
    }
    
    // TODO Set no data view
    
    return cell;
}

- (void)dealloc {
    if (self.countingTimer) {
        [self.countingTimer invalidate];
    }
}

@end
