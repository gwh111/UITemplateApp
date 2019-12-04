//
//  UIView+CCCover.h
//  CoverDemo
//
//  Created by Shepherd on 2019/10/27.
//  Copyright © 2019 Shepherd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CCCoverable <NSObject>

@optional

/**
The path that will be used to mask the content and add the gradient.
The default value for all the `UIViews` is a rounded rect of the size of the view's bounds.

It's possible to customize the default path by explicitly set `UIView.coverablePath`
*/
- (UIBezierPath *)cc_defaultCoverablePath;

@end

@interface UIView (CCCover) <CCCoverable>

/// 创建绘制路径
/// @param superview super view
- (UIBezierPath *)cc_makeCoverablePath:(nullable UIView *)superview;


/// 添加绘制路径到totalCoverablePath
/// @param totalCoverablePath 最终的绘制路径
/// @param superview suepr view
- (void)cc_addCoverablePath:(UIBezierPath *)totalCoverablePath
                  superview:(nullable UIView *)superview;

/// 获取子视图的绘制路径
- (UIBezierPath *)cc_subviewsCoverablePath;

@end

NS_ASSUME_NONNULL_END
