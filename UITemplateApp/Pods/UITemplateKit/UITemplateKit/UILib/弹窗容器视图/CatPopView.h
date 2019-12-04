//
//  CatPopView.h
//  UITemplateKit
//
//  Created by Shepherd on 2019/8/7.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,CatPopViewContentMode) {
    CatPopViewContentModeScaleToFill, /// 容器视图与presented视图大小相等
};

typedef NS_OPTIONS(NSInteger, CatPopViewBehaviorOption) {
    CatPopViewBehaviorOptionNormal          = 1 << 0,
    CatPopViewBehaviorOptionShallowDismiss  = 1 << 1, /// Dismiss 时不移除 只是隐藏
};

/**
 弹出，消失动画类型
 */
typedef NS_ENUM(NSInteger, CatPopAnimationStyle) {
    CatPopAnimationStyleNone,
    
    CatPopAnimationStyleFadeInOut,
    
    CatPopAnimationStyleSlideVerTop,
    CatPopAnimationStyleSlideVerBottom,
    CatPopAnimationStyleSlideHorLeft,
    CatPopAnimationStyleSlideHorRight,
    
    CatPopAnimationStyleScale,  /// 放大缩小类似CatStrongAlert
    
    CatPopAnimationStyleSlideAngleBounce,
    CatPopAnimationStyleDismissSlideInToPointAndScale,
};

/// 开发中
@interface CatPopView : UIView

@property (nonatomic,strong) UIView *presentedView;
/// 内容视图,包含待展示视图
@property (nonatomic,strong,readonly) UIView *contentView;
/** 默认为当前viewcontroller.vie,若存在导航控制器,则为导航控制器的view */
@property (nonatomic,weak) UIView *parentView;
@property (nonatomic,strong,readonly) UIView *coverView;

@property (nonatomic,assign) BOOL animated;
/// 视图状态
@property (nonatomic,assign,getter=isShow) BOOL show;
@property (nonatomic,assign) CGFloat percent;

@property (nonatomic,assign) CGPoint dismissPoint;

@property (nonatomic,assign) CatPopViewContentMode popMode;

@property (nonatomic,assign) CatPopViewBehaviorOption option;

@property (nonatomic,assign) CatPopAnimationStyle inStyle;

@property (nonatomic,assign) CatPopAnimationStyle outStyle;
/** 点击遮罩层否隐藏 默认YES */
@property (nonatomic,assign) BOOL shouldDismissOnBackgroundTouch;

/// 动画时间
@property (nonatomic,assign) CGFloat duration;

- (void)showWithAnimation:(CatPopAnimationStyle)animationStyle;

- (void)showWithAnimation:(CatPopAnimationStyle)animationStyle
               completion:(void (^ __nullable)(BOOL finished))completion;

- (void)dismissWithCompletion:(void (^ __nullable)(BOOL finished))completion;

- (void)dismissWithCompletion:(void (^ __nullable)(BOOL finished))completion
                    animation:(CatPopAnimationStyle)animationStyle;

- (CatPopView *(^)(CGFloat percent))nextPercent;
- (CatPopView *(^)(BOOL animated))nextAnimated;
- (CatPopView *(^)(UIView *parentView))nextParentView;

@end

@interface UIView (CatPopView)

- (CatPopView *)cc_popView;

@end

UIKIT_EXTERN NSNotificationName const CatPopAppearNotification;
UIKIT_EXTERN NSNotificationName const CatPopDisappearNotification;

NS_ASSUME_NONNULL_END
