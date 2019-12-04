//
//  CatPopView.m
//  UITemplateKit
//
//  Created by Shepherd on 2019/8/7.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatPopView.h"
#import "ccs.h"
#import "CatSideView.h"

#define CatPopViewMainThreadAssert() NSAssert([NSThread isMainThread], @"CatPopView needs to be accessed on the main thread.");

NSNotificationName const CatPopDisappearNotification = @"CatPopDisappearNotification";
NSNotificationName const CatPopAppearNotification = @"CatPopAppearNotification";

@interface CatPopView ()

@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIView *coverView;

@property (nonatomic,assign,getter=isShowKeyboard) BOOL showKeyboard;

@end

@implementation CatPopView

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
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissFromCoverAction:)];
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
    self.shouldDismissOnBackgroundTouch = YES;
}

- (CatPopView *(^)(CGFloat offset))nextPercent {
    return ^(CGFloat percent){
        self.percent = percent;
        return self;
    };
}

- (CatPopView *(^)(BOOL animated))nextAnimated {
    return ^(BOOL animated) {
        self.animated = animated;
        return self;
    };
}

- (CatPopView *(^)(UIView *parentView))nextParentView {
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

// MARK: - Public -
- (void)showWithAnimation:(CatPopAnimationStyle)animationStyle {
    [self showWithAnimation:animationStyle completion:nil];
}

- (void)showWithAnimation:(CatPopAnimationStyle)animationStyle
               completion:(void (^ __nullable)(BOOL finished))completion {
    
    CatPopViewMainThreadAssert();
    NSAssert([self.presentedView isKindOfClass:UIView.class], @"The presentedView property should be a view object");
    
    if (self.isShow) { return; }
    
    self.show = YES;
    
    if (self.option & CatPopViewBehaviorOptionShallowDismiss) {
        self.hidden = NO;
        self.coverView.hidden = NO;
        return;
    }
    
    if (self.parentView) {
        [self.parentView addSubview:self.coverView];
        [self.parentView addSubview:self];
    }else {
        UIViewController *currentController = [self.class cc_currentViewController];
        if (currentController.navigationController) {
            [currentController.navigationController.view addSubview:self.coverView];
            [currentController.navigationController.view addSubview:self];
        }else {
            [currentController.view addSubview:self.coverView];
            [currentController.view addSubview:self];
        }
    }
    
    if (self.percent == 0) {
        if (self.popMode == CatPopViewContentModeScaleToFill) {
            self.percent = self.presentedView.height / HEIGHT();
        }
    }
    
    self.contentView.width = self.presentedView.width;
    self.contentView.height = (int)(HEIGHT() * self.percent);
    self.height = (int)(HEIGHT() * self.percent);
    
    self.top = self.presentedView.top;
    self.contentView.left = self.presentedView.left;
    self.presentedView.top = 0;
    self.presentedView.left = 0;
    
    [self.contentView addSubview:self.presentedView];
    
    self.inStyle = animationStyle;
    CGPoint translatePoint = CGPointZero;
    switch (animationStyle) {
        case CatPopAnimationStyleNone: {
            self.coverView.alpha = 1.0;
            self.presentedView.alpha = 1.0;
            !completion ? : completion(YES);
        }
            break;
        case CatPopAnimationStyleFadeInOut: {
            self.coverView.alpha = 1.0;
            self.presentedView.alpha = 0.0;
            [UIView animateWithDuration:self.duration ? : 0.33 animations:^{
                self.presentedView.alpha = 1.0;
            } completion:completion];
        }
            break;
        case CatPopAnimationStyleSlideVerTop:
        case CatPopAnimationStyleSlideAngleBounce: {
            translatePoint = CGPointMake(0,-HEIGHT()/2);
        }
            break;
        case CatPopAnimationStyleSlideVerBottom: {
            translatePoint = CGPointMake(0,HEIGHT()/2);
        }
            break;
        case CatPopAnimationStyleSlideHorLeft: {
            translatePoint = CGPointMake(-WIDTH()/2,0);
        }
            break;
        case CatPopAnimationStyleSlideHorRight: {
            translatePoint = CGPointMake(WIDTH()/2,0);
        }
            break;
        case CatPopAnimationStyleScale: {
            [UIView animateWithDuration:0.3 animations:^{
                self.coverView.alpha = 1.0f;
                self.transform = CGAffineTransformScale(self.transform, 1.2f, 1.2f);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.2 animations:^{
                    self.transform = CGAffineTransformIdentity;
                }];
            }];
        }
            break;
        default:
            break;
    }
    
    if(animationStyle == CatPopAnimationStyleNone ||
       animationStyle == CatPopAnimationStyleFadeInOut ||
       animationStyle == CatPopAnimationStyleScale) {
       return;
    }
    
    self.coverView.alpha = 0.0;
    self.presentedView.alpha = 0.0;
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_4/5.0);
    if (animationStyle == CatPopAnimationStyleSlideAngleBounce) {
        transform = CGAffineTransformTranslate(transform, translatePoint.x, translatePoint.y);
    }else {
        transform =  CGAffineTransformMakeTranslation(translatePoint.x,translatePoint.y);
    }
    
    self.transform = transform;
    
    [UIView animateWithDuration:self.duration ? : 0.66 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.transform = CGAffineTransformIdentity;
        self.coverView.alpha = 1.0;
        self.presentedView.alpha = 1.0;
    } completion:completion];
}

