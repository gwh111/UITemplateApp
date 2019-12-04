//
//  CatStrongAlertTool.h
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/8.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ccs.h"

typedef NS_ENUM(NSUInteger, CatStrongAlertTheme) {
    CatStrongAlertThemeUpdateHorizontal,//更新提示框-两个按钮在同一水平线上
    CatStrongAlertThemeUpdateVerticality,//更新提示框-两个按钮在同一垂直线上
    
    CatStrongAlertThemeGoToWeibo,//跳转关注微博提示框
    
    CatStrongAlertThemeCheerUpHorizontal,//鼓励提示框-两个按钮在同一水平线上
    CatStrongAlertThemeCheerUpVerticality,//鼓励提示框-两个按钮在同一垂直线上
    
    CatStrongAlertThemeVip,//成为会员提示框
};

NS_ASSUME_NONNULL_BEGIN


@interface CatStrongAlertTool : NSObject

/**
 计算label高度

 @param string 内容
 @param maxWidth 最大宽度
 @param font 字体
 @return 高度
 */
+(CGFloat)caculateLabelHeight:(NSString*)string maxWidth:(CGFloat)maxWidth font:(UIFont*)font;

@end

NS_ASSUME_NONNULL_END
