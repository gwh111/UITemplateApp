//
//  CatPager.h
//  UITemplateLib
//
//  Created by gwh on 2019/4/24.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CatPagerSegment.h"

NS_ASSUME_NONNULL_BEGIN

@class CatPager;
@protocol CatPagerDelegate <NSObject>

/**
 选中的索引和名称

 @param catPager catPager
 @param index 索引
 */
- (void)catPager:(CatPager*)catPager didSelectRowAtIndex:(NSInteger)index;

@end

@interface CatPager : NSObject

/**
 *  获取segment
 */
@property (nonatomic, readonly, strong) CatPagerSegment *segment;

/**
 当前选中索引
 */
@property (nonatomic, assign) NSInteger currentIndex;
/**
 设置关联的scrollView，scrollView滚动时，segment也有滚动
 */
@property (nonatomic, weak) UIScrollView* contentScrollView;
@property (nonatomic, weak) id <CatPagerDelegate>delegate;

/**
 选择第几个
 
 @param index 第几个
 @param animated 是否有动画
 */
- (void)selectItemAtIndex:(NSInteger)index animated:(BOOL)animated;

/**
 初始化在哪个视图上

 @param view 视图
 @param theme 主题
 @param itemArr 内容
 @param selectedIndex 默认选中项
 @return 实例
 */
- (instancetype)initOn:(UIView *)view theme:(CatPagerTheme)theme itemArr:(NSArray*)itemArr selectedIndex:(NSUInteger)selectedIndex;

/**
 *  设置宽度 默认屏幕宽度（居中）
 */
- (void)updateWidth:(float)width;

/**
 *  设置高度
 *  CatPagerThemeRound  cell高度为height-RH(20)
 *  CatPagerThemeRoundCorner  cell高度为height-RH(24)
 */
- (void)updateHeight:(float)height;

/// 设置内边距
- (void)updatePadding:(float)padding;

/**
 *  更新样式
 textColor           选中时的字体色
 selectedBackColor   选中时的背景色
 defaultColor        未选中时的字体色
 backColor           控件的背景色
 bottomLineColor           底部横线的背景色
 */
- (void)updateSelectedTextColor:(UIColor *)selectedTextColor selectedBackColor:(UIColor *)selectedBackColor textColor:(UIColor *)textColor backColor:(UIColor *)backColor bottomLineColor:(UIColor *)bottomLineColor;

/**
 *  更新栏目
 */
- (void)updateItems:(NSArray *)itemArr;

/**
 更新标签类型及内容
 
 @param index 标签索引
 @param tagType 标签类型
 @param content 标签内容
 */
- (void)updateItemAtIndex:(NSInteger)index tagType:(CatPagerCellTagType)tagType content:(nullable NSString*)content;

/**
 更新 CatPagerThemeLineZoom 下放大的字体
 
 @param zoomFont 放大之后的字体
 */
- (void)updateCatPagerThemeLineZoom:(UIFont*)zoomFont;

/**
 更新 CatPagerThemeLineZoom 放大之后的下划线高度
 
 @param lineSize 放大之后的下划线高度
 */
-(void)updateCatPagerThemeLineSize:(CGSize)lineSize;

/**
 隐藏有下划线的item的下划线
 
 @param hidden YES:隐藏；NO:显示
 */
-(void)updateBottomLine:(BOOL)hidden;

/// 更改普通状态下的字体
/// @param font 字体
-(void)updateCatPagerTitleFont:(UIFont *)font;
@end

NS_ASSUME_NONNULL_END
