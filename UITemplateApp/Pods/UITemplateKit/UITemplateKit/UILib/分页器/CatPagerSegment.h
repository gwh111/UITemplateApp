//
//  CatPagerSegment.h
//  UITemplateLib
//
//  Created by 路飞 on 2019/4/25.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CatPagerTool.h"

NS_ASSUME_NONNULL_BEGIN

@interface CatPagerCollectionViewCell : UICollectionViewCell

//标签
@property (nonatomic, strong) UILabel* tagLb;
//内容
@property (nonatomic, strong) UILabel* label;
//下划线
@property (nonatomic, strong) UIView* bottomLineView;
//数据
@property (nonatomic, strong) CatPagerModel* model;

@end

@protocol CatPagerSegmentDelegate <NSObject>

/**
 选中的索引和名称
 
 @param catPagerSegment catPagerSegment
 @param index 索引
 */
- (void)catPagerSegment:(CatPagerSegment*)catPagerSegment didSelectRowAtIndex:(NSInteger)index;

@end
@interface CatPagerSegment : UIView

//segment的类型
@property (nonatomic, assign) CatPagerTheme theme;
//字体颜色
@property (nonatomic, strong) UIColor* textColor;
//选中的字体颜色
@property (nonatomic, strong) UIColor* selectedTextColor;
//背景颜色
@property (nonatomic, strong) UIColor* backColor;
//选中的背景颜色
@property (nonatomic, strong) UIColor* selectedBackColor;
//底部横线颜色
@property (nonatomic, strong) UIColor* bottomLineColor;
//字体大小
@property (nonatomic, strong) UIFont* itemFont;
//字体大小
@property (nonatomic, strong) UIFont* itemZoomFont;
//底部横线是否隐藏
@property (nonatomic, assign, getter=isBottomLineHidden) BOOL bottomLineHidden;
//底部横线size
@property (nonatomic, assign) CGSize bottomLineSize;
//segment的item数组
@property (nonatomic, strong) NSArray* itemArr;
//segment高度
@property (nonatomic, assign) CGFloat segmentHeight;
//collectionview的上左下右边距
@property (nonatomic, assign) UIEdgeInsets edges;
//每个item左右间距
@property (nonatomic, assign) CGFloat interitemSpace;
//内边距
@property (nonatomic, assign) CGFloat padding;
/// 右上角角标的字体
@property (nonatomic,strong) UIFont *badgeFont;

@property (nonatomic, weak) id<CatPagerSegmentDelegate>delegate;
/**
 初始化segment

 @param theme 类型
 @param itemArr item数组
 @param selectedIndex 默认选中index
 @return segment实例
 */
- (instancetype)initWithTheme:(CatPagerTheme)theme itemArr:(NSArray*)itemArr selectedIndex:(NSUInteger)selectedIndex;

/**
 *  设置宽度 默认屏幕宽度
 */
- (void)updateWidth:(float)width;

/**
 *  设置高度 默认48
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
 选择第几个

 @param index 第几个
 @param animated 是否有动画
 */
- (void)selectItemAtIndex:(NSInteger)index animated:(BOOL)animated;

/**
 更新item数组
 
 @param itemArr item数组
 */
- (void)updateItemArr:(NSArray*)itemArr;

/**
 更新标签类型及内容

 @param index 标签索引
 @param tagType 标签类型
 @param content 标签内容
 */
-(void)updateItemAtIndex:(NSInteger)index tagType:(CatPagerCellTagType)tagType content:(nullable NSString*)content;

/**
 更新 CatPagerThemeLineZoom 下放大的字体

 @param zoomFont 放大之后的字体
 */
-(void)updateCatPagerThemeLineZoom:(UIFont*)zoomFont;

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
