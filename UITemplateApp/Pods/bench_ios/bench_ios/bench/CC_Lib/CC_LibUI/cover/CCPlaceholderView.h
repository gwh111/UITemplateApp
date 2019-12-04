//
//  CCPlaceholderView.h
//  CoverDemo
//
//  Created by Shepherd on 2019/10/27.
//  Copyright © 2019 Shepherd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CCGradientConfiguration;

@interface CCPlaceholderView : UIView

@property (nonatomic,strong) CCGradientConfiguration *gradientConfiguration;

@property (nonatomic,assign) CGFloat fadeAnimationDuration;

@property (nonatomic,strong) UIColor *gradientColor;

@property (nonatomic,strong,readonly) UIView *viewToCover;

@property (nonatomic,strong,readonly) CAShapeLayer *maskLayer;

@property (nonatomic,strong,readonly) CAGradientLayer *gradientLayer;

@property (nonatomic,assign) BOOL isCovering;

/// 创建遮罩视图
/// @param viewToCover 待遮罩的视图
/// @param animated 是否有动画
- (void)cover:(UIView *)viewToCover animated:(BOOL)animated;

/// 移除遮罩视图
/// @param animated 是否有动画
- (void)uncover:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
