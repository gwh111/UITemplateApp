//
//  CatStrongAlert.h
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/7.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CatStrongAlertView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CatStrongAlertUpdateType) {
    CatStrongAlertUpdateHorizontal,//更新提示框-两个按钮在同一水平线上
    CatStrongAlertUpdateVerticality,//更新提示框-两个按钮在同一垂直线上
};

typedef NS_ENUM(NSUInteger, CatStrongAlertCheerUpType) {
    CatStrongAlertCheerUpHorizontal,//鼓励提示框-两个按钮在同一水平线上
    CatStrongAlertCheerUpVerticality,//鼓励提示框-两个按钮在同一垂直线上
};

@class CatStrongAlert;
@protocol CatStrongAlertDelegate <NSObject>
@optional
//取消
-(void)catStrongAlertCancel:(CatStrongAlert*)alertView;
//确认
-(void)catStrongAlertConfirm:(CatStrongAlert*)alertView;
//关闭
-(void)catStrongAlertClose:(CatStrongAlert*)alertView;

@end
@interface CatStrongAlert : NSObject

@property (nonatomic, weak) id<CatStrongAlertDelegate>delegate;

/**
 创建更新弹框
 
 @param title 主标题 换行自己加\n
 @param content 内容
 @param bgImage 背景大图 可以UIImage、NSURL、NSString
 @param cancelTitle 取消框文字
 @param confirmTitle 确认框文字
 @param type 更新类型
 @param isShowCancel 是否展示取消按钮
 @return 实例
 */
- (instancetype)initWithTitle:(NSString*)title content:(NSString*)content bgImage:(id)bgImage cancelTitle:(NSString*)cancelTitle confirmTitle:(NSString*)confirmTitle type:(CatStrongAlertUpdateType)type isShowCancel:(BOOL)isShowCancel;

/**
 创建跳转关注微博提示框
 
 @param title 主标题
 @param content 内容
 @param bgImage 背景大图 可以UIImage、NSURL、NSString
 @param cancelTitle 取消框文字
 @param confirmTitle 确认框文字
 @return 实例
 */
- (instancetype)initWithTitle:(NSString*)title content:(NSString*)content bgImage:(id)bgImage cancelTitle:(NSString*)cancelTitle confirmTitle:(NSString*)confirmTitle;

/**
 创建鼓励提示框
 
 @param title 主标题
 @param bgImage 背景大图 可以UIImage、NSURL、NSString
 @param cancelTitle 取消框文字
 @param confirmTitle 确认框文字
 @param type 鼓励类型
 @return 实例
 */
- (instancetype)initWithTitle:(NSString*)title bgImage:(id)bgImage cancelTitle:(NSString*)cancelTitle confirmTitle:(NSString*)confirmTitle type:(CatStrongAlertCheerUpType)type;

/**
 创建Vip弹框
 
 @param title 主标题
 @param content 内容
 @param bgImage 背景大图 可以UIImage、NSURL、NSString
 @param ticketImage 代金券图片
 @param ticketName 代金券名字
 @param cancelTitle 取消框文字
 @param confirmTitle 确认框文字
 @return 实例
 */
- (instancetype)initWithTitle:(NSString*)title content:(NSString*)content bgImage:(id)bgImage ticketImage:(UIImage*)ticketImage ticketName:(NSString*)ticketName cancelTitle:(NSString*)cancelTitle confirmTitle:(NSString*)confirmTitle;

/**
 弹出强提示弹框
 */
-(void)popUpCatAlertStrongView;

@end

NS_ASSUME_NONNULL_END
