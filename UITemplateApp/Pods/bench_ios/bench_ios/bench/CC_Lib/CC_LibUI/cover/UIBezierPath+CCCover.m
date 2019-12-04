//
//  UIBezierPath+CCCover.m
//  CoverDemo
//
//  Created by Shepherd on 2019/10/27.
//  Copyright © 2019 Shepherd. All rights reserved.
//

#import "UIBezierPath+CCCover.h"

@implementation UIBezierPath (CCCover)

+ (UIBezierPath *)multiLinePath:(CGFloat)numberOfLines spacing:(CGFloat)spacing bounds:(CGRect)bounds {
    CGFloat height = bounds.size.height;
    CGFloat lineHeight = (height - ((numberOfLines - 1) * spacing) / numberOfLines);
    UIBezierPath *totalPath = UIBezierPath.new;
    for (int i = 0; i < numberOfLines; ++i) {
        CGRect lineFrame = CGRectMake(0,(lineHeight + spacing) * i, bounds.size.width, lineHeight);
        UIBezierPath *linePath = [UIBezierPath bezierPathWithRoundedRect:lineFrame cornerRadius:0];
        [totalPath appendPath:linePath];
    }
    return totalPath;
}

- (void)translateToPoint:(CGPoint)point {
    [self applyTransform:CGAffineTransformMakeTranslation(point.x, point.y)];
}

@end
