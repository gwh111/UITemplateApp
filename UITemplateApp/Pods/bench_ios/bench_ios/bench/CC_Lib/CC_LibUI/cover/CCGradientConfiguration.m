//
//  CCGradientConfiguration.m
//  CoverDemo
//
//  Created by ml on 2019/10/28.
//  Copyright © 2019 Shepherd. All rights reserved.
//

#import "CCGradientConfiguration.h"

@interface UIColor (Loading)

- (UIColor *)withBrightness:(CGFloat)brightness;

@end

@implementation UIColor (Loading)

- (UIColor *)withBrightness:(CGFloat)brightness {
    CGFloat H = 0,S = 0,B = 0,A = 0;
    if([self getHue:&H saturation:&S brightness:&B alpha:&A]) {
        B += (brightness - 1.0);
        B = MAX(MIN(B, 1.0), 0.0);
        return [UIColor colorWithHue:H saturation:S brightness:B alpha:A];
    }
    
    return self;
}

@end

@implementation CCGradientConfiguration

- (void)setMainColor:(UIColor *)color {
    self.backgroundColor = [color withBrightness:0.98];
    self.primaryColor = [color withBrightness:0.95];
    self.secondaryColor = [color withBrightness:0.88];
}

- (instancetype)initWithColor:(UIColor *)mainColor {
    if (self = [super init]) {
        self.fadeAnimationDuration = 0.15;
        self.secondaryColor = UIColor.clearColor;
        self.backgroundColor = UIColor.clearColor;
        self.primaryColor = UIColor.clearColor;
        self.animationDuration = 1;
        self.width = 0.2;
        
        [self setMainColor:mainColor];
    }
    return self;
}

@end
