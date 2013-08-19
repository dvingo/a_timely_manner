//
//  RIViewsHelper.h
//  timelyManner
//
//  Created by Dan Vingo on 8/18/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RIViewsHelper : NSObject

+ (id)sharedInstance;
- (UILabel *)titleLabelWithText:(NSString *)text;
- (UIBarButtonItem *)makeAddButtonWithTarget:(id)obj action:(SEL)selector;
- (UIBarButtonItem *)createBackButtonWithTarget:(id)obj action:(SEL)action;
- (UIImage *)imageFromColor:(UIColor *)color;

@end
