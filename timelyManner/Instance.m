//
//  Instance.m
//  timelyManner
//
//  Created by Dan Vingo on 6/30/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import "Instance.h"
#import "Task.h"


@implementation Instance

@dynamic createdAt;
@dynamic type;
@dynamic start;
@dynamic end;
@dynamic note;
@dynamic startLatitude;
@dynamic endLatitude;
@dynamic startLongitude;
@dynamic endLongitude;
@dynamic photoPath;
@dynamic task;

- (int32_t)elapsedTimeInSeconds {
    if (self.end) {
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *comps = [gregorian components:NSSecondCalendarUnit
                                               fromDate:self.start
                                                 toDate:self.end
                                                options:0];
        return comps.second;
    }
    return 0.0;
}

@end
