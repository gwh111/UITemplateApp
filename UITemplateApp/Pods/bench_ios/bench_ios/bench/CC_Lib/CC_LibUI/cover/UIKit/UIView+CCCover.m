//
//  UIView+CCCover.m
//  CoverDemo
//
//  Created by Shepherd on 2019/10/27.
//  Copyright © 2019 Shepherd. All rights reserved.
//

#import "UIView+CCCover.h"
#import <objc/message.h>
#import "UIBezierPath+CCCover.h"

@implementation UIView (CCCover)

- (UIBezierPath *)cc_makeCoverablePath:(UIView *)superview {
    if (!(superview = self.superview)) {
        return nil;
    }
    
    [self setNeedsLayout];
    
    /// 坐标转换:计算出hostView在父视图中的origin
    CGPoint point = [self convertRect:self.bounds
                               toView:self.superview].origin;
    
    /// 获取绘制路径(bounds)
    UIBezierPath *path = [self cc_coverablePath] ? : UIBezierPath.new;
    
    /// 根据point平移调整绘制路径
    [path translateToPoint:point];
    
    return path;
}

- (void)cc_addCoverablePath:(UIBezierPath *)totalCoverablePath superview:(nullable UIView *)superview {
    UIBezierPath *coverablePath = [self cc_makeCoverablePath:superview];
    [totalCoverablePath appendPath:coverablePath];
}

- (UIBezierPath *)cc_subviewsCoverablePath {
    NSArray<UIView *> *subviews = [self cc_coverableSubviews];
    UIBezierPath *totalPath = [UIBezierPath new];
    for (int i = 0; i < subviews.count; ++i) {
        UIView *coverableView = subviews[i];
        [coverableView cc_addCoverablePath:totalPath superview:self];
    }
    return totalPath;
}

- (UIBezierPath *)cc_coverablePath {
    if (objc_getAssociatedObject(self, @selector(cc_coverablePath))) {
        return objc_getAssociatedObject(self, @selector(cc_coverablePath));
    }
    
    UIBezierPath *path = [self cc_defaultCoverablePath];
    objc_setAssociatedObject(self, @selector(cc_coverablePath), path, OBJC_ASSOCIATION_RETAIN);
    return path;
}

- (UIBezierPath *)cc_defaultCoverablePath {
    return [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                      cornerRadius:self.layer.cornerRadius];
}

- (NSArray<UIView *> *)cc_coverableSubviews {
    NSMutableArray <UIView *> *foundedViews = [NSMutableArray array];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"CCPlaceholderView")]) {
            continue;
        }else {
            if ([view isCoverable]) {
                [foundedViews addObject:view];
            }else {
                [foundedViews addObjectsFromArray:[view cc_coverableSubviews]];
            }
        }
    }
    
    return foundedViews.copy;
}

- (BOOL)isCoverable {
    if (objc_getAssociatedObject(self, @selector(isCoverable))) {
        return (BOOL)(objc_getAssociatedObject(self, @selector(isCoverable)));
    }
    return [self isBigEnough];
}

- (BOOL)isBigEnough {
    return self.bounds.size.width > 5 && self.bounds.size.height > 5;
}

@end
