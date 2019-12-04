//
//  UIImage+CatRTTint.h
//  UITemplateKit
//
//  Created by 路飞 on 2019/6/6.
//  Copyright © 2019 路飞. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
 *  可以很方便给图片进行染色（Tinting）、增加亮度（lightening）以及降低亮度（darkening）
 */
@interface UIImage (CatRTTint)

-(UIImage*)rt_tintedImageWithColor:(UIColor*)color;
-(UIImage*)rt_tintedImageWithColor:(UIColor*)color level:(CGFloat)level;
-(UIImage*)rt_tintedImageWithColor:(UIColor*)color rect:(CGRect)rect;
-(UIImage*)rt_tintedImageWithColor:(UIColor*)color rect:(CGRect)rect level:(CGFloat)level;
-(UIImage*)rt_tintedImageWithColor:(UIColor*)color insets:(UIEdgeInsets)insets;
-(UIImage*)rt_tintedImageWithColor:(UIColor*)color insets:(UIEdgeInsets)insets level:(CGFloat)level;

-(UIImage*)rt_lightenWithLevel:(CGFloat)level;
-(UIImage*)rt_lightenWithLevel:(CGFloat)level insets:(UIEdgeInsets)insets;
-(UIImage*)rt_lightenRect:(CGRect)rect withLevel:(CGFloat)level;

-(UIImage*)rt_darkenWithLevel:(CGFloat)level;
-(UIImage*)rt_darkenWithLevel:(CGFloat)level insets:(UIEdgeInsets)insets;
-(UIImage*)rt_darkenRect:(CGRect)rect withLevel:(CGFloat)level;

@end

NS_ASSUME_NONNULL_END
