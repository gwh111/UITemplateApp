//
//  CatDefaultPop.m
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/13.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CatDefaultPop.h"

@interface CatDefaultPop ()<CatDefaultPopViewDelegate>

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* content;
@property (nonatomic, strong) NSString* cancelTitle;
@property (nonatomic, strong) NSString* confirmTitle;
@property (nonatomic, assign) BOOL isSingle;

@property (nonatomic, strong) UIView* maskView;//蒙版

@end

@implementation CatDefaultPop

-(instancetype)initWithTitle:(NSString *)title content:(NSString *)content cancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle{
    if (self = [super init]) {
        self.title = title;
        self.content = content;
        self.cancelTitle = cancelTitle;
        self.confirmTitle = confirmTitle;
        self.isSingle = NO;
    }
    return self;
}
-(instancetype)initWithTitle:(NSString *)title content:(NSString *)content confirmTitle:(NSString *)confirmTitle{
    if (self = [super init]) {
        self.title = title;
        self.content = content;
        self.confirmTitle = confirmTitle;
        self.isSingle = YES;
    }
    return self;
}

-(void)popUpCatDefaultPopView{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    self.maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(), HEIGHT())];
    _maskView.backgroundColor = RGBA(51, 51, 51, 0.5);
    _maskView.alpha = 0.0f;
    [window addSubview:_maskView];
    
    if(_isSingle){
        self.popView = [[CatDefaultPopView alloc]initWithTitle:_title content:_content confirmTitle:_confirmTitle];
    }else{
        self.popView = [[CatDefaultPopView alloc]initWithTitle:_title content:_content cancelTitle:_cancelTitle confirmTitle:_confirmTitle];
    }
    _popView.delegate = self;
    [_maskView addSubview:_popView];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 1.0f;
        self.popView.transform = CGAffineTransformScale(self.popView.transform, 1.2f, 1.2f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.popView.transform = CGAffineTransformIdentity;
        }];
    }];
}

-(void)dismissCatDefaultPopView{
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0.0f;
        self.popView.transform = CGAffineTransformScale(self.popView.transform, 0.1, 0.1);
    } completion:^(BOOL finished) {
        [self.popView removeFromSuperview];
        self.popView = nil;
        [self.maskView removeFromSuperview];
        self.maskView = nil;
    }];
}

-(void)updateCancelColor:(UIColor *)cancelColor confirmColor:(UIColor *)confimColor{
    [_popView updateCancelColor:cancelColor confirmColor:confimColor];
}

#pragma mark - delegates
-(void)catDefaultPopViewCancel:(CatDefaultPop *)defaultPopView{
    if (_delegate && [_delegate respondsToSelector:@selector(catDefaultPopCancel:)]) {
        [_delegate catDefaultPopCancel:self];
    }
    [self dismissCatDefaultPopView];
}

-(void)catDefaultPopViewConfirm:(CatDefaultPop *)defaultPopView{
    if (_delegate && [_delegate respondsToSelector:@selector(catDefaultPopConfirm:)]) {
        [_delegate catDefaultPopConfirm:self];
    }
    [self dismissCatDefaultPopView];
}
@end
