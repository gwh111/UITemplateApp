//
//  CatNavBarView.h
//  UITemplateKit
//
//  Created by 路飞 on 2019/6/4.
//  Copyright © 2019 路飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+CatBase.h" 

NS_ASSUME_NONNULL_BEGIN

@interface CatNavBarView : UIView

@property (nonatomic,retain) CC_Button *backButton;
@property (nonatomic,strong) UILabel  *titleLabel;
@property (nonatomic,strong) UIImage *navBarBackgroundImage;
@property (nonatomic,strong) UIImageView *navBarImageView;
@property (nonatomic,assign) CatNavBarType barType;

-(void)hiddenBackButton;

/**
 设置背景颜色
 */
-(void)setNavBarBackGroundColor:(UIColor *)color;

/**
 设置标题颜色
 */
-(void)setNavBarTitleColor:(UIColor *)color;

/**
 设置标题字体大小
 */
-(void)setNavBarTitleFont:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
