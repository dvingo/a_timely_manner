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

@end

@implementation RITaskManager
@synthesize tasks, activeTasks;

+ (id)sharedInstance {
    static RITaskManager *__sharedInstance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[RITaskManager alloc] init];
    });

    return __sharedInstance;
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

- (NSArray *)loadActiveTasks {
    RIAppDelegate *appDelegate = (RIAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *taskEntity = [NSEntityDescription entityForName:kTaskName
                                                  inManagedObjectContext:context];
    NSFetchRequest *taskRequest = [[NSFetchRequest alloc] init];
    [taskRequest setEntity:taskEntity];
    NSError *error;
    NSArray *tempTasks = [context executeFetchRequest:taskRequest error:&error];
    
    if (error) {
        NSLog(@"Error loading tasks: %@", error);
    }
    
    NSPredicate *activePredicate = [NSPredicate predicateWithFormat:@"SELF.end == nil"];
    self.activeTasks = [tempTasks filteredArrayUsingPredicate:activePredicate];
    return self.activeTasks;
}

- (Task *)saveTaskWithName:(NSString *)paramName taskType:(int)paramTaskType {
    RIAppDelegate *appDelegate = (RIAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];

    Task *newTask = (Task *)[NSEntityDescription insertNewObjectForEntityForName:kTaskName
                                                          inManagedObjectContext:context];
    newTask.name = paramName;
    newTask.lastRun = nil;
    newTask.avgTime = nil;
    newTask.instances = nil;
    newTask.activeInstances = nil;
    if (paramTaskType < 0 || paramTaskType > 2) {
        paramTaskType = 1;
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
//    Task *parentTask = (Task *)paramData[@"task"];
    
    newInstance.createdAt = [NSDate date];
//    newInstance.type = parentTask.taskType;
    newInstance.type = paramTask.taskType;
//    newInstance.task = parentTask;
    newInstance.task = paramTask;
    
    NSMutableSet *newInstances = [NSMutableSet setWithSet:paramTask.instances];
    [newInstances addObject:newInstance];
    paramTask.instances = [newInstances copy];

    NSError *error;
    [context save:&error];
    NSLog(@"instance created is: %@", newInstance);
    
    return newInstance;
}

- (Instance *)createInstanceWithTask:(Task *)paramTask {
    RIAppDelegate *appDelegate = (RIAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    Instance *newInstance = (Instance *)[NSEntityDescription insertNewObjectForEntityForName:kInstanceName
                                                                      inManagedObjectContext:context];
    //    Task *parentTask = (Task *)paramData[@"task"];
    
    newInstance.createdAt = [NSDate date];
    newInstance.type = paramTask.taskType;
    newInstance.task = paramTask;

    NSLog(@"ABOUT TO SET NEW ACTIVE INSTA");
    NSLog(@"paramTask active instances: %@", paramTask.activeInstances);
    [paramTask addActiveInstancesObject:newInstance];
    NSLog(@"AFTER THAT");

    
    NSError *error;
    [context save:&error];
    NSLog(@"instance created is: %@", newInstance);
    
    return newInstance;
}

@end
