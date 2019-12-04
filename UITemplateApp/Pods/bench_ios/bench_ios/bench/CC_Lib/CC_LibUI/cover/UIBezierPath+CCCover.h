//
//  UIBezierPath+CCCover.h
//  CoverDemo
//
//  Created by Shepherd on 2019/10/27.
//  Copyright © 2019 Shepherd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBezierPath (CCCover)

+ (UIBezierPath *)multiLinePath:(CGFloat)numberOfLines spacing:(CGFloat)spacing bounds:(CGRect)bounds;

- (void)translateToPoint:(CGPoint)point;

@end

NS_ASSUME_NONNULL_END
