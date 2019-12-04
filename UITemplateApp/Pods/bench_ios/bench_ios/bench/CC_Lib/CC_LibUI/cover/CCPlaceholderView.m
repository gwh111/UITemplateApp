//
//  CCPlaceholderView.m
//  CoverDemo
//
//  Created by Shepherd on 2019/10/27.
//  Copyright © 2019 Shepherd. All rights reserved.
//

#import "CCPlaceholderView.h"
#import "CCGradientConfiguration.h"
#import "UIView+CCCover.h"
#import "NSObject+CCKVO.h"

@implementation CCPlaceholderView

- (instancetype)init {
    if (self = [super init]) {
        _gradientConfiguration = [[CCGradientConfiguration alloc] initWithColor:UIColor.whiteColor];
        _gradientLayer = CAGradientLayer.new;
        _fadeAnimationDuration = 0.15;
        _maskLayer = CAShapeLayer.new;
    }
    return self;
}

- (void)setGradientColor:(UIColor *)gradientColor {
    [self.gradientConfiguration setMainColor:gradientColor];
}

- (BOOL)isCovering {
    return self.superview != nil ;
}

- (void)cover:(UIView *)viewToCover animated:(BOOL)animated {
    [viewToCover layoutIfNeeded];
    [self setupView:viewToCover];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startLoading:animated];
    });
}

- (void)uncover:(BOOL)animated {
    if (self.isCovering == NO) { return; }
    [self fadeOut:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.fadeAnimationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeGradientAndMask];
        [self removeFromSuperview];
    });
}

- (void)setupView:(UIView *)viewToCover {
    _viewToCover = viewToCover;
    self.frame = viewToCover.bounds;
    
    [self cc_addObserverBlockForKeyPath:@"bounds" block:^(id  _Nonnull obj, id  _Nonnull oldVal, id  _Nonnull newVal) {
        if (self.isCovering) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self setupMaskLayerIfNeeded];
                [self setupGradientLayerIfNeeded];
            });
        }
    }];
}

- (void)startLoading:(BOOL)animated {
    if (self.isCovering || !self.viewToCover) { return ; }
    [self.viewToCover addSubview:self];
    
    self.translatesAutoresizingMaskIntoConstraints = false;
    
    self.frame = self.viewToCover.bounds;
    [NSLayoutConstraint activateConstraints:@[
        [self.topAnchor constraintEqualToAnchor:self.viewToCover.topAnchor],
        [self.bottomAnchor constraintEqualToAnchor:self.viewToCover.bottomAnchor],
        [self.leftAnchor constraintEqualToAnchor:self.viewToCover.leftAnchor],
        [self.rightAnchor constraintEqualToAnchor:self.viewToCover.rightAnchor]
    ]];
    
    [self setupMaskLayerIfNeeded];
    [self setupGradientLayerIfNeeded];
    [self setupGradientLayerAnimation];
    [self fadeIn:animated];
}

- (void)setupMaskLayerIfNeeded {
    if (!self.superview) { return ; }
    self.maskLayer.frame = self.superview.bounds;
    UIBezierPath *totalBezierPath = [self.superview cc_subviewsCoverablePath];
    
    self.maskLayer.path = totalBezierPath.CGPath;
    self.maskLayer.fillColor = UIColor.redColor.CGColor;
    [self.layer addSublayer:self.maskLayer];
}

- (void)setupGradientLayerIfNeeded {
    if (!self.superview) { return; }
    self.gradientLayer.frame = CGRectMake(0, 0, self.superview.bounds.size.width, self.superview.bounds.size.height);
    [self.superview.layer addSublayer:self.gradientLayer];
    self.gradientLayer.startPoint = CGPointMake(-1-self.gradientConfiguration.width * 2, 0);
    self.gradientLayer.endPoint = CGPointMake(1+self.gradientConfiguration.width * 2, 0);
    self.gradientLayer.colors = @[
        (__bridge id)self.gradientConfiguration.backgroundColor.CGColor,
        (__bridge id)self.gradientConfiguration.primaryColor.CGColor,
        (__bridge id)self.gradientConfiguration.secondaryColor.CGColor,
        (__bridge id)self.gradientConfiguration.primaryColor.CGColor,
        (__bridge id)self.gradientConfiguration.backgroundColor.CGColor,
    ];
    
    NSArray *startLocations = @[@(self.gradientLayer.startPoint.x),
                                @(self.gradientLayer.startPoint.x),
                                @(0),
                                @(self.gradientConfiguration.width),
                                @(1+self.gradientConfiguration.width)];
    
    self.gradientLayer.locations = startLocations;
    self.gradientLayer.cornerRadius = self.superview.layer.cornerRadius;
    [self.layer addSublayer:self.gradientLayer];
    self.gradientLayer.mask = self.maskLayer;
}

- (void)setupGradientLayerAnimation {
    CABasicAnimation *gradientAnimation = [CABasicAnimation animationWithKeyPath:@"locations"];
    gradientAnimation.fromValue = self.gradientLayer.locations;
    gradientAnimation.toValue = @[@(0),@(1),@(1),@(1 + self.gradientConfiguration.width),@(1 + self.gradientConfiguration.width)];
    gradientAnimation.repeatCount = INFINITY;
    gradientAnimation.removedOnCompletion = NO;
    gradientAnimation.duration = self.gradientConfiguration.animationDuration;
    [self.gradientLayer addAnimation:gradientAnimation forKey:@"locations"];
    
}

- (void)fadeIn:(BOOL)animated {
    if (animated == NO) {
        self.alpha = 1;
        return;
    }
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @(self.alpha);
    opacityAnimation.toValue = @(1);
    opacityAnimation.duration = self.fadeAnimationDuration;
    
    [self.gradientLayer addAnimation:opacityAnimation forKey:@"opacityAnimationIn"];
    
    [UIView animateWithDuration:self.fadeAnimationDuration animations:^{
        self.alpha = 1;
    }];
}

- (void)fadeOut:(BOOL)animated {
    if (animated == NO) {
        self.alpha = 0;
        return;
    }
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @(self.alpha);
    opacityAnimation.toValue = @(0);
    opacityAnimation.duration = self.fadeAnimationDuration;
    
    [self.gradientLayer addAnimation:opacityAnimation forKey:@"opacityAnimationOut"];
    
    [UIView animateWithDuration:self.fadeAnimationDuration animations:^{
        self.alpha = 0;
    }];
}

- (void)removeGradientAndMask {
    [self.gradientLayer removeAllAnimations];
    [self.gradientLayer removeFromSuperlayer];
    [self.maskLayer removeFromSuperlayer];
}

- (void)dealloc {
    [self cc_removeObserverBlocksForKeyPath:@"bounds"];
}

@end
