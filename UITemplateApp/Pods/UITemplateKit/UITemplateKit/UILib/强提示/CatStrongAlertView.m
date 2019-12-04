//
//  CatStrongAlertView.m
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/8.
//  Copyright © 2019 gwh. All rights reserved.
//

#define kCatStrongAlertTitleColor RGBA(6, 18, 30, 1)
#define kCatStrongAlertContentColor RGBA(61, 68, 77, 1)
#define kCatStrongAlertCancelColor RGBA(140, 145, 152, 1)
#define kCatStrongAlertLineColor RGBA(238, 238, 238, 1)
#import "CatStrongAlertView.h"
#import "UIView+CCWebImage.h"

@interface CatStrongAlertView ()

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* content;
@property (nonatomic, strong) id bgImage;
@property (nonatomic, strong) NSString* cancelTitle;
@property (nonatomic, strong) NSString* confirmTitle;
@property (nonatomic, strong) UIImage* ticketImage;
@property (nonatomic, strong) NSString* ticketName;
@property (nonatomic, assign) CatStrongAlertTheme theme;
@property (nonatomic, assign) BOOL isShowCancel;

@property (nonatomic, strong) UIImageView* imageV;
@property (nonatomic, strong) UILabel* titleLb;
@property (nonatomic, strong) UIScrollView* contentScrollV;
@property (nonatomic, strong) UILabel* contentLb;
@property (nonatomic, strong) CC_Button* cancelBtn;
@property (nonatomic, strong) CC_Button* confirmBtn;
@property (nonatomic, strong) CC_Button* closeBtn;

@end
@implementation CatStrongAlertView

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content bgImage:(id)bgImage ticketImage:(UIImage *)ticketImage ticketName:(NSString *)ticketName cancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle theme:(CatStrongAlertTheme)theme isShowCancel:(BOOL)isShowCancel{
    if (self = [super init]) {
        
        self.title = title;
        self.content = content;
        self.bgImage = bgImage;
        self.cancelTitle = cancelTitle;
        self.confirmTitle = confirmTitle;
        self.ticketImage = ticketImage;
        self.ticketName = ticketName;
        self.theme = theme;
        self.isShowCancel = isShowCancel;
        
        [self setupConfig];
        [self setupViews];
        
        if ([bgImage isKindOfClass:[NSString class]]){
            [self.imageV cc_setImageWithURL:[NSURL URLWithString:(NSString*)bgImage]];
        }else if([bgImage isKindOfClass:[NSURL class]]){
            [self.imageV cc_setImageWithURL:(NSURL*)bgImage];
        }else if([bgImage isKindOfClass:[UIImage class]]){
            self.imageV.image = bgImage;
        }
    }
    return self;
}

- (void)setupConfig{
    WS(weakSelf);
    self.imageV = [[UIImageView alloc]init];
    [self addSubview:_imageV];
    self.titleLb = [[UILabel alloc]init];
    _titleLb.numberOfLines = 0;
    [self addSubview:_titleLb];
    self.contentScrollV = [[UIScrollView alloc]init];
    [self addSubview:_contentScrollV];
    self.contentLb = [[UILabel alloc]init];
    _contentLb.numberOfLines = 0;
    [_contentScrollV addSubview:_contentLb];
    self.cancelBtn = [[CC_Button alloc]init];
    [self addSubview:_cancelBtn];
    [_cancelBtn cc_tappedInterval:0.1 withBlock:^(id  _Nonnull view) {
        SS(strongSelf);
        [strongSelf.closeBtn removeFromSuperview];
        if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(catStrongAlertViewCancel:)]) {
            [strongSelf.delegate catStrongAlertViewCancel:strongSelf];
        }
    }];
    self.confirmBtn = [[CC_Button alloc]init];
    [self addSubview:_confirmBtn];
    [_confirmBtn cc_tappedInterval:0.1 withBlock:^(id  _Nonnull view) {
        SS(strongSelf);
        [strongSelf.closeBtn removeFromSuperview];
        if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(catStrongAlertViewConfirm:)]) {
            [strongSelf.delegate catStrongAlertViewConfirm:strongSelf];
        }
    }];
    self.closeBtn = [[CC_Button alloc]init];
    [_closeBtn cc_tappedInterval:0.1 withBlock:^(id  _Nonnull view) {
        SS(strongSelf);
        [strongSelf.closeBtn removeFromSuperview];
        if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(catStrongAlertViewClose:)]) {
            [strongSelf.delegate catStrongAlertViewClose:strongSelf];
        }
    }];
}

