//
//  CatCitySelect.m
//  UITemplateKit
//
//  Created by 路飞 on 2019/5/28.
//  Copyright © 2019 路飞. All rights reserved.
//

#import "CatCitySelect.h"

@interface CatCitySelect ()<CatCitySelectViewDelegate>

@property (nonatomic, strong) UIView* maskView;//蒙版
@property (nonatomic, strong) CatCitySelectView* citySelectView;

@end

@implementation CatCitySelect

-(void)popUpCatCitySelectView{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    self.maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(), HEIGHT())];
    _maskView.backgroundColor = RGBA(51, 51, 51, 0.5);
    _maskView.alpha = 0.0f;
    _maskView.userInteractionEnabled = YES;
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissCatCitySelectView)];
    [_maskView addGestureRecognizer:tap];
    [window addSubview:_maskView];
    
    self.citySelectView = [[CatCitySelectView alloc]init];
    _citySelectView.delegate = self;
    [window addSubview:_citySelectView];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 1.0f;
        self.citySelectView.alpha = 1.0f;
        self.citySelectView.frame = CGRectMake(0, HEIGHT()-kCatCitySelectViewHeight, WIDTH(), kCatCitySelectViewHeight);
    }];
}

-(void)dismissCatCitySelectView{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0.0f;
        self.citySelectView.alpha = 0.0f;
        self.citySelectView.frame = CGRectMake(0, HEIGHT(), WIDTH(), kCatCitySelectViewHeight);
    } completion:^(BOOL finished) {
        [self.citySelectView removeFromSuperview];
        self.citySelectView = nil;
        [self.maskView removeFromSuperview];
        self.maskView = nil;
    }];
}

#pragma mark - delegate
-(void)catCitySelectViewCancel:(CatCitySelectView *)citySelectView{
    if (_delegate && [_delegate respondsToSelector:@selector(catCitySelectCancel:)]) {
        [_delegate catCitySelectCancel:self];
    }
    [self dismissCatCitySelectView];
}

-(void)catCitySelectViewConfirm:(CatCitySelectView *)citySelectView selectProvince:(NSString *)selectProvince selectCity:(NSString *)selectCity selectDistrict:(NSString *)selectDistrict{
    if (_delegate && [_delegate respondsToSelector:@selector(catCitySelectConfirm:selectProvince:selectCity:selectDistrict:)]) {
        [_delegate catCitySelectConfirm:self selectProvince:selectProvince selectCity:selectCity selectDistrict:selectDistrict];
    }
    [self dismissCatCitySelectView];
}

@end
