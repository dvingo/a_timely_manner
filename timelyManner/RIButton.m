//
//  RIButton.m
//  timelyManner
//
//  Created by Dan Vingo on 8/19/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import "RIButton.h"
#import "RIConstants.h"

@implementation RIButton

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupSelf];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSelf];
    }
    return self;
}

- (void)setupSelf {
    UIImage *buttonImage = [[UIImage imageNamed:kOrangeButtonImage]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(3.0, 3.0, 3.0, 3.0)];
    UIImage *selectedImage = [[UIImage imageNamed:kOrangeButtonHighlightedImage]
                              resizableImageWithCapInsets:UIEdgeInsetsMake(3.0, 3.0, 3.0, 3.0)];
    self.backgroundColor = [UIColor clearColor];
    [self setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [self setBackgroundImage:selectedImage forState:UIControlStateSelected];
    [self setBackgroundImage:selectedImage forState:UIControlStateHighlighted];
    [self setTitleColor:kDarkBlueColor forState:UIControlStateNormal];
    [self setTitleColor:kDarkBlueColor forState:UIControlStateSelected];
}

@end
