//
//  Task.h
//  timelyManner
//
//  Created by Dan Vingo on 7/15/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

enum {
    kStopWatchTask,
    kTimerTask,
    kTripTask
};

@class Instance;

@interface Task : NSManagedObject

@property (nonatomic, retain) NSNumber * avgTime;
@property (nonatomic, retain) NSDate * lastRun;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * taskType;
@property (nonatomic, retain) NSSet *instances;
@property (nonatomic, retain) NSArray *activeInstances;
@end

@interface Task (CoreDataGeneratedAccessors)

- (void)addInstancesObject:(Instance *)value;
- (void)removeInstancesObject:(Instance *)value;
- (void)addInstances:(NSSet *)values;
- (void)removeInstances:(NSSet *)values;

- (void)updateLastRun;
- (NSInteger)averageInstanceTime;

@end
