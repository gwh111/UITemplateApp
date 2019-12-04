//
//  CCGradientConfiguration.h
//  CoverDemo
//
//  Created by ml on 2019/10/28.
//  Copyright © 2019 Shepherd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCGradientConfiguration : NSObject

@property (nonatomic,assign) CGFloat width;

@property (nonatomic,assign) NSTimeInterval animationDuration;

@property (nonatomic,strong) UIColor *backgroundColor;

@property (nonatomic,strong) UIColor *primaryColor;

@property (nonatomic,strong) UIColor *secondaryColor;

@property (nonatomic,assign) NSTimeInterval fadeAnimationDuration;

- (void)setMainColor:(UIColor *)color;


- (instancetype)initWithColor:(UIColor *)mainColor;

@end

NS_ASSUME_NONNULL_END
