//
//  RITimeHelper.h
//  timelyManner
//
//  Created by Dan Vingo on 7/16/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kHoursMinutes,
    kstartEndHours,
    kstopWatch
} TimeFormatEnum;

@interface RITimeHelper : NSObject

+ (RITimeHelper *)sharedInstance;
- (NSString *)timeBetweenStartDate:(NSDate *)startDate endDate:(NSDate *)endDate withFormat:(TimeFormatEnum)timeFormat;
- (NSString *)dateStringFromDate:(NSDate *)date;

@end
