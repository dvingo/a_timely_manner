//
//  Instance.h
//  timelyManner
//
//  Created by Dan Vingo on 6/30/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Task;

@interface Instance : NSManagedObject

@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSDate * start;
@property (nonatomic, retain) NSDate * end;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSNumber * startLatitude;
@property (nonatomic, retain) NSNumber * endLatitude;
@property (nonatomic, retain) NSNumber * startLongitude;
@property (nonatomic, retain) NSNumber * endLongitude;
@property (nonatomic, retain) NSString * photoPath;
@property (nonatomic, retain) Task *task;

@end
