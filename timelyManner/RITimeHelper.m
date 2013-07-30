//
//  RITimeHelper.m
//  timelyManner
//
//  Created by Dan Vingo on 7/16/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import "RITimeHelper.h"

@implementation RITimeHelper

+ (id)sharedInstance {
    static RITimeHelper *__sharedInstance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[RITimeHelper alloc] init];
    });
    return __sharedInstance;
}

- (NSString *)timeBetweenStartDate:(NSDate *)startDate
                           endDate:(NSDate *)endDate
                        withFormat:(TimeFormatEnum)timeFormat {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit
                                           fromDate:startDate
                                             toDate:endDate
                                            options:0];
    int hours = [comps hour];
    int minutes = [comps minute];
    int seconds = [comps second];
    
    switch (timeFormat) {
            
        case kHoursMinutesSeconds: {
            NSLog(@"hours minutes format");
            if (hours > 0) {
                NSLog(@"returning: %@",[NSString stringWithFormat:@"%dh %dm", hours, minutes]);
                return [NSString stringWithFormat:@"%dh %dm", hours, minutes];
            } else if (minutes > 0) {
                NSLog(@"returning: %@", [NSString stringWithFormat:@"%dm", minutes]);
                return [NSString stringWithFormat:@"%dm", minutes];
            } else {
                NSLog(@"returning: %@", [NSString stringWithFormat:@"%ds", seconds]);
                return [NSString stringWithFormat:@"%ds", seconds];
            }
        }
        
        case kstartEndHours: {
            NSLog(@"start end format");
            NSDateFormatter *formatter = [NSDateFormatter new];
            formatter.dateFormat = @"hh:mm";
            NSString *startTime = [formatter stringFromDate:startDate];
            NSString *endTime = [formatter stringFromDate:endDate];
            
            return [NSString stringWithFormat:@"%@-%@", startTime, endTime];
        }
            
        case kstopWatch: {
            NSLog(@"stopwatch format");
            return [NSString stringWithFormat:@"%d:%d:%d", hours, minutes, seconds];
        }
            
        default:
            break;
    }
    NSLog(@"returning nil");
    return nil;
}

- (NSString *)dateStringFromDate:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    int year = [comps year];
    int month = [comps month];
    int day = [comps day];
    
    NSDate *today = [NSDate date];
    NSDateComponents *todayComps = [gregorian components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:today];
    int todayYear = [todayComps year];
    int todayMonth = [todayComps month];
    int todayDay = [todayComps day];
    
    if (todayYear == year && todayMonth == month && todayDay == day) {
        return @"Today";
    }
    if (todayYear == year && todayMonth == month && todayDay == (day + 1)) {
        return @"Yesterday";
    }
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"MMMM dd";
    
    return [formatter stringFromDate:date];
}

- (NSString *)timeFormatFromSeconds:(NSInteger)seconds {
    NSInteger hours = seconds / 3600;
    NSInteger remaining = seconds - (hours * 3600);
    
    NSInteger minutes = remaining / 60;
    remaining = remaining - minutes * 60;
    
    if (hours != 0) {
        return [NSString stringWithFormat:@"%dh %dm %ds", hours, minutes, remaining];
    } else if (minutes != 0) {
        return [NSString stringWithFormat:@"%dm %ds", minutes, remaining];
    }
    return [NSString stringWithFormat:@"%ds", seconds];
}

@end
