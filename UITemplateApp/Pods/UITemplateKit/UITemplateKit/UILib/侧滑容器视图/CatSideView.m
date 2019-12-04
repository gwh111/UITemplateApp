//
//  CatSideView.m
//  LYCommonUI
//
//  Created by Liuyi on 2019/6/16.
//  Copyright © 2019 Shepherd. All rights reserved.
//

#import "CatSideView.h"
////#import "CC_UIViewExt.h"
#import "ccs.h"

#define CatSideViewMainThreadAssert() NSAssert([NSThread isMainThread], @"CatSideView needs to be accessed on the main thread.");

NSNotificationName const CatSideDisappearNotification = @"CatSideDisappearNotification";
NSNotificationName const CatSideAppearNotification = @"CatSideAppearNotification";

@interface CatSideView ()

@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIView *coverView;

@property (nonatomic,assign,getter=isShowKeyboard) BOOL showKeyboard;
/// 侧滑方向
@property (nonatomic,assign) CatSideViewDirection direction;
    
@end

@implementation CatSideView

// MARK: - LifeCycle -

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
        [self setUpNofication];
    }
    return self;
}

- (void)setUpNofication {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardAction:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardAction:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    /// 屏幕变更通知...
}

- (void)commonInit {
    self.coverView = [[UIView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self.coverView addGestureRecognizer:({
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAction:)];
    })];
    [self.coverView addGestureRecognizer:({
        [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAction:)];
    })];
    
    self.frame = UIScreen.mainScreen.bounds;
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:({
        _contentView = [UIView new];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView;
    })];
    
    self.animated = YES;
    self.direction = CatSideViewDirectionRight;
}

- (CatSideView *(^)(CGFloat offset))nextPercent {
    return ^(CGFloat percent){
        self.percent = percent;
        return self;
    };
}

- (CatSideView *(^)(CGFloat radius))nextRadius {
    return ^(CGFloat raidus) {
        self.radius = raidus;
        return self;
    };
}

- (CatSideView *(^)(CGPoint deltaOffset))nextDeltaOffset {
    return ^(CGPoint deltaOffset) {
        self.deltaOffset = deltaOffset;
        return self;
    };
}

- (CatSideView *(^)(BOOL animated))nextAnimated {
    return ^(BOOL animated) {
        self.animated = animated;
        return self;
    };
}

- (CatSideView *(^)(UIView *parentView))nextParentView {
    return ^(UIView *parentView) {
        self.parentView = parentView;
        return self;
    };
}

