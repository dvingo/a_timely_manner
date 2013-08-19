//
//  RIViewsHelper.m
//  timelyManner
//
//  Created by Dan Vingo on 8/18/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import "RIViewsHelper.h"
#import "RIConstants.h"

@implementation RIViewsHelper

+ (id)sharedInstance {
    static RIViewsHelper *__sharedInstance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[RIViewsHelper alloc] init];
    });
    
    return __sharedInstance;
}

- (UILabel *)titleLabelWithText:(NSString *)text {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120.0, 44.0)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = text;
    titleLabel.textColor = kDarkBlueColor;
    titleLabel.font = [UIFont fontWithName:kRIFontRegular size:24.0];
    return titleLabel;
}

- (UIBarButtonItem *)makeAddButtonWithTarget:(id)obj action:(SEL)action {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40.0, 30.0)];
    [button setBackgroundImage:[UIImage imageNamed:@"plus-sign-light"] forState:UIControlStateNormal];
    [button addTarget:obj action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *plusButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    return plusButton;
}

- (UIBarButtonItem *)createBackButtonWithTarget:(id)obj action:(SEL)action {
    UIImage *backArrowImage = [UIImage imageNamed:kBackArrow];
    UIView *backButtonContainer = [[UIView alloc] initWithFrame:CGRectMake(20, 0, backArrowImage.size.width * 4, backArrowImage.size.height * 2)];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:backArrowImage forState:UIControlStateNormal];
    backButton.frame = CGRectMake(0, 2, backArrowImage.size.width * 4, backArrowImage.size.height * 2);
    [backButton addTarget:obj action:action forControlEvents:UIControlEventTouchUpInside];
    [backButtonContainer addSubview:backButton];
    return [[UIBarButtonItem alloc] initWithCustomView:backButtonContainer];
}

- (UIImage *)imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


@end
