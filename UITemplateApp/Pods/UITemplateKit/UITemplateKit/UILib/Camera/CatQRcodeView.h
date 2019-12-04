//
//  CatQRcodeView.h
//  UITemplateKit
//
//  Created by ml on 2019/10/30.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CatQRcodeView;

@protocol CatQRcodeViewDelegate <NSObject>

/// 点击我的二维码回调
- (void)qrcodeView:(CatQRcodeView *)qrcodeView showMyQRcode:(UILabel *)sender;

@end

@interface CatQRcodeView : UIView

@property (nonatomic,weak) id<CatQRcodeViewDelegate> delegate;

@property (nonatomic,strong,readonly) UIView *coverView;

@property (nonatomic,strong,readonly) UIImageView *effectAreaImageView;

@property (nonatomic,strong,readonly) UIImageView *shockwaveImageView;

@property (nonatomic,strong,readonly) UIButton *flashLightButton;

@property (nonatomic,strong,readonly) UILabel *qrcodeLabel;

/// 我的二维码
@property (nonatomic,strong,readonly) UILabel *myQRcodeLabel;

- (instancetype)initWithFrame:(CGRect)frame
                effectiveArea:(CGRect)visibleArea;

@end

NS_ASSUME_NONNULL_END
