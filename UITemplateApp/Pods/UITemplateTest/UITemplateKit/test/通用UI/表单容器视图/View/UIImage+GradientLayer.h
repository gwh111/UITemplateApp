//
//  UIImage+GradientLayer.h
//  Patient
//
//  Created by ml on 2019/7/31.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (GradientLayer)

+ (UIImage *)gradientImageWithColors:(NSArray <UIColor *>*)colors
                                rect:(CGRect)rect;

+ (UIImage *)gradientImageWithColors:(NSArray <UIColor *>*)colors
                                rect:(CGRect)rect
                          startPoint:(CGPoint)sp
                            endPoint:(CGPoint)ep;

+ (UIImage *)gradientImageWithColors:(NSArray <UIColor *>*)colors
                                rect:(CGRect)rect
                          startPoint:(CGPoint)sp
                            endPoint:(CGPoint)ep
                           locations:(NSArray *)locations;

@end

NS_ASSUME_NONNULL_END
