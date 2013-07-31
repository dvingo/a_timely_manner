//
//  RILocationManager.h
//  timelyManner
//
//  Created by Dan Vingo on 7/31/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>

@interface RILocationManager : NSObject <CLLocationManagerDelegate>

+ (id)sharedInstance;
- (void)populateEndLocationWithInstance:(Instance *)instance;

@end
