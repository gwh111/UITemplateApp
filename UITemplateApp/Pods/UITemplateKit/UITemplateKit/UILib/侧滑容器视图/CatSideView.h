//
//  CatSideView.h
//  LYCommonUI
//
//  Created by Shepherd on 2019/6/16.
//  Copyright © 2019 Shepherd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ccs.h"

NS_ASSUME_NONNULL_BEGIN
@class CatSideView;

typedef NS_ENUM(NSInteger,CatSideViewDirection) {
    CatSideViewDirectionRight,
    CatSideViewDirectionLeft,
    CatSideViewDirectionTop,
    CatSideViewDirectionBottom,
};

typedef NS_ENUM(NSInteger,CatSideViewContentMode) {
    CatSideViewContentModeScaleToFill, /// 容器视图与presented视图大小相等
};

typedef NS_OPTIONS(NSInteger,CatSideViewBehaviorOption) {
    CatSideViewBehaviorOptionNormal        = 1 << 0,
    CatSideViewBehaviorOptionForceDismiss  = 1 << 1, /// 消失时从父视图中移除
    CatSideViewBehaviorOptionNoneCoverView = 1 << 2, /// 不添加遮罩视图
    CatSideViewBehaviorOptionAdaptScroll   = 1 << 3, /// UIScrollView自定义视图要求不遮挡的情况下
};

@interface CatSideView : UIView

/**
 视图默认添加到当前viewcontroller.view中,若存在导航控制器,则添加到导航控制器的view中
 */
@property (nonatomic,weak) UIView *parentView;
@property (nonatomic,strong,readonly) UIView *coverView;
@property (nonatomic,assign,readonly) CatSideViewDirection direction;
@property (nonatomic,assign) CatSideViewBehaviorOption option;
@property (nonatomic,strong) UIView *presentedView;

/// 内容视图,包含待展示视图
@property (nonatomic,strong,readonly) UIView *contentView;
@property (nonatomic,assign) CatSideViewContentMode sideMode;
/// 动画时间
@property (nonatomic,assign) CGFloat duration;
@property (nonatomic,assign) CGFloat radius;
/// 自定义动画
@property (nonatomic,copy) void (^animationBlock)(BOOL isShow);
/// 视图状态
@property (nonatomic,assign,getter=isShow) BOOL show;
@property (nonatomic,assign) CGFloat percent;
/// 滑动位置增量
@property (nonatomic,assign) CGPoint deltaOffset;
@property (nonatomic,assign) BOOL animated;

/**
 展示侧滑视图
    设置 presentedView / 配合分类使用

 @param direction 方向
 */
- (void)showWithDirection:(CatSideViewDirection)direction;

- (void)showWithDirection:(CatSideViewDirection)direction
                  percent:(CGFloat)percent
                 animated:(BOOL)animated;

- (void)dismissViewAnimated:(BOOL)animated;
- (void)dismissViewAnimated:(BOOL)animated
                 completion:(void (^ __nullable)(BOOL finished))completion;


- (CatSideView *(^)(CGFloat percent))nextPercent;
- (CatSideView *(^)(CGFloat radius))nextRadius;
- (CatSideView *(^)(CGPoint deltaOffset))nextDeltaOffset;
- (CatSideView *(^)(BOOL animated))nextAnimated;
- (CatSideView *(^)(UIView *parentView))nextParentView;

@end

@interface UIView (CatSideView)

- (CatSideView *)cc_sideView;
+ (UIViewController *)cc_currentViewController;

@end

UIKIT_EXTERN NSNotificationName const CatSideAppearNotification;
UIKIT_EXTERN NSNotificationName const CatSideDisappearNotification;

NS_ASSUME_NONNULL_END
