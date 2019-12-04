//
//  UIViewController+CatBase.h
//  UITemplateKit
//
//  Created by 路飞 on 2019/6/4.
//  Copyright © 2019 路飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ccs.h"

typedef NS_ENUM(NSUInteger, CatNavBarType) {
    CatNavBarTypeRed,           // 红色背景 白色标题
    CatNavBarTypeWhite,         //白色背景  黑色标题
    CatNavBarTypeClear,         //透明背景  无标题
    CatNavBarTypeGray,           // 灰色背景f2f2f2, 黑色标题
    CatNavBarTypeChangeRed           // 公会主页大红色背景 白色标题
};

NS_ASSUME_NONNULL_BEGIN

@class CatNavBarView;
@interface UIViewController (CatBase)

@property (nonatomic, strong) CatNavBarView *cat_navigationBarView;

/**
 设置使用自定义navigation bar    红底白字
 */
-(void)setCatNavigationBar;

/**
 设置使用自定义navigation bar   白底黑字
 */
-(void)setCatNavigationBarWhite;

/**
 设置使用自定义navigation bar   透明无标题
 */
-(void)setCatNavigationBarClear;

/**
 设置使用自定义navigation bar   灰底,黑字
 */
-(void)setCatNavigationBarGray;

/**
 设置使用自定义navigation bar    大红底白字
 */
-(void)setCatNavigationBarBigRed ;
/**
 设置使用自定义navigationBar
 
 @param barType 类型
 */
-(void)setCatNavigationBarWithType:(CatNavBarType)barType;

/**
 自定义navigationBar 的 title
 
 @return t
 */
-(NSString *)catNavBarTitle;

/**
 设置自定义navigation bar 的标题
 
 @param title 标题
 */
-(void)setCatNavBarTitle:(NSString *)title;

/**
 自定义导航栏的高度
 
 */
-(CGFloat)catNavBarHeight;

/**
 设置导航栏的背景图
 
 @param image 背景图
 */
-(void)setCatNavBarBackgroundImage:(UIImage *)image;

/**
 设置导航栏背景色,此方法会隐藏导航栏背景图
 
 @param color 颜色
 */
-(void)setCatNavBarBackgroundColor:(UIColor *)color;

/**
 设置导航栏title的颜色
 
 @param color 颜色
 */
-(void)setCatNavBarTitleColor:(UIColor *)color;

/**
 设置导航栏title的字体大小
 
 @param font 字体大小
 */
-(void)setCatNavBarTitleFont:(UIFont *)font;

/**
 获取导航栏类型
 */
-(CatNavBarType)getCatNavBarType;

/**
 隐藏默认的返回按钮
 */
-(void)hiddenBackButton;

/**
 *  添加展示内容view 不包含头部导航栏区域
 */
-(UIView *)setCatDisplayView;
@end

NS_ASSUME_NONNULL_END
