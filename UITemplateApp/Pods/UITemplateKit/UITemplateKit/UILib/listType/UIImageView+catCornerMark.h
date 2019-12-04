//
//  UIImageView+cornerMark.h
//  UITemplateLib
//
//  Created by yichen on 2019/6/3.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (cornerMark)

/**
 右下角占位图
 */
@property (nonatomic ,assign) BOOL isCornerShowed;

@property (nonatomic ,strong) UIImageView *cornerMarkIcon;

- (void)addImageWithCornerImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
