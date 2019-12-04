//
//  CatCommonPickerView.m
//  UITemplateKit
//
//  Created by ml on 2019/7/18.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatCommonPickerView.h"
#import "CatSideView.h"

@interface CatCommonPickerView () <UIPickerViewDataSource,UIPickerViewDelegate> {
@private
    NSArray *_values;
    NSInteger _selectRow;
    NSInteger _selectComponent;
}

@property (nonatomic,strong) UIPickerView *pickerView;
@property (nonatomic,weak) id<CatCommonPickerViewDelegate> delegate;
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) CC_Button *cancelBtn;
@property (nonatomic,strong) CC_Button *confirmBtn;

@end

@implementation CatCommonPickerView

- (instancetype)initWithDelegate:(id<CatCommonPickerViewDelegate>)delegate values:(NSArray *)values {
    return [self initWithFrame:CGRectMake(0, 0, WIDTH(), RH(232)) delegate:delegate values:values];
}

- (instancetype)initWithFrame:(CGRect)frame
                     delegate:(id<CatCommonPickerViewDelegate>)delegate
                       values:(NSArray *)values {
    
    if (self = [super initWithFrame:frame]) {
        _delegate = delegate;
        _values = values;
        [self _commonInit];
    }
    return self;
}

- (void)_commonInit {
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height/2.0, self.width, RH(46.0f))];
    _backView.backgroundColor = RGBA(248, 248, 248, 1);
    [self addSubview:_backView];
    
    WS(weakSelf);
    self.cancelBtn = [[CC_Button alloc]initWithFrame:CGRectMake(0, 0, self.width/2.0, RH(50.0f))];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:RGBA(167, 164, 164, 1) forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = RF(16.0f);
    [self addSubview:_cancelBtn];
    [_cancelBtn cc_tappedInterval:0.1 withBlock:^(id  _Nonnull view) {
        SS(strongSelf);
        [strongSelf.cc_sideView dismissViewAnimated:YES];
    }];
    self.confirmBtn = [[CC_Button alloc]initWithFrame:CGRectMake(self.width/2.0, 0, self.width/2.0, RH(50.0f))];
    [_confirmBtn setTitle:@"完成" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    _confirmBtn.titleLabel.font = RF(16.0f);
    [self addSubview:_confirmBtn];
    
    [_confirmBtn cc_tappedInterval:0.1 withBlock:^(id  _Nonnull view) {
        SS(strongSelf);
        if ([strongSelf.delegate respondsToSelector:@selector(commonPickerView:value:didSelectRow:inComponent:)]) {
            if ([strongSelf dimensional] == 2) {
                for (int i = 0; i < strongSelf->_values.count; ++i) {
                    [strongSelf.delegate commonPickerView:strongSelf
                                                    value:strongSelf->_values[i][[strongSelf.pickerView selectedRowInComponent:i]]
                                             didSelectRow:[strongSelf.pickerView selectedRowInComponent:i]
                                              inComponent:i];
                }
                
            }else {
                [strongSelf.delegate commonPickerView:strongSelf
                                                value:strongSelf->_values[strongSelf->_selectRow]
                                         didSelectRow:strongSelf->_selectRow
                                          inComponent:0];
            }
        }
    }];
    
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, _cancelBtn.bottom, WIDTH(), RH(178.0f))];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    [self addSubview:_pickerView];
    
    /// 分割线
    UIView* horizontalLine1 = [[UIView alloc]initWithFrame:CGRectMake(0, _cancelBtn.bottom, self.width, RH(4.0f))];
    horizontalLine1.backgroundColor = RGBA(248, 248, 248, 1);
    [self addSubview:horizontalLine1];
    UIView* horizontalLine2 = [[UIView alloc]initWithFrame:CGRectMake(self.width/2.0-RH(0.5f), 0, RH(1.0f), RH(50.0f))];
    horizontalLine2.backgroundColor = RGBA(248, 248, 248, 1);
    [self addSubview:horizontalLine2];
}

- (NSInteger)dimensional {
    if ([_values.firstObject isKindOfClass:[NSArray class]]) {
        return 2;
    }
    return 1;
}

#pragma mark - UIPickerView -
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if ([self dimensional] == 2) {
        return [_values count];
    }
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if ([self dimensional] == 2) {
        return [_values[component] count];
    }
    return [_values count];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return RH(46.0f);
}

/// 自定义每个pickview的label
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(__kindof UIView *)view{
    UILabel *pickerLabel = (UILabel*)view;
    if (!pickerLabel) {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        pickerLabel.font = RF(22);
    }
    
    if ([self dimensional] == 2) {
        if ([_values[component][row] isKindOfClass:NSString.class]) {
            pickerLabel.text = _values[component][row];
        }else {
            if([self.delegate respondsToSelector:@selector(commonPickerNameKey:withRow:inComponent:)]) {
                NSString *nameKey = [self.delegate commonPickerNameKey:self withRow:row inComponent:component];
                if (![nameKey isEqualToString:CatCommonPickerViewNameKeyAuto]) {
                    NSString *text = [_values[component][row] objectForKey:nameKey];
                    pickerLabel.text = text;
                }
            }
        }
    }else {
        if ([_values[row] isKindOfClass:NSString.class]) {
            pickerLabel.text = _values[row];
        }else {
            if([self.delegate respondsToSelector:@selector(commonPickerNameKey:withRow:inComponent:)]) {
                NSString *nameKey = [self.delegate commonPickerNameKey:self withRow:row inComponent:0];
                if (![nameKey isEqualToString:CatCommonPickerViewNameKeyAuto]) {
                    NSString *text = [_values[row] objectForKey:nameKey];
                    pickerLabel.text = text;
                }
            }
        }
    }
    
    NSInteger selectRow = [pickerView selectedRowInComponent:component];
    if (row == selectRow) {
        pickerLabel.textColor = RGBA(36, 151, 235,1);
    }else {
        pickerLabel.textColor = RGBA(51, 51, 51, 1);
    }
    
    return pickerLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _selectRow = row;
    _selectComponent = component;
    [pickerView reloadComponent:component];
}

@end

NSString *const CatCommonPickerViewNameKeyAuto = @"CatCommonPickerViewNameKeyAuto";
