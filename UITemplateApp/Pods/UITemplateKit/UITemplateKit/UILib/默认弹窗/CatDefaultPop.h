//
//  CatDefaultPop.h
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/13.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ccs.h"
#import "CatDefaultPopView.h"

NS_ASSUME_NONNULL_BEGIN

@class CatDefaultPop;
@protocol CatDefaultPopDelegate <NSObject>
@optional
//取消
-(void)catDefaultPopCancel:(CatDefaultPop*)defaultPop;
//确认
-(void)catDefaultPopConfirm:(CatDefaultPop*)defaultPop;

@end

@interface CatDefaultPop : NSObject

@property (nonatomic, weak) id<CatDefaultPopDelegate>delegate;
@property (nonatomic, strong) CatDefaultPopView* popView;
//扩展参数-供传递
@property (nonatomic, strong) NSDictionary* exParamDic;
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
 弹出默认弹框
 */
- (void)popUpCatDefaultPopView;

/**
 隐藏默认弹框
 */
- (void)dismissCatDefaultPopView;

/**
 更新取消/确认 文字颜色
 
 @param cancelColor 取消文字颜色
 @param confimColor 确认文字颜色
 */
- (void)updateCancelColor:(UIColor*)cancelColor confirmColor:(UIColor*)confimColor;

@end

NS_ASSUME_NONNULL_END
