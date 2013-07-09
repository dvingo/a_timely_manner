//
//  RITaskManager.h
//  timelyManner
//
//  Created by Dan Vingo on 7/8/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@interface RITaskManager : NSObject


+ (RITaskManager *)sharedInstance;
- (NSArray *)loadTasks;
- (Task *)saveTaskWithName:(NSString *)paramName taskType:(int)paramTaskType;

@end
