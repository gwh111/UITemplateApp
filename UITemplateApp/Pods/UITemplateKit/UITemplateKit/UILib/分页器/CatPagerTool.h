//
//  CatPagerTool.h
//  UITemplateLib
//
//  Created by 路飞 on 2019/4/26.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ccs.h"

NS_ASSUME_NONNULL_BEGIN

@class CatPagerSegment;

typedef NS_ENUM(NSUInteger, CatPagerCellTagType) {
    CatPagerCellTagTypeNone,//无
    CatPagerCellTagTypePoint,//小红点
    CatPagerCellTagTypeContent,//文字
};

typedef NS_ENUM(NSUInteger, CatPagerTheme) {
    CatPagerThemeRect,//矩形
    CatPagerThemeRound,//圆
    CatPagerThemeRoundCorner,//小圆角
    CatPagerThemeSegmentRound,//整体带圆角
    CatPagerThemeLine,//下划线+各项下划线等长
    CatPagerThemeLineEqual,//下划线+和选中项字体等长
    CatPagerThemeLineZoom,//下划线+选中项字体放大
};

@interface CatPagerModel : NSObject
//内边距
@property (nonatomic, assign) CGFloat padding;
//是否选中
@property (nonatomic, assign, getter=isSelected) BOOL selected;
//内容
@property (nonatomic, strong) NSString* itemTitle;
//大小
@property (nonatomic, assign) CGSize itemSize;
//字体宽度
@property (nonatomic, assign) CGFloat itemWordsWidth;
//字体
@property (nonatomic, strong) UIFont* itemFont;
//放大字体
@property (nonatomic, strong) UIFont* itemZoomFont;
//左右间距
@property (nonatomic, assign) CGFloat itemMargin;
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
//底部横线size
@property (nonatomic, assign) CGSize bottomLineSize;
//底部横线是否隐藏
@property (nonatomic, assign, getter=isBottomLineHidden) BOOL bottomLineHidden;
//提示标签类型
@property (nonatomic, assign) CatPagerCellTagType tagType;
//提示标签内容
@property (nonatomic, strong) NSString* tagContent;

/// 提示标签字体
@property (nonatomic,strong) UIFont *badgeFont;
@end

@interface CatPagerTool : NSObject

/**
 把标题数组转模型数组

 @param array 标题数组
 @return 模型数组
 */
+(NSArray<CatPagerModel*>*)tranformArrayWithArray:(NSArray<NSString*>*)array theme:(CatPagerTheme)theme selectedIndex:(NSUInteger)selectedIndex  segment:(CatPagerSegment*)segment;

/**
 计算segment的一些参数（间距、内边距...）

 @param segment segment
 */
+(void)caculateCatPagerSegmentMargins:(CatPagerSegment*)segment;

/**
 设置CatPagerSegment基础配置

 @param segment segment
 */
+(void)caculateCatPagerSegmentDefaultConfig:(CatPagerSegment*)segment;

/**
 segment点击一个，把它置为选中，其他的都为为选中

 @param array 原数组
 @return 改变后的数组
 */
+(NSArray<CatPagerModel*>*)changeSegmentArrAfterClickOne:(NSArray<CatPagerModel*>*)array index:(NSInteger)index;

/**
 计算标签frame

 @param model 实例
 @return frame
 */
+(CGRect)caculateTagFrameWithModel:(CatPagerModel*)model;

@end

NS_ASSUME_NONNULL_END
