//
//  CatArticleTitle.h
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/20.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CatArticleTitleView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CatArticleTitle : NSObject

/**
 初始化文章标题视图-内容：标题、人名（带标签）

 @param view 父视图
 @param origin 初始点位(x,y)（高度自适应）
 @param title 标题
 @param imgTagArr 标签图片数组
 @param name 人名
 @param personBlock 点击人名回调
 @return 实例
 */
- (instancetype)initOn:(UIView*)view origin:(CGPoint)origin title:(NSString*)title imgTagArr:(NSArray<UIImage*>*)imgTagArr name:(NSString*)name personBlock:(PersonBlock)personBlock;

/**
 初始化文章标题视图-内容：头视图、标题、人名、时间、头像、关注按钮
 
 @param view 父视图
 @param origin 初始点位(x,y)（高度自适应）
 @param headImgUrl 头视图
 @param headPlaceholder 头视图占位图
 @param title 标题
 @param iconUrl 头像url
 @param iconPlaceholder 头像占位图
 @param name 人名
 @param time 时间
 @param isFocused 是否已关注
 @param personBlock 点击人名回调
 @param focusBlock 点击关注回调
 @return 实例
 */
- (instancetype)initOn:(UIView*)view origin:(CGPoint)origin headImgUrl:(NSString*)headImgUrl headPlaceholder:(nullable UIImage*)headPlaceholder title:(NSString*)title iconUrl:(NSString*)iconUrl iconPlaceholder:(nullable UIImage*)iconPlaceholder name:(NSString*)name time:(NSString*)time isFocused:(BOOL)isFocused  personBlock:(PersonBlock)personBlock focusBlock:(FocusBlock)focusBlock;

/**
 初始化文章标题视图-内容：标题、人名、头像、时间、目录索引
 
 @param view 父视图
 @param origin 初始点位(x,y)（高度自适应）
 @param title 标题
 @param iconUrl 头像url
 @param iconPlaceholder 头像占位图
 @param name 人名
 @param time 时间
 @param indexTagArr 目录索引数组
 @param personBlock 点击人名回调
 @param indexBlock 点击目录索引回调
 @return 实例
 */
- (instancetype)initOn:(UIView*)view origin:(CGPoint)origin title:(NSString*)title iconUrl:(NSString*)iconUrl iconPlaceholder:(nullable UIImage*)iconPlaceholder name:(NSString*)name time:(NSString*)time indexTagArr:(NSArray<NSString*>*)indexTagArr personBlock:(PersonBlock)personBlock indexBlock:(IndexBlock)indexBlock;

/**
 初始化文章标题视图-内容：标题、人名、个人描述、头像、关注按钮
 
 @param view 父视图
 @param origin 初始点位(x,y)（高度自适应）
 @param title 标题
 @param iconUrl 头像url
 @param iconPlaceholder 头像占位图
 @param name 人名
 @param description 个人描述
 @param personBlock 点击人名回调
 @param focusBlock 点击关注回调
 @return 实例
 */
- (instancetype)initOn:(UIView*)view origin:(CGPoint)origin title:(NSString*)title iconUrl:(NSString*)iconUrl iconPlaceholder:(nullable UIImage*)iconPlaceholder  name:(NSString*)name description:(NSString*)description personBlock:(PersonBlock)personBlock focusBlock:(FocusBlock)focusBlock;

/**
 初始化文章标题视图-内容：标题、副标题、人名、头像
 
 @param view 父视图
 @param origin 初始点位(x,y)（高度自适应）
 @param title 标题
 @param subTitle 副标题
 @param name 人名
 @param iconUrl 头像url
 @param iconPlaceholder 头像占位图
 @param personBlock 点击人名回调
 @return 实例
 */
- (instancetype)initOn:(UIView*)view origin:(CGPoint)origin title:(NSString*)title subTitle:(NSString*)subTitle  name:(NSString*)name iconUrl:(NSString*)iconUrl iconPlaceholder:(nullable UIImage*)iconPlaceholder  personBlock:(PersonBlock)personBlock;

/**
 初始化文章标题视图-内容：标题、人名、头像、时间
 
 @param view 父视图
 @param origin 初始点位(x,y)（高度自适应）
 @param title 标题
 @param name 人名
 @param iconUrl 头像url
 @param iconPlaceholder 头像占位图
 @param time 时间
 @param personBlock 点击人名回调
 @return 实例
 */
- (instancetype)initOn:(UIView*)view origin:(CGPoint)origin title:(NSString*)title name:(NSString*)name iconUrl:(NSString*)iconUrl iconPlaceholder:(nullable UIImage*)iconPlaceholder time:(NSString*)time personBlock:(PersonBlock)personBlock;


@property (nonatomic, readonly, strong) CatArticleTitleView* articleTitleView;

@end

NS_ASSUME_NONNULL_END
