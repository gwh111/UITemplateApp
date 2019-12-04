//
//  UIImage+GradientLayer.m
//  Patient
//
//  Created by ml on 2019/7/31.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "UIImage+GradientLayer.h"

@implementation UIImage (GradientLayer)

+ (UIImage *)gradientImageWithColors:(NSArray <UIColor *>*)colors
                                rect:(CGRect)rect {
    
    return [self gradientImageWithColors:colors
                                    rect:rect
                              startPoint:CGPointMake(0, 0.5)
                                endPoint:CGPointMake(1.0, 0.5)];
}

+ (UIImage *)gradientImageWithColors:(NSArray <UIColor *>*)colors
                                rect:(CGRect)rect
                          startPoint:(CGPoint)sp
                            endPoint:(CGPoint)ep {
    
    NSMutableArray *locs = [NSMutableArray arrayWithCapacity:colors.count];
    if (colors.count == 1) {
        [locs addObject:@(0.0)];
        [locs addObject:@(1.0)];
    }else {
        CGFloat stepVal = 1.0 / (colors.count - 1);
        for (int i = 0; i < colors.count; ++i) {
            NSNumber *loc = @(stepVal * i);
            [locs addObject:loc];
        }
    }
    return [self gradientImageWithColors:colors
                                    rect:rect
                              startPoint:sp
                                endPoint:ep
                               locations:locs];
}

+ (UIImage *)gradientImageWithColors:(NSArray <UIColor *>*)colors
                                rect:(CGRect)rect
                          startPoint:(CGPoint)sp
                            endPoint:(CGPoint)ep
                           locations:(NSArray *)locations {
    
    CAGradientLayer *gl = [CAGradientLayer new];
    gl.frame = rect;
    NSMutableArray *colorsM = [NSMutableArray arrayWithCapacity:colors.count];
    for (int i = 0; i < colors.count; ++i) {
        [colorsM addObject:(__bridge id)(colors[i].CGColor)];
    }
    gl.colors = colorsM.copy;
    gl.startPoint = sp;
    gl.endPoint = ep;
    gl.locations = locations;
    
    UIGraphicsBeginImageContextWithOptions(gl.frame.size, gl.opaque, 0);
    [gl renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outputImage;
}

@end
