//
//  KKPlayerGameCardView.h
//  kk_espw
//
//  Created by hsd on 2019/7/23.
//  Copyright © 2019 david. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CatAttributedAlertLabelModel.h"

typedef NS_ENUM(NSInteger, CatAttributedAlertButtonType) {
    CatAttributedAlertButtonTypeAll              = 0,    ///< 所有按钮(默认两个,在上的为NoBorder, 在下的为Border)
    CatAttributedAlertButtonTypeNoBorder         = 1,    ///< 不带边框(加好友/发消息)
    CatAttributedAlertButtonTypeBorder           = 2,    ///< 带边框(移除开黑房)
    CatAttributedAlertButtonTypeNone             = 3,    ///< 不需要底部按钮
};

typedef NS_ENUM(NSInteger, CatAttributedAlertTapType) {
    CatAttributedAlertTapTypeBackground       = 0,    ///< 点击暗色背景
    CatAttributedAlertTapTypeLeftUp           = 1,    ///< 点击左上角按钮
    CatAttributedAlertTapTypeRightUp          = 2,    ///< 点击右上角按钮
    CatAttributedAlertTapTypeNoBorder         = 3,    ///< 点击不带边框按钮(加好友/发消息)
    CatAttributedAlertTapTypeBorder           = 4,    ///< 点击带边框按钮(移除开黑房)
};

typedef void(^CatAttributedAlertTapBlock)(CatAttributedAlertTapType tapType);

NS_ASSUME_NONNULL_BEGIN

/// 玩家游戏资料卡片
@interface CatAttributedAlert : UIView

/// 点击回调
@property (nonatomic, copy, nullable) CatAttributedAlertTapBlock tapBlock;

/// 设置左上角按钮文字颜色, 默认 ECC165
@property (nonatomic, strong, nullable) UIColor *leftUpTitleColor;

/// 局数颜色, 默认 ECC165
@property (nonatomic, strong, nullable) UIColor *gameNumbersColor;

/// 用户头像
@property (nonatomic, strong, nonnull, readonly) UIImageView *iconImgView;

/**
 根据按钮数初始化
 @param btnType 需要的按钮
 @return 实例
 */
- (instancetype)initWithButtons:(CatAttributedAlertButtonType)btnType;


/// 设置玩家昵称
- (void)setNickTitle:(NSString *)title;

/// 左上角按钮文字
- (void)setLeftUpBtnTitle:(NSString *)title;

/// 开黑游戏名称, 默认"王者荣耀开黑"
- (void)setGameNameTitle:(NSString *)title;

/**
 设置局数和单位
 @param numbersStr 局数(不包括后面的单位)
 @param unitStr 单位, 默认"局"
 */
- (void)setGameNumbersTitle:(NSString *)numbersStr unitTitle:(NSString * _Nullable)unitStr;

/// 一起组队文字, 默认"我和他组队"
- (void)setGameTogetherTitle:(NSString *)title;

/// 组队次数
- (void)setGameTogetherNumbersTitle:(NSString *)title;

/// 好评次数
- (void)setHighPraiseTitle:(NSString *)title;

/// 设置玩家标签
- (void)setPlayerLabels:(NSArray<CatAttributedAlertLabelModel *> * _Nullable)labelsArr;

/// 设置列表按钮背景色
- (void)setBackgroundColor:(UIColor * _Nullable)backgroundColor
             forButtonType:(CatAttributedAlertButtonType)btnType;

/// 设置列表按钮标题
- (void)setTitle:(NSString * _Nullable)title
        forState:(UIControlState)state
   forButtonType:(CatAttributedAlertButtonType)btnType;

/// 显示
- (void)showIn:(UIView * _Nullable)inView animated:(BOOL)animated;

/// 移除
- (void)dismissWithAnimated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
