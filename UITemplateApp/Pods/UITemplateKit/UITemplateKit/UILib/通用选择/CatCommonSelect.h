//
//  CatCommonSelect.h
//  UITemplateKit
//
//  Created by 路飞 on 2019/5/30.
//  Copyright © 2019 路飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CatCommonSelectView.h"

NS_ASSUME_NONNULL_BEGIN

@class CatCommonSelect;
@protocol CatCommonSelectDelegate <NSObject>
@optional
//取消
- (void)catCommonSelectCancel:(CatCommonSelect*)commonSelect;
//确认
- (void)catCommonSelectConfirm:(CatCommonSelect*)commonSelect selectData:(NSString*)selectData;
//确认
- (void)catCommonSelectConfirm:(CatCommonSelect*)commonSelect selectData:(NSString*)selectData index:(NSInteger)index;
@end

@interface CatCommonSelect : NSObject

@property (nonatomic, weak) id<CatCommonSelectDelegate>delegate;
//选中文字颜色
@property (nonatomic, strong) UIColor* selectContentColor;
//未选中文字颜色
@property (nonatomic, strong) UIColor* unSelectContentColor;
//选中背景条颜色
@property (nonatomic, strong) UIColor* selectBarColor;
//默认选中索引
@property (nonatomic, assign) NSInteger selectIndex;
/**
 初始化

 @param cancelTitle 取消标题
 @param confirmTitle 确认标题
 @param dataArr 数组
 @return 实例
 */
- (instancetype)initWithCancelTitle:(NSString*)cancelTitle confirmTitle:(NSString*)confirmTitle dataArr:(NSArray<NSString*>*)dataArr;

/**
 弹出通用选择控件
 */
- (void)popUpCatCommonSelectView;

/**
 收起通用选择控件
 */
- (void)dismissCatCommonSelectView;

@end

NS_ASSUME_NONNULL_END
