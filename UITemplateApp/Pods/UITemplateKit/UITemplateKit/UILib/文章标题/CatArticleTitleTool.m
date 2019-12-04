//
//  CatArticleTitleTool.m
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/20.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatArticleTitleTool.h"

@implementation CatArticleTitleTool

+(CGFloat)caculateTextWidth:(NSString *)text font:(UIFont *)font height:(CGFloat)height{
    CGFloat width = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.width;
    return width;
}

+(CGFloat)caculateTextHeight:(NSString *)text font:(UIFont *)font width:(CGFloat)width{
    CGFloat height = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.height;
    return height;
}

+(CGFloat)caculateAttributedTextHeight:(NSAttributedString *)attText width:(CGFloat)width{
    CGFloat height = [attText boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
    return height;
}

+(NSAttributedString *)caculateTitleContent:(NSString *)text imgTagArr:(NSArray *)imgTagArr font:(UIFont *)font color:(UIColor *)color{
    NSMutableAttributedString* muaAttStr = [[NSMutableAttributedString alloc]init];
    for (UIImage* img in imgTagArr) {
        NSTextAttachment *attch = [[NSTextAttachment alloc] init];
        attch.image = img;
        attch.bounds = CGRectMake(0, RH(-4.0f), RH(30.0f), RH(15.0f));//专治小图标飘
        [muaAttStr appendAttributedString: [NSAttributedString attributedStringWithAttachment:attch]];
        [muaAttStr appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
    }
    NSAttributedString* attStr = [[NSAttributedString alloc]initWithString:text attributes:@{NSFontAttributeName:RF(11), NSForegroundColorAttributeName:RGBA(91, 94, 99, 1)}];
    [muaAttStr appendAttributedString:attStr];
    return [muaAttStr copy];
}

+ (void)drawCorners:(UIView*)view cornerRadius:(CGFloat)cornerRadius{
    //绘制圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:cornerRadius];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

@end