- (void)dealloc {
#if DEBUG
    NSLog(@"%s",__func__);
#endif
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// MARK: - Action -

- (void)showWithDirection:(CatSideViewDirection)direction {
    [self showWithDirection:direction
                    percent:self.percent
                   animated:self.animated];
}

- (void)showWithDirection:(CatSideViewDirection)direction
                  percent:(CGFloat)percent
                 animated:(BOOL)animated {
    
    CatSideViewMainThreadAssert();
    NSAssert([self.presentedView isKindOfClass:UIView.class], @"The presentedView property should be a view object");
    
    if (self.isShow) { return; }
    
    self.show = YES;
    
    if (!self.parentView) {
        UIViewController *currentController = [self.class cc_currentViewController];
        if (currentController.navigationController) {
            self.parentView = currentController.navigationController.view;
        }else {
            self.parentView = currentController.view;
        }
    }
    
    if(!(self.option & CatSideViewBehaviorOptionNoneCoverView)) {
        [self.parentView addSubview:self.coverView];
    }
    
    [self.parentView addSubview:self];
    
    self.direction = direction;
    // self.percent = percent;
    
    if (percent != 0) {
        self.percent = percent;
    }else {
        if (self.sideMode == CatSideViewContentModeScaleToFill) {
            if (self.direction == CatSideViewDirectionLeft || self.direction == CatSideViewDirectionRight) {
                percent = self.presentedView.width / WIDTH();
            }else {
                percent = self.presentedView.height / HEIGHT();
            }
            self.percent = percent;
        }
    }
    
    CGFloat targetXY = 0;
    if (self.direction == CatSideViewDirectionLeft) {
        self.left = - (WIDTH() * percent);
        self.left += self.deltaOffset.x;
        targetXY += self.deltaOffset.x;
    }else if(self.direction == CatSideViewDirectionRight){
        self.left = WIDTH();
        self.left -= self.deltaOffset.x;
        targetXY = (int)(WIDTH() * (1 - percent)) - self.deltaOffset.x;
    }else if(self.direction == CatSideViewDirectionTop) {
        self.top = - (int)(HEIGHT() * percent);
        self.top += self.deltaOffset.y;
        targetXY += self.deltaOffset.y;
    }else if(self.direction == CatSideViewDirectionBottom) {
        self.top = HEIGHT();
        self.top -= self.deltaOffset.y;
        targetXY = (int)(HEIGHT() * (1 - percent)) - self.deltaOffset.y;
    }
    
    if (self.direction == CatSideViewDirectionRight || self.direction == CatSideViewDirectionLeft) {
        self.contentView.width = (int)(WIDTH() * percent);
        self.contentView.height = HEIGHT();
        self.width = (int)(WIDTH() * percent);
    }else {
        self.contentView.width = WIDTH();
        self.contentView.height = (int)(HEIGHT() * percent);
        self.height = (int)(HEIGHT() * percent);
        
//        if (CC_iPhoneX) {
//            if (self.direction == CatSideViewDirectionBottom) {
//                self.height += CC_HOME_INDICATOR_HEIGHT;
//                self.contentView.height += CC_HOME_INDICATOR_HEIGHT;
//                targetXY -= CC_HOME_INDICATOR_HEIGHT;
//            }else if (self.direction == CatSideViewDirectionTop) {
//                self.height += 24;
//                self.contentView.height += 24;
//                // targetXY += 24;
//                self.presentedView.top = 24;
//            }
//        }
    }
    
    if (self.radius > 0) {
        if (self.direction == CatSideViewDirectionLeft){
            [self corner:UIRectCornerTopRight | UIRectCornerBottomRight radius:_radius];
        }else if (self.direction == CatSideViewDirectionRight) {
            [self corner:UIRectCornerTopLeft | UIRectCornerBottomLeft radius:_radius];
        }else if (self.direction == CatSideViewDirectionTop) {
            [self corner:UIRectCornerBottomLeft | UIRectCornerBottomRight radius:_radius];
        }else if (self.direction == CatSideViewDirectionBottom) {
            [self corner:UIRectCornerTopLeft | UIRectCornerTopRight radius:_radius];
        }
    }
    
    [self.contentView addSubview:self.presentedView];
    
    if (animated) {
        if (self.animationBlock) {
            self.animationBlock(YES);
        }else {
            [UIView animateWithDuration:self.duration ? : 0.33 animations:^{
                [self targetStatusWithXY:targetXY alpha:1.0];
            } completion:^(BOOL finished) {
                if (self.option & CatSideViewBehaviorOptionAdaptScroll) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:CatSideAppearNotification object:self userInfo:@{
                        CCFrameEndUserInfoKey:@(self.frame),
                        CCAnimationDurationUserInfoKey:@(0)
                    }];
                }else {
                   [[NSNotificationCenter defaultCenter] postNotificationName:CatSideAppearNotification object:self];
                }
            }];
        }
    }else {
        [self targetStatusWithXY:targetXY alpha:1.0];
        if (self.option & CatSideViewBehaviorOptionAdaptScroll) {
            [[NSNotificationCenter defaultCenter] postNotificationName:CatSideAppearNotification object:self userInfo:@{
                CCFrameEndUserInfoKey:@(self.frame),
                CCAnimationDurationUserInfoKey:@(0)
            }];
        }else {
            [[NSNotificationCenter defaultCenter] postNotificationName:CatSideAppearNotification object:self];
        }
    }
}

- (void)dismissViewAnimated:(BOOL)animated {
    [self dismissViewAnimated:animated completion:nil];
}

