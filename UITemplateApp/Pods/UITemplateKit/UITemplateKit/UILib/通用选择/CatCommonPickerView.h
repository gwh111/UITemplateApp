//
//  CatCommonPickerView.h
//  UITemplateKit
//
//  Created by ml on 2019/7/18.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ccs.h"

NS_ASSUME_NONNULL_BEGIN

@class CatCommonPickerView;

@protocol CatCommonPickerViewDelegate <NSObject>

@optional
/**
 显示时依据该值从数据源数组中取出对应的字段
 
 @param pickerView 选择控件
 @param row 对应行
 @param component 对应组
 @return 展示时取得字段
 @note  若是字符串数组,不用实现该方法
 不同组处理不同时,不需要处理的组返回 CatCommonPickerViewNameKeyAuto 字符串
 */
- (NSString *)commonPickerNameKey:(CatCommonPickerView *)pickerView withRow:(NSInteger)row inComponent:(NSInteger)component;

- (void)commonPickerView:(CatCommonPickerView *)pickerView value:(id)value didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

@end

@interface CatCommonPickerView : UIView

@property (nonatomic,strong,readonly) UIView *backView;
@property (nonatomic,strong,readonly) CC_Button *cancelBtn;
@property (nonatomic,strong,readonly) CC_Button *confirmBtn;
@property (nonatomic,strong,readonly) UIPickerView *pickerView;
@property (nonatomic,assign,readonly) NSInteger selectRow;
@property (nonatomic,assign,readonly) NSInteger selectComponent;

- (instancetype)initWithDelegate:(id<CatCommonPickerViewDelegate>)delegate
                          values:(NSArray *)values;

/**
 创建通用选择控件

 @param frame frame
 @param delegate 代理对象
 @param values 数据集
 @return 选择控件对象
 @note 一维数组 <=> 一列
       二维数组 <=> 多列
 
 Usage:
 CatCommonPickerView *pickerView = [[CatCommonPickerView alloc] initWithDelegate:delegate values:@[...]]
 [pickerView.cc_sideView showWithDirection:CatSideViewDirectionBottom]
 
 若选择的数据来自服务端,一般是字典,实现代理commonPickerNameKey:withRow:inComponent: 提供展示时的属性
 
 */
- (instancetype)initWithFrame:(CGRect)frame
                     delegate:(id<CatCommonPickerViewDelegate>)delegate
                       values:(NSArray *)values;

@end

UIKIT_EXTERN NSString *const CatCommonPickerViewNameKeyAuto;

NS_ASSUME_NONNULL_END
