//
//  CatDateSelectView.h
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/13.
//  Copyright © 2019 gwh. All rights reserved.
//

#define kCatDateSelectViewHeight RH(232.0f)

#import <UIKit/UIKit.h>
#import "CatDateSelectTool.h"

NS_ASSUME_NONNULL_BEGIN

@class CatDateSelectView;
@protocol CatDateSelectViewDelegate <NSObject>
@optional
//取消
- (void)catDateSelectViewCancel:(CatDateSelectView*)dateSelectView;
//确认
- (void)catDateSelectViewConfirm:(CatDateSelectView*)dateSelectView selectYear:(NSString*)selectYear selectMonth:(NSString*)selectMonth selectDay:(NSString*)selectDay selectWeek:(NSString*)selectWeek;

@end
@interface CatDateSelectView : UIView

@property (nonatomic, weak) id<CatDateSelectViewDelegate>delegate;
/**
 创建日期选择弹框
 
 @param cancelTitle 取消框文字
 @param confirmTitle 确认框文字
 @param defaultDate 默认时间 若为空，则取当前时间 yyyy-MM-dd
 @param theme 样式-年/月/日
 @param startYear 开始年
 @param endYear 结束年
 @param minDate 最小日期
 @param maxDate 最大日期
 @param selectContentColor 选中文字颜色
 @param unSelectContentColor 未选中文字颜色
 @param selectBarColor 选中背景条颜色
 @param hideWeekDay 是否隐藏星期几
 @return 实例
 */
- (instancetype)initWithCancelTitle:(NSString*)cancelTitle confirmTitle:(NSString*)confirmTitle theme:(CatDateSelectTheme)theme defaultDate:(NSString*)defaultDate startYear:(NSString *)startYear endYear:(NSString *)endYear minDate:(nullable NSString*)minDate maxDate:(nullable NSString*)maxDate selectContentColor:(nullable UIColor*)selectContentColor unSelectContentColor:(nullable UIColor*)unSelectContentColor selectBarColor:(nullable UIColor*)selectBarColor hideWeekDay:(BOOL)hideWeekDay;

@end

NS_ASSUME_NONNULL_END
