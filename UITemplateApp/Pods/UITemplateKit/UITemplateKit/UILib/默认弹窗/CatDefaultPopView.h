//
//  CatDefaultPopView.h
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/13.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ccs.h"

NS_ASSUME_NONNULL_BEGIN

@class CatDefaultPopView;
@protocol CatDefaultPopViewDelegate <NSObject>
@optional
//取消
-(void)catDefaultPopViewCancel:(CatDefaultPopView*)defaultPopView;
//确认
-(void)catDefaultPopViewConfirm:(CatDefaultPopView*)defaultPopView;

@end

@interface CatDefaultPopView : UIView

@property (nonatomic, weak) id<CatDefaultPopViewDelegate>delegate;
@property (nonatomic, strong) UILabel* contentLb;
/**
 创建默认弹框
 
 @param title 标题
 @param content 内容
 @param cancelTitle 取消框文字
 @param confirmTitle 确认框文字
 @return 实例
 */
- (instancetype)initWithTitle:(NSString*)title content:(NSString*)content cancelTitle:(NSString*)cancelTitle confirmTitle:(NSString*)confirmTitle;

/**
 创建默认弹框-底部单个
 
 @param title 标题
 @param content 内容
 @param confirmTitle 确认框文字
 @return 实例
 */
- (instancetype)initWithTitle:(NSString*)title content:(NSString*)content confirmTitle:(NSString*)confirmTitle;

/**
 更新取消/确认 文字颜色
 
 @param cancelColor 取消文字颜色
 @param confimColor 确认文字颜色
 */
- (void)updateCancelColor:(UIColor*)cancelColor confirmColor:(UIColor*)confimColor;

@end

NS_ASSUME_NONNULL_END
