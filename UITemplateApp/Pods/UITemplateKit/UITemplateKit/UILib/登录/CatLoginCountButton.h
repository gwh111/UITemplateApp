//
//  CatLoginCountButton.h
//  UITemplateKit
//
//  Created by ml on 2019/6/12.
//  Copyright © 2019 路飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ccs.h"

NS_ASSUME_NONNULL_BEGIN

@interface CatLoginCountButton : UIButton

@property (nonatomic,assign) NSUInteger seconds;

@property (nonatomic,copy) NSString *placeholderText;
@property (nonatomic,copy) NSString *triggerText;

/** 点击是否立即触发倒计时 */
@property (nonatomic,assign) BOOL immediately;


- (instancetype)initWithFrame:(CGRect)frame
                      seconds:(NSUInteger)seconds;

- (instancetype)initWithFrame:(CGRect)frame
                      seconds:(NSUInteger)seconds
                      trigger:(void (^)(CatLoginCountButton *btn))trigger;

/**
 手动启动倒计时
 */
- (void)manualTrigger;

/**
 取消倒计时
 */
- (void)invalidate;


+ (instancetype)buttonWithSeconds:(NSUInteger)seconds
                          handler:(void (^)(CatLoginCountButton *btn))handler CC_DEPRECATED("initWithFrame:seconds");

+ (instancetype)buttonWithSeconds:(NSUInteger)seconds
                          handler:(void (^)(CatLoginCountButton * _Nonnull))handler
                            frame:(CGRect)frame CC_DEPRECATED("initWithFrame:seconds");


@end

NS_ASSUME_NONNULL_END
