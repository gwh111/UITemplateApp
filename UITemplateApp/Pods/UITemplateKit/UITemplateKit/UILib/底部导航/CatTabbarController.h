//
//  CatTabbarController.h
//  UITemplateKit
//
//  Created by 路飞 on 2019/5/31.
//  Copyright © 2019 路飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ccs.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CatTabbarTheme) {
    CatTabbarThemeNormal,//文字+图片
    CatTabbarThemeImage,//纯图片
};

/**
 底部导航
 */
@interface CatTabbarController : UITabBarController<UITabBarDelegate>

/**
 初始化底部导航栏

 @param classNameArr 类名数组
 @param titleArr 导航名数组
 @param imageNameArr 导航图片名数组
 @param selectedImageArr 导航选中图片名数组
 @param theme 导航类型
 @return 实例
 */
- (instancetype)initWithClassNameArr:(NSArray<NSString*>*)classNameArr titleArr:(nullable NSArray<NSString*>*)titleArr imageNameArr:(NSArray<NSString*>*)imageNameArr selectedImageNameArr:(NSArray<NSString*>*)selectedImageArr textColor:(nullable UIColor*)textColor selectedTextColor:(nullable UIColor*)selectedTextColor theme:(CatTabbarTheme)theme;

/**
 添加底部导航栏item

 @param className 类名
 @param title 导航名
 @param imageName 导航图片名
 @param selectedImageName 导航选中图片名
 @param index 索引
 */
- (void)addItemWithClassName:(NSString*)className title:(NSString*)title imageName:(NSString*)imageName selectedImageName:(NSString*)selectedImageName index:(NSInteger)index;

/**
 删除底部导航栏item

 @param index 索引
 */
- (void)deleteItemAtIndex:(NSInteger)index;

/**
 更新角标

 @param badgeNum 角标内容
 @param index 索引
 */
- (void)updateBadgeNum:(nullable NSString*)badgeNum index:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
