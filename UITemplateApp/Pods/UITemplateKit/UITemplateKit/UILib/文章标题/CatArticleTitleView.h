//
//  CatArticleTitleView.h
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/20.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CatArticleTitleTool.h"

NS_ASSUME_NONNULL_BEGIN

/**
 点击人名、头像回调
 
 @param name 人名
 */
typedef void(^PersonBlock)(NSString* name);

/**
 点击关注按钮回调
 
 @param focusBtn 关注按钮
 */
typedef void(^FocusBlock)(UIButton* focusBtn);

/**
 点击目录索引回调
 
 @param tagName 索引内容
 */
typedef void(^IndexBlock)(NSString* tagName, NSInteger index);

@interface CatArticleTitleView : UIView

/**
 初始化文章标题视图

 @param frame frame
 @param title 标题
 @param subTitle 副标题
 @param imgTagArr 标签图片数组
 @param name 人名
 @param iconUrl 头像url
 @param iconPlaceholderImg 头像占位图
 @param headImgUrl 头部视图url
 @param headPlaceholderImg 头部视图占位图
 @param time 时间
 @param description 个人描述
 @param indexTagArr 目录索引数组
 @param theme 主题
 @param isFocused 是否已关注
 @param personBlock 点击人名回调
 @param focusBlock 点击关注回调
 @param indexBlock 点击目录索引回调
 @return 实例
 */
- (instancetype)initWithFrame:(CGRect)frame title:(NSString*)title subTitle:(nullable NSString*)subTitle imgTagArr:(nullable NSArray<UIImage*>*)imgTagArr name:(NSString*)name iconUrl:(nullable NSString*)iconUrl iconPlaceholderImg:(nullable UIImage*)iconPlaceholderImg headImgUrl:(nullable NSString*)headImgUrl headPlaceholderImg:(nullable UIImage*)headPlaceholderImg time:(nullable NSString*)time description:(nullable NSString*)description indexTagArr:(nullable NSArray<NSString*>*)indexTagArr theme:(CatArticleTitleTheme)theme isFocused:(BOOL)isFocused personBlock:(nullable PersonBlock)personBlock focusBlock:(nullable FocusBlock)focusBlock indexBlock:(nullable IndexBlock)indexBlock;

@end

NS_ASSUME_NONNULL_END
