//
//  RITaskManager.h
//  timelyManner
//
//  Created by Dan Vingo on 7/8/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>
#import "Task.h"
#import "Instance.h"

@interface RITaskManager : NSObject 

+ (RITaskManager *)sharedInstance;
- (void)saveContext;
- (void)refreshTask:(Task *)task;
- (NSArray *)loadTasks;
- (NSArray *)loadActiveInstances;
- (NSDate *)lastRunDateWithTask:(Task *)task;
- (Task *)saveTaskWithName:(NSString *)paramName taskType:(int)paramTaskType;
- (Instance *)saveInstanceWithTask:(Task *)paramTask;
- (Instance *)createInstanceWithTask:(Task *)paramTask
                       startLocation:(CLLocation *)startLocation
                         endLocation:(CLLocation *)endLocation;
- (Instance *)createInstanceWithTask:(Task *)paramTask;
- (NSString *)timeBetweenStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;
- (NSString *)timeElapsedSinceDate:(NSDate *)startDate;
//- (void)populateEndLocationWithInstance:(Instance *)instance;

@end