- (void)dismissViewAnimated:(BOOL)animated
                 completion:(void (^ __nullable)(BOOL finished))completion {
    CatSideViewMainThreadAssert();
    if (!self.isShow) { return; }
    
    self.show = NO;
    
    CGFloat targetXY = 0;
    
    if (self.direction == CatSideViewDirectionLeft) {
        targetXY = - (int)(WIDTH() * self.percent);
    }else if (self.direction == CatSideViewDirectionRight){
        targetXY = WIDTH();
    }else if (self.direction == CatSideViewDirectionTop) {
        targetXY = - (int)(HEIGHT() * self.percent);
    }else {
        targetXY = HEIGHT();
    }
    
    if (animated) {
        if (self.animationBlock) {
            self.animationBlock(NO);
        }else {
            [UIView animateWithDuration:self.duration ? self.duration : 0.33 animations:^{
                [self targetStatusWithXY:targetXY alpha:0];
            } completion:^(BOOL finished) {
                !completion ? : completion(finished);
                if (self.option & CatSideViewBehaviorOptionAdaptScroll) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:CatSideAppearNotification object:self userInfo:@{
                                   CCAnimationDurationUserInfoKey:@(0.33)
                    }];
                }else {
                    [[NSNotificationCenter defaultCenter] postNotificationName:CatSideDisappearNotification object:self];
                }
                [self.coverView removeFromSuperview];
                
                if (self.option & CatSideViewBehaviorOptionForceDismiss) {
                    [self removeFromSuperview];
                }
            }];
        }
    }else {
        [self targetStatusWithXY:targetXY alpha:0];        
        [self.coverView removeFromSuperview];
        !completion ? : completion(YES);
        if (self.option & CatSideViewBehaviorOptionAdaptScroll) {
            [[NSNotificationCenter defaultCenter] postNotificationName:CatSideAppearNotification object:self userInfo:@{
                CCAnimationDurationUserInfoKey:@(0)
            }];
        }else {
            [[NSNotificationCenter defaultCenter] postNotificationName:CatSideDisappearNotification
                                                            object:self];
        }
        
        if (self.option & CatSideViewBehaviorOptionForceDismiss) {
            [self removeFromSuperview];
        }
    }
}

- (void)targetStatusWithXY:(CGFloat)targetXY alpha:(CGFloat)alpha {
    if (self.direction == CatSideViewDirectionRight || self.direction == CatSideViewDirectionLeft) {
        self.left = targetXY;
    }else {
        self.top = targetXY;
    }
    self.coverView.alpha = alpha;
    
}

- (void)dismissAction:(UITapGestureRecognizer *)sender{
    if (self.showKeyboard) {
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
        self.showKeyboard = NO;
    }else {        
        [self dismissViewAnimated:self.animated];
    }
}

- (void)keyboardAction:(NSNotification *)sender {
    if ([sender.name isEqualToString:UIKeyboardDidHideNotification]) {
        self.showKeyboard = NO;
    }else if([sender.name isEqualToString:UIKeyboardDidShowNotification]){
        self.showKeyboard = YES;
    }
}

- (void)corner:(UIRectCorner)corner radius:(CGFloat)radius {    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, WIDTH(), HEIGHT() * self.percent) byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *shapeLayer = [CAShapeLayer new];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = UIColor.whiteColor.CGColor;
    self.layer.mask = shapeLayer;
}

@end

@implementation UIView (CatSideView)

- (CatSideView *)cc_sideView {
    /// 是否已被添加
    if ([[[self superview] superview] isKindOfClass:[CatSideView class]]) {
        return (CatSideView *)[[self superview] superview];
    }else {
        CatSideView *sideView = [CatSideView new];
        sideView.presentedView = self;
        return sideView;
    }
}

+ (UIViewController *)cc_currentViewController {
    UIViewController* currentViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    BOOL runLoopFind = YES;
    while (runLoopFind) {
        if (currentViewController.presentedViewController) {
            
            currentViewController = currentViewController.presentedViewController;
        } else if ([currentViewController isKindOfClass:[UINavigationController class]]) {
            
            UINavigationController* navigationController = (UINavigationController* )currentViewController;
            currentViewController = [navigationController.childViewControllers lastObject];
            
        } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
            
            UITabBarController* tabBarController = (UITabBarController* )currentViewController;
            currentViewController = tabBarController.selectedViewController;
        } else {
            
            NSUInteger childViewControllerCount = currentViewController.childViewControllers.count;
            if (childViewControllerCount > 0) {
                
                currentViewController = currentViewController.childViewControllers.lastObject;
                return currentViewController;
            } else {
                return currentViewController;
            }
        }
        
    }
    return currentViewController;
}


@end
