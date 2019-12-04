//
//  CatCommonSelectView.h
//  UITemplateKit
//
//  Created by 路飞 on 2019/5/30.
//  Copyright © 2019 路飞. All rights reserved.
//

#define kCatCommonSelectViewHeight RH(232.0f)

#import <UIKit/UIKit.h>
#import "ccs.h"

NS_ASSUME_NONNULL_BEGIN

@class CatCommonSelectView;
@protocol CatCommonSelectViewDelegate <NSObject>
@optional
//取消
- (void)catCommonSelectViewCancel:(CatCommonSelectView*)commonSelectView;
//确认
- (void)catCommonSelectViewConfirm:(CatCommonSelectView*)commonSelectView selectData:(NSString*)selectData;
//确认
- (void)catCommonSelectViewConfirm:(CatCommonSelectView*)commonSelectView selectData:(NSString*)selectData index:(NSInteger)index;

@end

@interface CatCommonSelectView : UIView

@property (nonatomic, weak) id<CatCommonSelectViewDelegate>delegate;

/**
 初始化
 
 @param cancelTitle 取消标题
 @param confirmTitle 确认标题
 @param dataArr 数组
 @param selectContentColor 选中文字颜色
 @param unSelectContentColor 未选中文字颜色
 @param selectBarColor 选中背景条颜色
 @param selectIndex 默认选中索引
 @return 实例
 */
- (instancetype)initWithCancelTitle:(NSString*)cancelTitle confirmTitle:(NSString*)confirmTitle dataArr:(NSArray<NSString*>*)dataArr selectContentColor:(nullable UIColor*)selectContentColor unSelectContentColor:(nullable UIColor*)unSelectContentColor selectBarColor:(nullable UIColor*)selectBarColor selectIndex:(NSInteger)selectIndex;

@end

NS_ASSUME_NONNULL_END
