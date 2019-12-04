//
//  CatCommonSelect.m
//  UITemplateKit
//
//  Created by 路飞 on 2019/5/30.
//  Copyright © 2019 路飞. All rights reserved.
//

#import "CatCommonSelect.h"

@interface CatCommonSelect ()<CatCommonSelectViewDelegate>

@property (nonatomic, copy) NSString* cancelTitle;
@property (nonatomic, copy) NSString* confirmTitle;
@property (nonatomic, copy) NSArray* dataArr;

@property (nonatomic, strong) UIView* maskView;//蒙版
@property (nonatomic, strong) CatCommonSelectView* commonSelectView;

@end

@implementation CatCommonSelect

- (instancetype)initWithCancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle dataArr:(nonnull NSArray<NSString *> *)dataArr{
    if (self = [super init]) {
        self.cancelTitle = cancelTitle;
        self.confirmTitle = confirmTitle;
        self.dataArr = dataArr;
        self.selectIndex=0;
    }
    return self;
}

- (void)popUpCatCommonSelectView{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    self.maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(), HEIGHT())];
    _maskView.backgroundColor = RGBA(51, 51, 51, 0.5);
    _maskView.alpha = 0.0f;
    _maskView.userInteractionEnabled = YES;
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissCatCommonSelectView)];
    [_maskView addGestureRecognizer:tap];
    [window addSubview:_maskView];
    
    self.commonSelectView = [[CatCommonSelectView alloc]initWithCancelTitle:_cancelTitle confirmTitle:_confirmTitle dataArr:_dataArr selectContentColor:_selectContentColor unSelectContentColor:_unSelectContentColor selectBarColor:_selectBarColor selectIndex:_selectIndex];
    _commonSelectView.delegate = self;
    [window addSubview:_commonSelectView];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 1.0f;
        self.commonSelectView.alpha = 1.0f;
        self.commonSelectView.frame = CGRectMake(0, HEIGHT()-kCatCommonSelectViewHeight, WIDTH(), kCatCommonSelectViewHeight);
    }];
}

- (void)dismissCatCommonSelectView{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0.0f;
        self.commonSelectView.alpha = 0.0f;
        self.commonSelectView.frame = CGRectMake(0, HEIGHT(), WIDTH(), kCatCommonSelectViewHeight);
    } completion:^(BOOL finished) {
        [self.commonSelectView removeFromSuperview];
        self.commonSelectView = nil;
        [self.maskView removeFromSuperview];
        self.maskView = nil;
    }];
}

#pragma mark - delegate
- (void)catCommonSelectViewCancel:(CatCommonSelectView *)commonSelectView{
    if (_delegate && [_delegate respondsToSelector:@selector(catCommonSelectCancel:)]) {
        [_delegate catCommonSelectCancel:self];
    }
    [self dismissCatCommonSelectView];
}

- (void)catCommonSelectViewConfirm:(CatCommonSelectView *)commonSelectView selectData:(NSString *)selectData{
    if (_delegate && [_delegate respondsToSelector:@selector(catCommonSelectConfirm:selectData:)]) {
        [_delegate catCommonSelectConfirm:self selectData:selectData];
    }
    [self dismissCatCommonSelectView];
}

- (void)catCommonSelectViewConfirm:(CatCommonSelectView *)commonSelectView selectData:(NSString *)selectData index:(NSInteger)index{
    if (_delegate && [_delegate respondsToSelector:@selector(catCommonSelectConfirm:selectData:index:)]) {
        [_delegate catCommonSelectConfirm:self selectData:selectData index:index];
    }
    [self dismissCatCommonSelectView];
}
@end
