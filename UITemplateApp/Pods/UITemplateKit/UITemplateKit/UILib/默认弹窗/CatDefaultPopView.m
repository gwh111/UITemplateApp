//
//  CatDefaultPopView.m
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/13.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CatDefaultPopView.h"

@interface CatDefaultPopView ()

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* content;
@property (nonatomic, strong) NSString* cancelTitle;
@property (nonatomic, strong) NSString* confirmTitle;

@property (nonatomic, strong) UILabel* titleLb;
@property (nonatomic, strong) CC_Button* cancelBtn;
@property (nonatomic, strong) CC_Button* confirmBtn;

@end

@implementation CatDefaultPopView

-(instancetype)initWithTitle:(NSString *)title content:(NSString *)content cancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle{
    if (self = [super init]) {
        self.title = title;
        self.content = content;
        self.cancelTitle = cancelTitle;
        self.confirmTitle = confirmTitle;
        [self setupViews:NO];
    }
    return self;
}

-(instancetype)initWithTitle:(NSString *)title content:(NSString *)content confirmTitle:(NSString *)confirmTitle{
    if (self = [super init]) {
        self.title = title;
        self.content = content;
        self.confirmTitle = confirmTitle;
        [self setupViews:YES];
    }
    return self;
}

-(void)setupViews:(BOOL)isSingle{
    self.backgroundColor = [UIColor whiteColor];
    WS(weakSelf);
    self.titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, RH(268.0f), RH(40.0f))];
    _titleLb.font = RF(19.0f);
    _titleLb.textAlignment = NSTextAlignmentCenter;
    _titleLb.textColor = RGBA(153, 153, 153, 1);
    _titleLb.text = _title;
    [self addSubview:_titleLb];
    
    CGFloat contentHeight = [_content boundingRectWithSize:CGSizeMake(RH(268.0-32.0f), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:RF(16.0f)} context:nil].size.height;
    
    self.contentLb = [[UILabel alloc]initWithFrame:CGRectMake(RH(16.0f), _titleLb.bottom+RH(8.0f), RH(268.0-32.0f), contentHeight)];
    _contentLb.textColor = RGBA(51, 51, 51, 1);
    _contentLb.text = _content;
    _contentLb.font = RF(16.0f);
    if (contentHeight >= RH(20.0f)) {
        _contentLb.textAlignment =NSTextAlignmentLeft;
    }else{
        _contentLb.textAlignment =NSTextAlignmentCenter;
    }
    _contentLb.numberOfLines = 0;
    [self addSubview:_contentLb];
    
    if (isSingle) {
        self.confirmBtn = [[CC_Button alloc]initWithFrame:CGRectMake(0, _contentLb.bottom+RH(16.0f), RH(268.0f), RH(46.0f))];
        [_confirmBtn setTitle:_confirmTitle forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:RGBA(36, 151, 235, 1) forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = RF(15.0f);
        [self addSubview:_confirmBtn];
        [_confirmBtn cc_tappedInterval:0.1 withBlock:^(id  _Nonnull view) {
            SS(strongSelf);
            if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(catDefaultPopViewConfirm:)]) {
                [strongSelf.delegate catDefaultPopViewConfirm:strongSelf];
            }
        }];
    }else{
        self.cancelBtn = [[CC_Button alloc]initWithFrame:CGRectMake(0, _contentLb.bottom+RH(16.0f), RH(134.0f), RH(46.0f))];
        [_cancelBtn setTitle:_cancelTitle forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:RGBA(153, 153, 153, 1) forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = RF(15.0f);
        [self addSubview:_cancelBtn];
        [_cancelBtn cc_tappedInterval:0.1 withBlock:^(id  _Nonnull view) {
            SS(strongSelf);
            if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(catDefaultPopViewCancel:)]) {
                [strongSelf.delegate catDefaultPopViewCancel:strongSelf];
            }
        }];
        self.confirmBtn = [[CC_Button alloc]initWithFrame:CGRectMake(RH(134.0f), _contentLb.bottom+RH(16.0f), RH(134.0f), RH(46.0f))];
        [_confirmBtn setTitle:_confirmTitle forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:RGBA(36, 151, 235, 1) forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = RF(15.0f);
        [self addSubview:_confirmBtn];
        [_confirmBtn cc_tappedInterval:0.1 withBlock:^(id  _Nonnull view) {
            SS(strongSelf);
            if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(catDefaultPopViewConfirm:)]) {
                [strongSelf.delegate catDefaultPopViewConfirm:strongSelf];
            }
        }];
    }
    
    //分割线
    UIView* horizontalLine1 = [[UIView alloc]initWithFrame:CGRectMake(0, _contentLb.bottom+RH(16.0f), RH(268.0f), RH(1.0f))];
    horizontalLine1.backgroundColor = RGBA(229, 229, 232, 1);
    [self addSubview:horizontalLine1];
    if (!isSingle) {
        UIView* horizontalLine2 = [[UIView alloc]initWithFrame:CGRectMake(RH(133.5f), _contentLb.bottom+RH(16.0f), RH(1.0f), RH(50.0f))];
        horizontalLine2.backgroundColor = RGBA(229, 229, 232, 1);
        [self addSubview:horizontalLine2];
    }
    
    self.frame = CGRectMake((WIDTH()-RH(268.0f))/2.0, (HEIGHT()-RH(48.0+8.0+16.0+46.0f)-contentHeight)/2.0, RH(268.0f), RH(40.0+8.0+16.0+46.0f)+contentHeight);
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:RH(6.0f)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

-(void)updateCancelColor:(UIColor *)cancelColor confirmColor:(UIColor *)confimColor{
    [self.cancelBtn setTitleColor:cancelColor forState:UIControlStateNormal];
    [self.confirmBtn setTitleColor:confimColor forState:UIControlStateNormal];
}

@end
