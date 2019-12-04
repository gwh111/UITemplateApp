//
//  CatStrongAlert.m
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/7.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CatStrongAlert.h"

@interface CatStrongAlert ()<CatStrongAlertViewDelegate>

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* content;
@property (nonatomic, strong) id bgImage;
@property (nonatomic, strong) NSString* cancelTitle;
@property (nonatomic, strong) NSString* confirmTitle;
@property (nonatomic, strong) UIImage* ticketImage;
@property (nonatomic, strong) NSString* ticketName;
@property (nonatomic, assign) CatStrongAlertTheme theme;
@property (nonatomic, assign) BOOL isShowCancel;

@property (nonatomic, strong) UIView* maskView;//蒙版
@property (nonatomic, strong) CatStrongAlertView* alertView;

@end

@implementation CatStrongAlert

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content bgImage:(id)bgImage cancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle type:(CatStrongAlertUpdateType)type isShowCancel:(BOOL)isShowCancel{
    if (self = [super init]) {
        self.title = title;
        self.content = content;
        self.bgImage = bgImage;
        self.cancelTitle = cancelTitle;
        self.confirmTitle = confirmTitle;
        self.isShowCancel = isShowCancel;
        self.theme = (type == CatStrongAlertUpdateHorizontal) ? CatStrongAlertThemeUpdateHorizontal:CatStrongAlertThemeUpdateVerticality;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content bgImage:(id)bgImage cancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle{
    if (self = [super init]) {
        self.title = title;
        self.content = content;
        self.bgImage = bgImage;
        self.cancelTitle = cancelTitle;
        self.confirmTitle = confirmTitle;
        self.theme = CatStrongAlertThemeGoToWeibo;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title bgImage:(id)bgImage cancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle type:(CatStrongAlertCheerUpType)type{
    if (self = [super init]) {
        self.title = title;
        self.bgImage = bgImage;
        self.cancelTitle = cancelTitle;
        self.confirmTitle = confirmTitle;
        self.theme = type == CatStrongAlertCheerUpHorizontal ? CatStrongAlertThemeCheerUpHorizontal:CatStrongAlertThemeCheerUpVerticality;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content bgImage:(id)bgImage ticketImage:(UIImage *)ticketImage ticketName:(NSString *)ticketName cancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle{
    if (self = [super init]) {
        self.title = title;
        self.content = content;
        self.bgImage = bgImage;
        self.cancelTitle = cancelTitle;
        self.confirmTitle = confirmTitle;
        self.ticketImage = ticketImage;
        self.ticketName = ticketName;
        self.theme = CatStrongAlertThemeVip;
    }
    return self;
}

-(void)popUpCatAlertStrongView{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    self.maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(), HEIGHT())];
    _maskView.backgroundColor = RGBA(51, 51, 51, 0.5);
    _maskView.alpha = 0.0f;
    [window addSubview:_maskView];
    
    self.alertView = [[CatStrongAlertView alloc]initWithTitle:_title content:_content bgImage:_bgImage ticketImage:_ticketImage ticketName:_ticketName cancelTitle:_cancelTitle confirmTitle:_confirmTitle theme:_theme isShowCancel:_isShowCancel];
    _alertView.delegate = self;
    [_maskView addSubview:_alertView];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 1.0f;
        self.alertView.transform = CGAffineTransformScale(self.alertView.transform, 1.2f, 1.2f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.alertView.transform = CGAffineTransformIdentity;
        }];
    }];
}

-(void)dismissCatAlertStrongView{
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0.0f;
        self.alertView.transform = CGAffineTransformScale(self.alertView.transform, 0.1, 0.1);
    } completion:^(BOOL finished) {
        [self.alertView removeFromSuperview];
        self.alertView = nil;
        [self.maskView removeFromSuperview];
        self.maskView = nil;
    }];
}


#pragma mark - delegates
-(void)catStrongAlertViewCancel:(CatStrongAlertView *)alertView{
    [self dismissCatAlertStrongView];
    if (_delegate && [_delegate respondsToSelector:@selector(catStrongAlertCancel:)]) {
        [_delegate catStrongAlertCancel:self];
    }
}
-(void)catStrongAlertViewConfirm:(CatStrongAlertView *)alertView{
    if (_isShowCancel) {
        [self dismissCatAlertStrongView];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(catStrongAlertConfirm:)]) {
        [_delegate catStrongAlertConfirm:self];
    }
}
-(void)catStrongAlertViewClose:(CatStrongAlertView *)alertView{
    [self dismissCatAlertStrongView];
    if (_delegate && [_delegate respondsToSelector:@selector(catStrongAlertClose:)]) {
        [_delegate catStrongAlertClose:self];
    }
}
#pragma mark - properties

@end
