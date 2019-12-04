//
//  KKPlayerLabelView.h
//  kk_espw
//
//  Created by hsd on 2019/7/19.
//  Copyright © 2019 david. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 玩家标签数据模型
@interface CatAttributedAlertLabelModel : NSObject

@property (nonatomic, strong, nullable) UIColor *bgColor;           ///< 背景色
@property (nonatomic, strong, nullable) UIImage *img;               ///< 图片
@property (nonatomic, strong, nullable) NSString *labelString;      ///< 玩家标签

@property (nonatomic, strong, nonnull) UIFont *labelFont;           ///< 字体, 不需要设置,默认根据UI图写死
@property (nonatomic, strong, nonnull) UIColor *labelColor;         ///< 颜色, 不需要设置,默认根据UI图写死

/// 工厂方法
+ (instancetype _Nonnull)createWithBgColor:(UIColor * _Nullable)bgColor
                                       img:(UIImage * _Nullable)img
                                  labelStr:(NSString * _Nullable)labelStr;

@end

NS_ASSUME_NONNULL_BEGIN

/// 玩家标签
@interface CatAttributedAlertLabel : UIView

/// 数据源
@property (nonatomic, strong, nonnull) CatAttributedAlertLabelModel *model;

/// 图标距离左侧x点, 默认2
@property (nonatomic, assign) CGFloat iconImageToLeft;

/// 文字距离图标x点， 默认2
@property (nonatomic, assign) CGFloat labelToIconImage;

/// 文字距离尾部x点, 默认2
@property (nonatomic, assign) CGFloat labelToTrail;

/// 图标宽度, 10
@property (nonatomic, assign, readonly) CGFloat iconImageWidth;

@end

NS_ASSUME_NONNULL_END
