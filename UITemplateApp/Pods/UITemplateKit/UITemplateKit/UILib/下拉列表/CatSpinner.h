//
//  CatSpinner.h
//  UITemplateLib
//
//  Created by gwh on 2019/4/25.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CatSpinnerList.h"
NS_ASSUME_NONNULL_BEGIN

@class CatSpinner;

@protocol CatSpinnerDelegate <NSObject>

@optional
- (void)catSpinner:(CatSpinner *)catSpinner didSelectRowAtIndex:(NSInteger)index itemName:(NSString *)itemName;
- (void)catSpinnerDimiss:(CatSpinner *)catSpinner;
@end

//下拉列表
@interface CatSpinner : NSObject

@property (nonatomic, strong, readonly) CatSpinnerList *csList;
@property (nonatomic, weak) id <CatSpinnerDelegate>csDelegate;


/// 初始化在哪个视图上
/// @param view 初始化父视图，若为空加载在window上
/// @param originPoint 列表左上角位置origin
/// @param iconArr 列表图片名称
/// @param itemArr 列表内容
- (instancetype)initOn:(nullable UIView*)view originPoint:(CGPoint)originPoint iconArr:(nullable NSArray<NSString*>*)iconArr itemArr:(NSArray<NSString*>*)itemArr;

/**
 弹出弹框
 */
-(void)popUp;

/**
 消失弹框
 */
-(void)dismissCatSpinnerList;

/**
 *  设置宽度 默认自适应
 */
- (void)updateWidth:(float)width;

/**
 *  设置样式
    textColor   文字颜色
    backColor   背景色
 */
- (void)updateTextColor:(UIColor *)textColor backColor:(UIColor *)backColor;

/**
 *  设置列表名称 没有图标情况
    items   列表名称数组
 */
- (void)updateItems:(NSArray *)items;

/**
 *  设置图标和列表名称
    icons   图标名称数组
    items   列表名称数组
 */
- (void)updateIcons:(NSArray *)icons items:(NSArray *)items;

/// 设置指定角的圆角
/// @param mask 指定角
/// @param cornerRadius 圆角半径
- (void)updateShapeCornerMask:(CACornerMask)mask cornerRadius:(CGFloat)cornerRadius API_AVAILABLE(macos(10.6), ios(11.0), watchos(2.0), tvos(9.0));

@end

NS_ASSUME_NONNULL_END
