//
//  RITaskManager.m
//  timelyManner
//
//  Created by Dan Vingo on 7/8/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import "RIAppDelegate.h"
#import "RITaskManager.h"

#define kTaskName @"Task"
#define kInstanceName @"Instance"

@interface RITaskManager ()
@property (strong, nonatomic) NSArray *tasks;
@property (strong, nonatomic) NSArray *activeTasks;
@property (strong, nonatomic) CLLocationManager *locationManager;
@end

@implementation RITaskManager
@synthesize tasks, activeTasks;
@synthesize locationManager;

+ (id)sharedInstance {
    static RITaskManager *__sharedInstance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[RITaskManager alloc] init];
    });

    return __sharedInstance;
}

- (id)init {
    self = [super init];
    return self;
}

- (void)saveContext {
    RIAppDelegate *appDelegate = (RIAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error;
    [context save:&error];
}

- (void)refreshTask:(Task *)task {
    RIAppDelegate *appDelegate = (RIAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    [context refreshObject:task mergeChanges:YES];
}

- (NSArray *)loadTasks {
    RIAppDelegate *appDelegate = (RIAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *taskEntity = [NSEntityDescription entityForName:kTaskName
                                                  inManagedObjectContext:context];
    NSFetchRequest *taskRequest = [[NSFetchRequest alloc] init];
    [taskRequest setEntity:taskEntity];
    NSError *error;
    self.tasks = [context executeFetchRequest:taskRequest error:&error];
    
    if (error) {
        NSLog(@"Error loading tasks: %@", error);
    }
    
    return self.tasks;
}

- (NSArray *)sortedTasksByCreatedAtDescending:(NSArray *)paramTasks {
    NSArray *returnArray = [paramTasks sortedArrayUsingComparator:^(id obj1, id obj2) {
        Task *task1 = (Task *)obj1;
        Task *task2 = (Task *)obj2;
        if (task1.createdAt == nil) {
            return NSOrderedDescending;
        }
        if (task2.createdAt == nil) {
            return NSOrderedAscending;
        }
        
        return [task2.createdAt compare:task1.createdAt];
    }];
    return returnArray;
}

- (NSDate *)lastRunDateWithTask:(Task *)task {
    // Sort instances by end date
    NSArray *tempInstances = [task.instances allObjects];
    NSArray *sortedInstances = [tempInstances sortedArrayUsingComparator:^(id obj1, id obj2) {
        Instance *instOne = (Instance *)obj1;
        Instance *instTwo = (Instance *)obj2;
        NSDate *firstEndDate = instOne.end;
        NSDate *secondEndDate = instTwo.end;
        if (firstEndDate == nil) {
            // The second date is later in time than nil
            return NSOrderedDescending;
        }
        if (secondEndDate == nil) {
            // The first date is later in time than nil
            return NSOrderedAscending;
        }
        return [firstEndDate compare:secondEndDate];
    }];
    NSDateFormatter *f = [NSDateFormatter new];
    f.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    Instance *first = (Instance *)[sortedInstances objectAtIndex:0];
    Instance *last = (Instance *)[sortedInstances lastObject];
    NSDate *firstEndDate = first.end;
    NSDate *lastEndDate = last.end;
    
    NSLog(@"First elemnt of sorted instances end date: %@", [f stringFromDate:firstEndDate]);
    NSLog(@"Last elemnt of sorted instances end date: %@", [f stringFromDate:lastEndDate]);
    return ((Instance *)[sortedInstances lastObject]).end;
}

- (NSArray *)loadActiveInstances {
    NSArray *allTasks = [self loadTasks];
    NSMutableArray *activeInstances = [NSMutableArray new];
    for (Task *task in allTasks) {
        if (task.activeInstances.count > 0) {
            NSLog(@"task with %d active: %@", task.activeInstances.count, task.name);
            [self refreshTask:task];
            [activeInstances addObjectsFromArray:task.activeInstances];
        }
    }
    return [activeInstances copy];
}

#pragma mark - Saving methods

- (Task *)saveTaskWithName:(NSString *)paramName taskType:(int)paramTaskType {
    RIAppDelegate *appDelegate = (RIAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];

    Task *newTask = (Task *)[NSEntityDescription insertNewObjectForEntityForName:kTaskName
                                                          inManagedObjectContext:context];
    newTask.name = paramName;
    newTask.createdAt = [NSDate date];
    newTask.lastRun = nil;
    newTask.avgTime = nil;
    newTask.instances = nil;
    
    // Error handle a bad task type
    if (paramTaskType < kStopWatchTask || paramTaskType > kTripTask) {
        paramTaskType = kStopWatchTask;
    }

    newTask.taskType = @(paramTaskType);
    NSError *error;
    [context save:&error];
    NSLog(@"task created is: %@", newTask);
    return newTask;
}

- (Instance *)saveInstanceWithTask:(Task *)paramTask {
    RIAppDelegate *appDelegate = (RIAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    Instance *newInstance = (Instance *)[NSEntityDescription insertNewObjectForEntityForName:kInstanceName
                                                                      inManagedObjectContext:context];
    [self refreshTask:paramTask];
//    paramTask.lastRun = [self lastRunDateWithTask:paramTask];
    NSDate *lastRunDate = (NSDate *)[self lastRunDateWithTask:paramTask];
    NSDateFormatter *f = [NSDateFormatter new];
    f.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSLog(@"Last Run DATE: %@", [f stringFromDate:lastRunDate]);
    paramTask.lastRun = [self lastRunDateWithTask:paramTask];
    newInstance.createdAt = [NSDate date];
    newInstance.type = paramTask.taskType;
    newInstance.task = paramTask;
    
    NSMutableSet *newInstances = [NSMutableSet setWithSet:paramTask.instances];
    [newInstances addObject:newInstance];
    paramTask.instances = [newInstances copy];

    NSError *error;
    [context save:&error];
    NSLog(@"instance created is: %@", newInstance);
    
    return newInstance;
}

- (Instance *)createInstanceWithTask:(Task *)paramTask
                       startLocation:(CLLocation *)startLocation
                         endLocation:(CLLocation *)endLocation {
    RIAppDelegate *appDelegate = (RIAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    Instance *newInstance = (Instance *)[NSEntityDescription insertNewObjectForEntityForName:kInstanceName
                                                                      inManagedObjectContext:context];
    newInstance.createdAt = [NSDate date];
    newInstance.start = [NSDate date];
    newInstance.type = paramTask.taskType;
    newInstance.task = paramTask;
    
    if (startLocation) {
        newInstance.startLatitude = [NSNumber numberWithFloat:startLocation.coordinate.latitude];
        newInstance.startLongitude = [NSNumber numberWithFloat:startLocation.coordinate.longitude];
    }
    if (endLocation) {
        newInstance.endLatitude = [NSNumber numberWithFloat:endLocation.coordinate.latitude];
        newInstance.endLongitude = [NSNumber numberWithFloat:endLocation.coordinate.longitude];
    }
    
    [paramTask addInstancesObject:newInstance];
    [context refreshObject:paramTask mergeChanges:YES];
    
    NSError *error;
    [context save:&error];
    NSLog(@"instance created is: %@", newInstance);
    
    return newInstance;
}

- (void)createInstanceWithTask:(Task *)paramTask
    usingCurrentLocationAsStartLocation:(void(^)(void))completionBlock {
    // After getting new location call callback
    // use notifications
}

- (Instance *)createInstanceWithTask:(Task *)paramTask {
    return [self createInstanceWithTask:paramTask startLocation:nil endLocation:nil];
}

- (NSString *)timeBetweenStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit
                                          fromDate:startDate
                                            toDate:endDate
                                           options:0];
    int hours = [comps hour];
    int minutes = [comps minute];
    int seconds = [comps second];

    return [NSString stringWithFormat:@"%d:%d:%d", hours, minutes, seconds];
}

- (NSString *)timeElapsedSinceDate:(NSDate *)startDate {
    return [self timeBetweenStartDate:startDate endDate:[NSDate date]];
}

@end
