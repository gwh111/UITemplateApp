//
//  CatStrongAlertTool.m
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/8.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CatStrongAlertTool.h"

@implementation CatStrongAlertTool

+(CGFloat)caculateLabelHeight:(NSString *)string maxWidth:(CGFloat)maxWidth font:(UIFont *)font{
    CGSize size = [string boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    
    return size.height;
}

@end
