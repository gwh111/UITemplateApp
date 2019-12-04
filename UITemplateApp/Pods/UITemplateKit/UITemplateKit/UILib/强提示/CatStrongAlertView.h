//
//  CatStrongAlertView.h
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/8.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CatStrongAlertTool.h"

NS_ASSUME_NONNULL_BEGIN
@class CatStrongAlertView;
@protocol CatStrongAlertViewDelegate <NSObject>
@optional
//取消
-(void)catStrongAlertViewCancel:(CatStrongAlertView*)alertView;
//确认
-(void)catStrongAlertViewConfirm:(CatStrongAlertView*)alertView;
//关闭
-(void)catStrongAlertViewClose:(CatStrongAlertView*)alertView;

@end

@interface CatStrongAlertView : UIView

@property (nonatomic, weak) id<CatStrongAlertViewDelegate>delegate;

/**
 创建弹框
 
 @param title 主标题
 @param content 内容
 @param bgImage 背景大图
 @param ticketImage 代金券图片
 @param ticketName 代金券名字
 @param cancelTitle 取消框文字
 @param confirmTitle 确认框文字
 @param theme 主题
 @param isShowCancel 是否展示取消按钮
 @return 实例
 */
-(instancetype)initWithTitle:(NSString*)title content:(nullable NSString*)content bgImage:(id)bgImage ticketImage:(nullable UIImage *)ticketImage ticketName:(nullable NSString *)ticketName cancelTitle:(NSString*)cancelTitle confirmTitle:(NSString*)confirmTitle theme:(CatStrongAlertTheme)theme isShowCancel:(BOOL)isShowCancel;

@end

NS_ASSUME_NONNULL_END