- (void)dismissWithCompletion:(void (^)(BOOL))completion {
    if (self.outStyle != CatPopAnimationStyleNone) {
        [self dismissWithCompletion:completion animation:self.outStyle];
    }else {
        [self dismissWithCompletion:completion animation:self.inStyle];
    }
}

- (void)dismissWithCompletion:(void (^)(BOOL))completion
                    animation:(CatPopAnimationStyle)animationStyle {
    
    self.show = NO;
    
    if (self.option & CatPopViewBehaviorOptionShallowDismiss) {
        self.hidden = YES;
        self.coverView.hidden = YES;
        return;
    }
    
    CGPoint translatePoint = CGPointZero;
    switch (animationStyle) {
        case CatPopAnimationStyleNone: {
            self.coverView.alpha = 0.0;
            self.alpha = 0.0;
            [self.coverView removeFromSuperview];
            [self removeFromSuperview];
            !completion ? : completion(YES);
        }
            break;
        case CatPopAnimationStyleFadeInOut: {
            [UIView animateWithDuration:self.duration ? : 0.33 animations:^{
                self.coverView.alpha = 0.0;
                self.alpha = 0.0;
            } completion:^(BOOL finished) {
                [self.coverView removeFromSuperview];
                [self removeFromSuperview];
                !completion ? : completion(finished);
            }];
        }
            break;
        case CatPopAnimationStyleSlideVerTop: {
            translatePoint = CGPointMake(0,-HEIGHT() / 2);
        }
            break;
        case CatPopAnimationStyleSlideVerBottom:
        case CatPopAnimationStyleSlideAngleBounce: {
            translatePoint = CGPointMake(0,HEIGHT() / 2);
        }
            break;
        case CatPopAnimationStyleDismissSlideInToPointAndScale: {
            translatePoint = CGPointMake(self.dismissPoint.x-self.presentedView.centerX, self.dismissPoint.y-self.presentedView.centerY);
        }
            break;
        case CatPopAnimationStyleSlideHorLeft: {
            translatePoint = CGPointMake(-WIDTH() / 2,0);
        }
            break;
        case CatPopAnimationStyleSlideHorRight: {
            translatePoint = CGPointMake(WIDTH() / 2,0);
        }
            break;
        case CatPopAnimationStyleScale: {
            [UIView animateWithDuration:0.3 animations:^{
                self.coverView.alpha = 0.0f;
                self.transform = CGAffineTransformScale(self.transform, 0.1, 0.1);
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
                [self.coverView removeFromSuperview];
            }];
        }
        default:
            break;
    }
    
    if (animationStyle == CatPopAnimationStyleNone ||
        animationStyle == CatPopAnimationStyleFadeInOut ||
        animationStyle == CatPopAnimationStyleScale) {
        return ;
    }
    
    [UIView animateWithDuration:0.66 animations:^{
        
        CGAffineTransform transform = CGAffineTransformIdentity;
        if (animationStyle == CatPopAnimationStyleDismissSlideInToPointAndScale){
            transform =  CGAffineTransformMakeTranslation(translatePoint.x, translatePoint.y);
            transform = CGAffineTransformScale(transform, 0.01, 0.01);
        }else if (animationStyle == CatPopAnimationStyleSlideAngleBounce){
            transform = CGAffineTransformMakeRotation(-M_PI_4/5.0);
            transform = CGAffineTransformTranslate(transform, translatePoint.x, translatePoint.y);
        }else{
            transform = CGAffineTransformMakeTranslation(translatePoint.x,translatePoint.y);
        }
        
        self.transform = transform;
        
        self.coverView.alpha = 0.0;
        self.alpha = 0.0;
                
    } completion:^(BOOL finished) {
        [self.coverView removeFromSuperview];
        [self removeFromSuperview];
        !completion ? : completion(finished);
    }];
}

// MARK: - Actions -
- (void)dismissAction:(UITapGestureRecognizer *)sender{
    if (self.showKeyboard) {
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
        self.showKeyboard = NO;
    }else {
        [self dismissWithCompletion:nil];
    }
}

- (void)dismissFromCoverAction:(UITapGestureRecognizer *)sender {
    if (self.shouldDismissOnBackgroundTouch) {
        [self dismissAction:sender];
    }
}

- (void)keyboardAction:(NSNotification *)sender {
    if ([sender.name isEqualToString:UIKeyboardDidHideNotification]) {
        self.showKeyboard = NO;
    }else if([sender.name isEqualToString:UIKeyboardDidShowNotification]){
        self.showKeyboard = YES;
    }
}

@end

@implementation UIView (CatPopView)

- (CatPopView *)cc_popView {
    /// 是否已被添加
    if ([[[self superview] superview] isKindOfClass:CatPopView.class]) {
        CatPopView *popView = (CatPopView *)[[self superview] superview];
        return popView;
    }else {
        CatPopView *popView = CatPopView.new;
        popView.presentedView = self;
        return popView;
    }
}

@end
