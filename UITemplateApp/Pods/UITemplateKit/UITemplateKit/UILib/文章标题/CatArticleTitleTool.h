//
//  CatArticleTitleTool.h
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/20.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ccs.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CatArticleTitleTheme) {
    CatArticleTitleThemeMultiplyTag,//名字带标签
    CatArticleTitleThemeHeadView,//有头部视图、关注
    CatArticleTitleThemeMultiplyIndex,//有索引目录
    CatArticleTitleThemeDescriptionFocus,//有描述、关注
    CatArticleTitleThemeSubtitle,//有副标题
    CatArticleTitleThemeNormal//普通的
};

@interface CatArticleTitleTool : NSObject

+ (CGFloat)caculateTextWidth:(NSString*)text font:(UIFont*)font height:(CGFloat)height;

+ (CGFloat)caculateTextHeight:(NSString*)text font:(UIFont*)font width:(CGFloat)width;

+ (CGFloat)caculateAttributedTextHeight:(NSAttributedString*)attText width:(CGFloat)width;

+ (NSAttributedString*)caculateTitleContent:(NSString*)text imgTagArr:(NSArray*)imgTagArr font:(UIFont*)font color:(UIColor*)color;

+ (void)drawCorners:(UIView*)view cornerRadius:(CGFloat)cornerRadius;

@end

NS_ASSUME_NONNULL_END
