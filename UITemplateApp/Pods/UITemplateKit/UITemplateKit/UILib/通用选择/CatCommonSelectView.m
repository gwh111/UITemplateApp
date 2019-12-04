//
//  CatCommonSelectView.m
//  UITemplateKit
//
//  Created by 路飞 on 2019/5/30.
//  Copyright © 2019 路飞. All rights reserved.
//

#import "CatCommonSelectView.h"

@interface CatCommonSelectView ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) NSString* cancelTitle;
@property (nonatomic, strong) NSString* confirmTitle;
@property (nonatomic, copy) NSArray* dataArr;
@property (nonatomic, assign) NSInteger selectIndex;
//选中文字颜色
@property (nonatomic, strong) UIColor* selectContentColor;
//未选中文字颜色
@property (nonatomic, strong) UIColor* unSelectContentColor;
//选中背景条颜色
@property (nonatomic, strong) UIColor* selectBarColor;

//当前选择的背景块
@property (nonatomic, strong) UIView* backCurrentView;
@property (nonatomic, strong) CC_Button* cancelBtn;
@property (nonatomic, strong) CC_Button* confirmBtn;
@property (nonatomic, strong) UIPickerView* pickerView;
@end

@implementation CatCommonSelectView

- (instancetype)initWithCancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle dataArr:(NSArray<NSDictionary *> *)dataArr selectContentColor:(nullable UIColor *)selectContentColor unSelectContentColor:(nullable UIColor *)unSelectContentColor selectBarColor:(nullable UIColor *)selectBarColor selectIndex:(NSInteger)selectIndex{
    if (self = [super init]) {
        self.cancelTitle = cancelTitle;
        self.confirmTitle = confirmTitle;
        self.dataArr = dataArr;
        self.selectContentColor = selectContentColor?selectContentColor:RGBA(36, 151, 235,1);
        self.unSelectContentColor = unSelectContentColor?unSelectContentColor:RGBA(51, 51, 51, 1);
        self.selectBarColor = selectBarColor?selectBarColor:RGBA(248, 248, 248, 1);
        self.selectIndex = selectIndex<dataArr.count?selectIndex:0;
        [self baseConfig];
        [self setupViews];
    }
    return self;
}


- (void)baseConfig{
    
}

- (void)setupViews{
    self.backgroundColor = [UIColor whiteColor];
    self.frame = CGRectMake(0, HEIGHT(), WIDTH(), kCatCommonSelectViewHeight);
    
    self.backCurrentView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height/2.0, self.width, RH(46.0f))];
    _backCurrentView.backgroundColor = _selectBarColor;
    [self addSubview:_backCurrentView];
    
    WS(weakSelf);
    self.cancelBtn = [[CC_Button alloc]initWithFrame:CGRectMake(0, 0, self.width/2.0, RH(50.0f))];
    [_cancelBtn setTitle:_cancelTitle forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:RGBA(167, 164, 164, 1) forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = RF(16.0f);
    [self addSubview:_cancelBtn];
    [_cancelBtn cc_tappedInterval:0.1 withBlock:^(id  _Nonnull view) {
        SS(strongSelf);
        if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(catCommonSelectViewCancel:)]) {
            [strongSelf.delegate catCommonSelectViewCancel:strongSelf];
        }
    }];
    self.confirmBtn = [[CC_Button alloc]initWithFrame:CGRectMake(self.width/2.0, 0, self.width/2.0, RH(50.0f))];
    [_confirmBtn setTitle:_confirmTitle forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    _confirmBtn.titleLabel.font = RF(16.0f);
    [self addSubview:_confirmBtn];
    [_confirmBtn cc_tappedInterval:0.1 withBlock:^(id  _Nonnull view) {
        SS(strongSelf);
        
        if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(catCommonSelectViewConfirm:selectData:)]) {
            [strongSelf.delegate catCommonSelectViewConfirm:strongSelf selectData:strongSelf.dataArr[strongSelf.selectIndex]];
        }
        
        if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(catCommonSelectViewConfirm:selectData:index:)]) {
            [strongSelf.delegate catCommonSelectViewConfirm:strongSelf selectData:strongSelf.dataArr[strongSelf.selectIndex] index:strongSelf.selectIndex];
        }
    }];
    //pickerView
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, _cancelBtn.bottom, WIDTH(), RH(178.0f))];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    [self addSubview:_pickerView];
    
    [_pickerView selectRow:_selectIndex inComponent:0 animated:NO];
    
    //分割线
    UIView* horizontalLine1 = [[UIView alloc]initWithFrame:CGRectMake(0, _cancelBtn.bottom, self.width, RH(4.0f))];
    horizontalLine1.backgroundColor = RGBA(248, 248, 248, 1);
    [self addSubview:horizontalLine1];
    UIView* horizontalLine2 = [[UIView alloc]initWithFrame:CGRectMake(self.width/2.0-RH(0.5f), 0, RH(1.0f), RH(50.0f))];
    horizontalLine2.backgroundColor = RGBA(248, 248, 248, 1);
    [self addSubview:horizontalLine2];
}
#pragma mark - delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _dataArr.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _dataArr[row];
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return RH(46.0f);
}

//自定义每个pickview的label
-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel) {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setFont:RF(22.0f)];
    }
    pickerLabel.text = _dataArr[row];
    
    if (component == 0) {
        if (row == _selectIndex) {
            pickerLabel.textColor = _selectContentColor;
        } else {
            pickerLabel.textColor = _unSelectContentColor;
        }
    }
    return pickerLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectIndex = row;
    [pickerView reloadComponent:component];
}
@end