- (void)setupViews{
    self.backgroundColor = [UIColor whiteColor];
    switch (_theme) {
            //更新提示框-两个按钮在同一水平线上
        case CatStrongAlertThemeUpdateHorizontal :
        {
            if (_isShowCancel) {
                self.frame = CGRectMake((WIDTH()-RH(340.0f))/2.0, (HEIGHT()-RH(420.0f))/2.0, RH(340.0f), RH(420.0f));
                self.imageV.frame = CGRectMake(0, 0, self.width, RH(180.0f));
                //                _imageV.image = _bgImage;
                
                CGFloat titleHeight = [CatStrongAlertTool caculateLabelHeight:_title maxWidth:self.width-RH(60.0f) font:RF(22.0f)];
                self.titleLb.frame = CGRectMake(RH(30.0f), RH(30.0f), self.width-RH(60.0f), titleHeight);
                _titleLb.textColor = [UIColor whiteColor];
                _titleLb.font = RF(22.0f);
                _titleLb.text = _title;
                
                self.contentScrollV.frame = CGRectMake(0, _imageV.bottom+RH(40.0f), self.width, self.height-RH(240.0f+70.0f));
                CGFloat contentHeight = [CatStrongAlertTool caculateLabelHeight:_content maxWidth:self.width-RH(60.0f) font:RF(16.0f)];
                self.contentLb.frame = CGRectMake(RH(30.0f), RH(0.0f), self.width-RH(60.0f), contentHeight);
                _contentLb.text = _content;
                _contentLb.textColor = kCatStrongAlertContentColor;
                _contentLb.font = RF(16.0f);
                _contentScrollV.contentSize = CGSizeMake(self.width, contentHeight);
                
                self.cancelBtn.frame = CGRectMake(0, _contentScrollV.bottom+RH(30.0f), self.width/2.0, RH(60.0f));
                _cancelBtn.titleLabel.font = RF(17.0f);
                [_cancelBtn setTitleColor:kCatStrongAlertCancelColor forState:UIControlStateNormal];
                [_cancelBtn setTitle:_cancelTitle forState:UIControlStateNormal];
                
                self.confirmBtn.frame = CGRectMake(self.width/2.0, _contentScrollV.bottom+RH(30.0f), self.width/2.0, RH(60.0f));
                _confirmBtn.titleLabel.font = RF(17.0f);
                [_confirmBtn setTitleColor:kCatStrongAlertTitleColor forState:UIControlStateNormal];
                [_confirmBtn setTitle:_confirmTitle forState:UIControlStateNormal];
                
                //分割线
                UIView* horizontalLine = [[UIView alloc]initWithFrame:CGRectMake(0, _contentScrollV.bottom+RH(30.0f), self.width, RH(1.0f))];
                horizontalLine.backgroundColor = kCatStrongAlertLineColor;
                [self addSubview:horizontalLine];
                UIView* verticalityLine = [[UIView alloc]initWithFrame:CGRectMake(self.width/2.0-RH(0.5f), _contentScrollV.bottom+RH(30.0f), RH(1.0f), RH(60.0f))];
                verticalityLine.backgroundColor = kCatStrongAlertLineColor;
                [self addSubview:verticalityLine];
            }else{
                self.frame = CGRectMake((WIDTH()-RH(340.0f))/2.0, (HEIGHT()-RH(420.0f))/2.0, RH(340.0f), RH(420.0f));
                self.imageV.frame = CGRectMake(0, 0, self.width, RH(180.0f));
                //                _imageV.image = _bgImage;
                
                CGFloat titleHeight = [CatStrongAlertTool caculateLabelHeight:_title maxWidth:self.width-RH(60.0f) font:RF(22.0f)];
                self.titleLb.frame = CGRectMake(RH(30.0f), RH(30.0f), self.width-RH(60.0f), titleHeight);
                _titleLb.textColor = [UIColor whiteColor];
                _titleLb.font = RF(22.0f);
                _titleLb.text = _title;
                
                self.contentScrollV.frame = CGRectMake(0, _imageV.bottom+RH(40.0f), self.width, self.height-RH(240.0f+70.0f));
                CGFloat contentHeight = [CatStrongAlertTool caculateLabelHeight:_content maxWidth:self.width-RH(60.0f) font:RF(16.0f)];
                self.contentLb.frame = CGRectMake(RH(30.0f), RH(0.0f), self.width-RH(60.0f), contentHeight);
                _contentLb.text = _content;
                _contentLb.textColor = kCatStrongAlertContentColor;
                _contentLb.font = RF(16.0f);
                _contentScrollV.contentSize = CGSizeMake(self.width, contentHeight);
                
                self.confirmBtn.frame = CGRectMake(0, _contentScrollV.bottom+RH(30.0f), self.width, RH(60.0f));
                _confirmBtn.titleLabel.font = RF(17.0f);
                [_confirmBtn setTitleColor:kCatStrongAlertTitleColor forState:UIControlStateNormal];
                [_confirmBtn setTitle:_confirmTitle forState:UIControlStateNormal];
                
                //分割线
                UIView* horizontalLine = [[UIView alloc]initWithFrame:CGRectMake(0, _contentScrollV.bottom+RH(30.0f), self.width, RH(1.0f))];
                horizontalLine.backgroundColor = kCatStrongAlertLineColor;
                [self addSubview:horizontalLine];
            }
        }
            break;
            //更新提示框-两个按钮在同一垂直线上
        case CatStrongAlertThemeUpdateVerticality:
        {
            if(_isShowCancel){
                self.frame = CGRectMake((WIDTH()-RH(340.0f))/2.0, (HEIGHT()-RH(420.0f))/2.0, RH(340.0f), RH(420.0f));
                self.imageV.frame = CGRectMake(0, 0, self.width, RH(188.0f));
                //                _imageV.image = _bgImage;
                
                self.titleLb.frame = CGRectMake(RH(0.0f), RH(22.0f)+_imageV.bottom, self.width, RH(30.0f));
                _titleLb.textAlignment = NSTextAlignmentCenter;
                _titleLb.textColor = kCatStrongAlertTitleColor;
                _titleLb.font = RF(22.0f);
                _titleLb.text = _title;
                
                self.contentScrollV.frame = CGRectMake(0, _titleLb.bottom+RH(6.0f), self.width, self.height-RH(188.0f+108.0f+58.0f+20.0f));
                CGFloat contentHeight = [CatStrongAlertTool caculateLabelHeight:_content maxWidth:self.width-RH(40.0f) font:RF(16.0f)];
                self.contentLb.frame = CGRectMake(RH(20.0f), RH(0.0f), self.width-RH(40.0f), contentHeight);
                _contentLb.text = _content;
                _contentLb.textColor = kCatStrongAlertContentColor;
                _contentLb.font = RF(16.0f);
                _contentScrollV.contentSize = CGSizeMake(self.width, contentHeight);
                
                self.confirmBtn.frame = CGRectMake(0, _contentScrollV.bottom+20.0f, self.width, RH(54.0f));
                _confirmBtn.titleLabel.font = RF(17.0f);
                [_confirmBtn setTitleColor:kCatStrongAlertTitleColor forState:UIControlStateNormal];
                [_confirmBtn setTitle:_confirmTitle forState:UIControlStateNormal];
                
                self.cancelBtn.frame = CGRectMake(0, _confirmBtn.bottom, self.width, RH(54.0f));
                _cancelBtn.titleLabel.font = RF(17.0f);
                [_cancelBtn setTitleColor:kCatStrongAlertCancelColor forState:UIControlStateNormal];
                [_cancelBtn setTitle:_cancelTitle forState:UIControlStateNormal];
                
                //分割线
                UIView* horizontalLine1 = [[UIView alloc]initWithFrame:CGRectMake(0, _contentScrollV.bottom+20.0f, self.width, RH(1.0f))];
                horizontalLine1.backgroundColor = kCatStrongAlertLineColor;
                [self addSubview:horizontalLine1];
                UIView* horizontalLine2 = [[UIView alloc]initWithFrame:CGRectMake(0, _confirmBtn.bottom, self.width, RH(1.0f))];
                horizontalLine2.backgroundColor = kCatStrongAlertLineColor;
                [self addSubview:horizontalLine2];
            }else{
                self.frame = CGRectMake((WIDTH()-RH(340.0f))/2.0, (HEIGHT()-RH(360.0f))/2.0, RH(340.0f), RH(360.0f));
                self.imageV.frame = CGRectMake(0, 0, self.width, RH(188.0f));
                //                _imageV.image = _bgImage;
                
                self.titleLb.frame = CGRectMake(RH(0.0f), RH(22.0f)+_imageV.bottom, self.width, RH(30.0f));
                _titleLb.textAlignment = NSTextAlignmentCenter;
                _titleLb.textColor = kCatStrongAlertTitleColor;
                _titleLb.font = RF(22.0f);
                _titleLb.text = _title;
                
                self.contentScrollV.frame = CGRectMake(0, _titleLb.bottom+RH(6.0f), self.width, self.height-RH(188.0f+108.0f+58.0f+20.0f));
                CGFloat contentHeight = [CatStrongAlertTool caculateLabelHeight:_content maxWidth:self.width-RH(40.0f) font:RF(16.0f)];
                self.contentLb.frame = CGRectMake(RH(20.0f), RH(0.0f), self.width-RH(40.0f), contentHeight);
                _contentLb.text = _content;
                _contentLb.textColor = kCatStrongAlertContentColor;
                _contentLb.font = RF(16.0f);
                _contentScrollV.contentSize = CGSizeMake(self.width, contentHeight);
                
                self.confirmBtn.frame = CGRectMake(0, _contentScrollV.bottom+20.0f, self.width, RH(54.0f));
                _confirmBtn.titleLabel.font = RF(17.0f);
                [_confirmBtn setTitleColor:kCatStrongAlertTitleColor forState:UIControlStateNormal];
                [_confirmBtn setTitle:_confirmTitle forState:UIControlStateNormal];
                
                //分割线
                UIView* horizontalLine1 = [[UIView alloc]initWithFrame:CGRectMake(0, _contentScrollV.bottom+20.0f, self.width, RH(1.0f))];
                horizontalLine1.backgroundColor = kCatStrongAlertLineColor;
                [self addSubview:horizontalLine1];
            }
        }
            break;
            //跳转关注微博提示框
        case CatStrongAlertThemeGoToWeibo:
        {
            self.frame = CGRectMake((WIDTH()-RH(340.0f))/2.0, (HEIGHT()-RH(420.0f))/2.0, RH(340.0f), RH(420.0f));
            self.imageV.frame = CGRectMake(0, 0, self.width, RH(240.0f));
            //            _imageV.image = _bgImage;
            
            self.closeBtn.frame = CGRectMake(self.width-RH(36.0f+10.0f), RH(10.0f), RH(36.0f), RH(36.0f));
            [_closeBtn setImage:[UIImage imageNamed:@"weibo_Close"] forState:UIControlStateNormal];
            [self addSubview:_closeBtn];
            
            self.titleLb.frame = CGRectMake(RH(0.0f), RH(22.0f)+_imageV.bottom, self.width, RH(30.0f));
            _titleLb.textAlignment = NSTextAlignmentCenter;
            _titleLb.textColor = kCatStrongAlertTitleColor;
            _titleLb.font = RF(22.0f);
            _titleLb.text = _title;
            
            self.contentScrollV.frame = CGRectMake(0, _titleLb.bottom+RH(6.0f), self.width, self.height-RH(240.0f+60.0f+58.0f+20.0f));
            CGFloat contentHeight = [CatStrongAlertTool caculateLabelHeight:_content maxWidth:self.width-RH(40.0f) font:RF(16.0f)];
            self.contentLb.frame = CGRectMake(RH(20.0f), RH(0.0f), self.width-RH(40.0f), contentHeight);
            _contentLb.text = _content;
            _contentLb.textColor = kCatStrongAlertCancelColor;
            _contentLb.font = RF(16.0f);
            _contentScrollV.contentSize = CGSizeMake(self.width, contentHeight);
            
            self.cancelBtn.frame = CGRectMake(RH(20.0f), _contentScrollV.bottom+20.0f, (self.width-RH(60.0f))/2.0, RH(40.0f));
            _cancelBtn.titleLabel.font = RF(14.0f);
            [_cancelBtn setTitleColor:kCatStrongAlertCancelColor forState:UIControlStateNormal];
            [_cancelBtn setTitle:_cancelTitle forState:UIControlStateNormal];
            
            self.confirmBtn.frame = CGRectMake(_cancelBtn.right+RH(20.0f), _contentScrollV.bottom+20.0f, (self.width-RH(60.0f))/2.0, RH(40.0f));
            _confirmBtn.titleLabel.font = RF(14.0f);
            [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _confirmBtn.backgroundColor = kCatStrongAlertContentColor;
            [_confirmBtn setTitle:_confirmTitle forState:UIControlStateNormal];
            
            _cancelBtn.layer.cornerRadius = RH(4.0f);
            _cancelBtn.layer.borderColor = kCatStrongAlertCancelColor.CGColor;
            _cancelBtn.layer.borderWidth = RH(1.0f);
            _cancelBtn.layer.masksToBounds = YES;
            [self drawCorners:_confirmBtn];
        }
            break;
            //鼓励提示框-两个按钮在同一水平线上
        case CatStrongAlertThemeCheerUpHorizontal:
        {
            self.frame = CGRectMake((WIDTH()-RH(260.0f))/2.0, (HEIGHT()-RH(300.0f))/2.0, RH(260.0f), RH(300.0f));
            self.imageV.frame = CGRectMake(0, 0, self.width, RH(188.0f));
            //            _imageV.image = _bgImage;
            
            self.titleLb.frame = CGRectMake(RH(20.0f), _imageV.bottom, self.width-RH(40.0F), RH(64.0f));
            _titleLb.textColor = kCatStrongAlertContentColor;
            _titleLb.textAlignment = NSTextAlignmentCenter;
            _titleLb.textColor = kCatStrongAlertTitleColor;
            _titleLb.font = RF(17.0f);
            _titleLb.text = _title;
            
            self.cancelBtn.frame = CGRectMake(0, _titleLb.bottom, self.width/2.0f, RH(48.0f));
            _cancelBtn.titleLabel.font = RF(12.0f);
            [_cancelBtn setTitleColor:RGBA(189, 196, 206, 1) forState:UIControlStateNormal];
            [_cancelBtn setTitle:_cancelTitle forState:UIControlStateNormal];
            
            self.confirmBtn.frame = CGRectMake(_cancelBtn.right, _titleLb.bottom, self.width/2.0, RH(48.0f));
            _confirmBtn.titleLabel.font = RF(12.0f);
            [_confirmBtn setTitleColor:kCatStrongAlertTitleColor forState:UIControlStateNormal];
            [_confirmBtn setTitle:_confirmTitle forState:UIControlStateNormal];
            
            //分割线
            UIView* horizontalLine = [[UIView alloc]initWithFrame:CGRectMake(0, _titleLb.bottom, self.width, RH(1.0f))];
            horizontalLine.backgroundColor = kCatStrongAlertLineColor;
            [self addSubview:horizontalLine];
            UIView* verticalityLine = [[UIView alloc]initWithFrame:CGRectMake(self.width/2.0-RH(0.5f), _titleLb.bottom, RH(1.0f), self.height-_titleLb.bottom)];
            verticalityLine.backgroundColor = kCatStrongAlertLineColor;
            [self addSubview:verticalityLine];
        }
            break;
            //鼓励提示框-两个按钮在同一垂直线上
        case CatStrongAlertThemeCheerUpVerticality:
        {
            self.frame = CGRectMake((WIDTH()-RH(260.0f))/2.0, (HEIGHT()-RH(300.0f))/2.0, RH(260.0f), RH(300.0f));
            self.imageV.frame = CGRectMake(RH(10.0f), RH(48.0f), self.width-RH(20.0f), RH(160.0f));
            //            _imageV.image = _bgImage;
            [self drawCorners:_imageV];
            
            self.titleLb.frame = CGRectMake(RH(0.0f), RH(0.0f), self.width, RH(48.0f));
            _titleLb.textColor = [UIColor whiteColor];
            _titleLb.textAlignment = NSTextAlignmentCenter;
            _titleLb.textColor = kCatStrongAlertTitleColor;
            _titleLb.font = RF(22.0f);
            _titleLb.text = _title;
            
            self.confirmBtn.frame = CGRectMake(RH(10.0f), _imageV.bottom+RH(10.0f), self.width-RH(20.0f), RH(32.0f));
            _confirmBtn.titleLabel.font = RF(12.0f);
            [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _confirmBtn.backgroundColor = kCatStrongAlertContentColor;
            [_confirmBtn setTitle:_confirmTitle forState:UIControlStateNormal];
            
            self.cancelBtn.frame = CGRectMake(RH(10.0f), _confirmBtn.bottom+RH(10.0f), self.width-RH(20.0f), RH(32.0f));
            _cancelBtn.titleLabel.font = RF(12.0f);
            [_cancelBtn setTitleColor:RGBA(91, 94, 99, 1) forState:UIControlStateNormal];
            _cancelBtn.backgroundColor = RGBA(238, 238, 238, 1);
            [_cancelBtn setTitle:_cancelTitle forState:UIControlStateNormal];
            
            [self drawCorners:_cancelBtn];
            [self drawCorners:_confirmBtn];
        }
            break;
            //成为会员提示框
        case CatStrongAlertThemeVip:
        {
            self.frame = CGRectMake((WIDTH()-RH(340.0f))/2.0, (HEIGHT()-RH(420.0f))/2.0, RH(340.0f), RH(420.0f));
            self.imageV.frame = CGRectMake(0, 0, self.width, RH(200.0f));
            //            _imageV.image = _bgImage;
            
            self.titleLb.frame = CGRectMake(RH(20.0f), _imageV.bottom+RH(10.0f), self.width-RH(40.0f), RH(22.0f));
            _titleLb.textColor = kCatStrongAlertContentColor;
            _titleLb.textAlignment = NSTextAlignmentCenter;
            _titleLb.font = RF(16.0f);
            _titleLb.text = _title;
            
            self.contentScrollV.frame = CGRectMake(0, _titleLb.bottom+RH(6.0f), self.width, self.height-RH(200.0f+38.0f+98.0f+48.0f));
            CGFloat contentHeight = [CatStrongAlertTool caculateLabelHeight:_content maxWidth:self.width-RH(40.0f) font:RF(16.0f)];
            self.contentLb.frame = CGRectMake(RH(20.0f), RH(0.0f), self.width-RH(40.0f), contentHeight);
            _contentLb.text = _content;
            _contentLb.textAlignment = NSTextAlignmentCenter;
            _contentLb.textColor = kCatStrongAlertContentColor;
            _contentLb.font = RF(16.0f);
            _contentScrollV.contentSize = CGSizeMake(self.width, contentHeight);
            
            UIImageView* ticketImgV = [[UIImageView alloc]initWithFrame:CGRectMake(self.width/2.0-RH(24.0f), _contentScrollV.bottom+RH(12.0f), RH(48.0f), RH(48.0f))];
            ticketImgV.image = _ticketImage;
            [self addSubview:ticketImgV];
            UILabel* ticketLb = [[UILabel alloc]initWithFrame:CGRectMake(0, ticketImgV.bottom, self.width, RH(24.0f))];
            ticketLb.font = RF(18.0f);
            ticketLb.text = _ticketName;
            ticketLb.textAlignment = NSTextAlignmentCenter;
            ticketLb.textColor = kCatStrongAlertContentColor;
            [self addSubview:ticketLb];
            
            self.cancelBtn.frame = CGRectMake(0, ticketLb.bottom+RH(16.0f), self.width/2.0, self.height-ticketLb.bottom-RH(16.0f));
            _cancelBtn.titleLabel.font = RF(17.0f);
            [_cancelBtn setTitleColor:RGBA(91, 94, 99, 1) forState:UIControlStateNormal];
            [_cancelBtn setTitle:_cancelTitle forState:UIControlStateNormal];
            
            self.confirmBtn.frame = CGRectMake(self.width/2.0, ticketLb.bottom+RH(16.0f), self.width/2.0, self.height-ticketLb.bottom-RH(16.0f));
            _confirmBtn.titleLabel.font = RF(17.0f);
            [_confirmBtn setTitleColor:kCatStrongAlertContentColor forState:UIControlStateNormal];
            [_confirmBtn setTitle:_confirmTitle forState:UIControlStateNormal];
            
            //分割线
            UIView* horizontalLine = [[UIView alloc]initWithFrame:CGRectMake(0, ticketLb.bottom+RH(16.0f), self.width, RH(1.0f))];
            horizontalLine.backgroundColor = kCatStrongAlertLineColor;
            [self addSubview:horizontalLine];
            UIView* verticalityLine = [[UIView alloc]initWithFrame:CGRectMake(self.width/2.0-RH(0.5f), horizontalLine.bottom, RH(1.0f), self.height-horizontalLine.bottom)];
            verticalityLine.backgroundColor = kCatStrongAlertLineColor;
            [self addSubview:verticalityLine];
        }
            break;
        default:
            break;
    }
    
    [self drawCorners:self];
    if (_theme == CatStrongAlertThemeCheerUpHorizontal) {
        self.closeBtn.frame = CGRectMake(self.width-RH(14.0f)+(WIDTH()-self.width)/2.0, (HEIGHT()-self.height)/2.0-RH(14.0f), RH(28.0f), RH(28.0f));
        [_closeBtn setImage:[UIImage imageNamed:@"cheerup_Close"] forState:UIControlStateNormal];
        UIWindow* keyWindow = [UIApplication sharedApplication].keyWindow;
        [keyWindow addSubview:_closeBtn];
    }
}

-(void)drawCorners:(UIView*)view{
    //绘制圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:RH(6.0f)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}
@end
