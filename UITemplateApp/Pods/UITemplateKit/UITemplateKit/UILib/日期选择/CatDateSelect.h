//
//  CatDateSelect.h
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/13.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CatDateSelectView.h"

NS_ASSUME_NONNULL_BEGIN

@class CatDateSelect;
@protocol CatDateSelectDelegate <NSObject>
@optional
//取消
- (void)catDateSelectCancel:(CatDateSelect*)dateSelect;
//确认
- (void)catDateSelectConfirm:(CatDateSelect*)dateSelect  selectYear:(NSString*)selectYear selectMonth:(NSString*)selectMonth selectDay:(NSString*)selectDay selectWeek:(NSString*)selectWeek;

@end

@interface CatDateSelect : NSObject

@property (nonatomic, weak) id<CatDateSelectDelegate>delegate;

//选中文字颜色
@property (nonatomic, strong) UIColor* selectContentColor;
//未选中文字颜色
@property (nonatomic, strong) UIColor* unSelectContentColor;
//选中背景条颜色
@property (nonatomic, strong) UIColor* selectBarColor;
//是否显示星期几-默认显示
@property (nonatomic, assign) BOOL hideWeekDay;

/**
 创建日期选择弹框  默认时间为当前时间
 
 @param cancelTitle 取消框文字
 @param confirmTitle 确认框文字
 @param theme 样式-年/月/日
 @return 实例
 */
- (instancetype)initWithCancelTitle:(NSString*)cancelTitle confirmTitle:(NSString*)confirmTitle theme:(CatDateSelectTheme)theme;

/**
 创建日期选择弹框 需设置默认时间
 
 @param cancelTitle 取消框文字
 @param confirmTitle 确认框文字
 @param defaultDate 默认时间 若为空，则取当前时间 yyyy-MM-dd
 @param theme 样式-年/月/日
 @return 实例
 */
- (instancetype)initWithCancelTitle:(NSString*)cancelTitle confirmTitle:(NSString*)confirmTitle theme:(CatDateSelectTheme)theme defaultDate:(NSString*)defaultDate;

/**
 创建日期选择弹框 需设置最小可选时间、最大可选时间
 
 @param cancelTitle 取消框文字
 @param confirmTitle 确认框文字
 @param theme 样式-年/月/日
 @param minDate 最小可选时间
 @param maxDate 最大可选时间
 @return 实例
 */
- (instancetype)initWithCancelTitle:(NSString*)cancelTitle confirmTitle:(NSString*)confirmTitle theme:(CatDateSelectTheme)theme minDate:(nullable NSString*)minDate maxDate:(nullable NSString*)maxDate;

/**
 创建日期选择弹框 需设置开始时间、结束时间、最小可选时间、最大可选时间
 
 @param cancelTitle 取消框文字
 @param confirmTitle 确认框文字
 @param theme 样式-年/月/日
 @param startYear 开始时间
 @param endYear 结束时间
 @param minDate 最小可选时间
 @param maxDate 最大可选时间
 @return 实例
 */
- (instancetype)initWithCancelTitle:(NSString*)cancelTitle confirmTitle:(NSString*)confirmTitle theme:(CatDateSelectTheme)theme startYear:(NSString*)startYear endYear:(NSString*)endYear minDate:(nullable NSString*)minDate maxDate:(nullable NSString*)maxDate;

/**
 创建日期选择弹框 需设置默认时间、开始时间、结束时间、最小可选时间、最大可选时间

 @param cancelTitle 取消框文字
 @param confirmTitle 确认框文字
 @param theme 样式-年/月/日
 @param defaultDate 默认时间 若为空，则取当前时间 yyyy-MM-dd
 @param startYear 开始时间
 @param endYear 结束时间
 @param minDate 最小可选时间
 @param maxDate 最大可选时间
 @return 实例
 */
- (instancetype)initWithCancelTitle:(NSString*)cancelTitle confirmTitle:(NSString*)confirmTitle theme:(CatDateSelectTheme)theme defaultDate:(NSString*)defaultDate startYear:(NSString*)startYear endYear:(NSString*)endYear minDate:(nullable NSString*)minDate maxDate:(nullable NSString*)maxDate;
/**
 弹出日期选择控件
 */
- (void)popUpCatDateSelectView;

/**
 收起日期选择控件
 */
-(void)dismissCatDateSelectView;

@end

NS_ASSUME_NONNULL_END
