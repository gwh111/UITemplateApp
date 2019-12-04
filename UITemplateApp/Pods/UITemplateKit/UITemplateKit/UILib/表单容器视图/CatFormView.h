//
//  CatFormView.h
//  UITemplateKit
//
//  Created by Shepherd on 2019/7/7.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CatSingleLineView.h"
#import "CatMultiLineView.h"
#import "CatTofuView.h"
#import "ccs.h"

NS_ASSUME_NONNULL_BEGIN
@class CatFormView;

typedef CatSimpleView CatFormSubview;

typedef NS_ENUM(NSInteger,CatFormSubType) {
    CatFormSubTypeSingle,
    CatFormSubTypeMulti,
    CatFormSubTypeTofu,
    CatFormSubTypeCustom,
};

@protocol CatFormViewDatasource <NSObject>

- (NSInteger)rowsInFormView;

/**
 类似tableView提供一个cell

 可使用dequeueReusableViewWithSubType:atRow: 返回一个指定类型的表单子视图
 
 @param formView 表单视图
 @param row 当前行
 @return 表单子元素视图
 */
- (CatFormSubview *)formView:(CatFormView *)formView atRow:(NSInteger)row;

@optional

/**
 自定义底部的提交视图

 @param formView 表单
 @param submitView 提交视图
 @note oneButton已被用于做提交按钮
 */
- (void)formView:(CatFormView *)formView customSubmitView:(CatFormSubview *)submitView;

@end

@protocol CatFormViewDelegate <NSObject>

@optional

- (void)formView:(CatFormView *)formView didSelectAtRow:(NSInteger)row;

/**
 对表单的某一行进行编辑后的回调
 
 @param formView 表单容器
 @param sender 当前行的视图
 @param value 修改后的值
 @param row 当前行
 
 */
- (void)formView:(CatFormView *)formView
editingChangedView:(CatFormSubview *)sender
           value:(id)value
           atRow:(NSInteger)row;

- (BOOL)formView:(CatFormView *)formView
  shouldSelectAtRow:(NSInteger)row;

/**
 可实现该代理方法实现表单中的某一行或某几行不可编辑
 
 @param formView 表单容器
 @param row 当前行
 */
- (BOOL)formView:(CatFormView *)formView shouldEditableAtRow:(NSInteger)row;

/**
 提交按钮是否可点击

 @param formView 表单容器
 @param requiredDictionary 必选项字典
 @param infoDictionary 可选项字典
 @return 提交按钮是否允许点击
 @note 可以在formView:editingChangedView:value:atRow: 代理方法中使用setFormKey:forValue保存表单信息
 调用 -setFormKey:forValue:optional:方法会触发该代理方法
 
 */
- (BOOL)formViewShouldSubmit:(CatFormView *)formView
                    required:(NSDictionary *)requiredDictionary
                        info:(NSDictionary *)infoDictionary;

/**
 提交
 */
- (void)formView:(CatFormView *)formView
          submit:(UIButton *)submit
        required:(NSDictionary *)requiredDictionary
            info:(NSDictionary *)infoDictionary;

@end

@interface CatFormView : UIView

@property (nonatomic,strong,readonly) UIScrollView *scrollView;

@property (nonatomic,assign) BOOL scrollable;

@property (nonatomic,weak) id<CatFormViewDatasource> datasource;

@property (nonatomic,weak) id<CatFormViewDelegate> delegate;

/** 每一列的默认高度 默认44 */
@property (nonatomic,assign) CGFloat estimatedRowHeight;

/** 提交按钮是否滚动,默认YES 跟随滚动 如果是商城订单类型,可能固定在底部比较合适 */
@property (nonatomic,assign) BOOL combineScroll;

/** 可选项字典 */
@property (nonatomic,strong,readonly) NSMutableDictionary *infoDictionary;

/** 必选项字典 */
@property (nonatomic,strong,readonly) NSMutableDictionary *requiredDictionary;

/** 当前选中哪一行 */
@property (nonatomic,assign) NSInteger currentRow;

@property (nonatomic,weak,readonly) UIButton *submitButton;

@property (nonatomic,strong) UIView *formHeaderView;

@property (nonatomic,strong) UIView *formFooterView;
/// 提交按钮与内容的上间距 默认11
@property (nonatomic,assign) CGFloat submitTopSpacing;

/**
 创建表单视图
 
 @param frame formView frame
 @param colors 正常/不可用状态的背景色/背景图
 @param radius 圆角
 @return return 表单视图
 
 @note
 colors 数量为1时 提交按钮可点击,设置的背景色/图片用于按钮的normal状态下
 colors 数量为2时 提交按钮不可点击,firstObject 用于normal状态 lastObject 用于disabled状态
 
 */
+ (instancetype)formViewWithFrame:(CGRect)frame
                submitBtnBgColors:(NSArray *)colors
                     cornerRadius:(CGFloat)radius;

- (void)reloadData;

- (__kindof CatFormSubview *)dequeueReusableViewWithSubType:(CatFormSubType)subType atRow:(NSInteger)row;

- (void)setFormKey:(NSString *)key forValue:(NSString *)value optional:(BOOL)optional;

// MARK: - convinent -

/**
 Equal call formViewShouldSubmit:required:info: method
 
*/
- (void)allowSubmitTest;

/**
 Equal call formView:sender:value:atRow:
 
 默认第几行取得是self.currentRow 预填写时会不准
 for (int i = 0; i < params.count; ++i) {
    self.currentRow = i;
    从服务器的返回的字典/模型获取对应的值
    if (i == 0) {
        [formView sendEditingChangedActionWithModel:someVal];
    }
    ....
 }
 */
- (void)sendEditingChangedActionWithModel:(id)model;

// MARK: - getter -

- (__kindof CatFormSubview *)formSubviewForIndex:(NSInteger)index;

/**
 尝试获取表单中下一个视图

 @param needEditable 是否需要支持编辑
 @return 表单子视图
 */
- (nullable __kindof CatFormSubview *)nextInputView:(BOOL)needEditable;

/// 表单的默认frame{{0,导航栏},{屏幕宽度,屏幕高度 - 导航栏}}
+ (CGRect)formRect;

- (CatSingleLineView *)singleLineViewWithIndex:(NSInteger)index;

- (CatMultiLineView *)multiLineViewWithIndex:(NSInteger)index;

@end

@interface CatFormView (CCDeprecated)

/**
 实际使用中发现比较容易忘记

 @param key 请求发送给服务器的字段名
 @param value 对应的值
 */
- (void)setFormKey:(NSString *)key
          forValue:(NSString *)value CC_DEPRECATED("Using setFormKey:forValue:optional:");

@end

@interface UIView (CatFormView)

- (nullable CatFormView *)cc_formView;

@end


NS_ASSUME_NONNULL_END
