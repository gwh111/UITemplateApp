//
//  CatDateSelect.m
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/13.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CatDateSelect.h"

@interface CatDateSelect ()<CatDateSelectViewDelegate>

@property (nonatomic, strong) NSString* startYear;
@property (nonatomic, strong) NSString* endYear;
@property (nonatomic, strong) NSString* cancelTitle;
@property (nonatomic, strong) NSString* confirmTitle;
@property (nonatomic, strong) NSString* defaultDate;
//最小可选日期
@property (nonatomic, strong) NSString* minDate;
//最大可选日期
@property (nonatomic, strong) NSString* maxDate;
@property (nonatomic, assign) CatDateSelectTheme theme;

@property (nonatomic, strong) UIView* maskView;//蒙版
@property (nonatomic, strong) CatDateSelectView* dateSelectView;

@end

@implementation CatDateSelect

-(instancetype)initWithCancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle theme:(CatDateSelectTheme)theme{
    if (self = [super init]) {
        self.cancelTitle = cancelTitle;
        self.confirmTitle = confirmTitle;
        self.theme = theme;
        self.defaultDate = [CatDateSelectTool caculateCurrentDate];
        self.startYear = @"1900";
        self.endYear = @"2100";
    }
    return self;
}

-(instancetype)initWithCancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle theme:(CatDateSelectTheme)theme defaultDate:(NSString *)defaultDate{
    if (self = [super init]) {
        self.cancelTitle = cancelTitle;
        self.confirmTitle = confirmTitle;
        self.theme = theme;
        self.defaultDate = defaultDate;
        self.startYear = @"1900";
        self.endYear = @"2100";
        
        NSAssert(defaultDate.length >= 10, @"所给时间字符串有问题");
    }
    return self;
}

-(instancetype)initWithCancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle theme:(CatDateSelectTheme)theme startYear:(NSString *)startYear endYear:(NSString *)endYear minDate:(NSString *)minDate maxDate:(NSString *)maxDate{
    if (self = [super init]) {
        self.cancelTitle = cancelTitle;
        self.confirmTitle = confirmTitle;
        self.theme = theme;
        self.defaultDate = [CatDateSelectTool caculateCurrentDate];
        self.startYear = startYear;
        self.endYear = endYear;
        self.minDate = minDate;
        self.maxDate = maxDate;
    }
    return self;
}

-(instancetype)initWithCancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle theme:(CatDateSelectTheme)theme minDate:(NSString *)minDate maxDate:(NSString *)maxDate{
    if (self = [super init]) {
        self.cancelTitle = cancelTitle;
        self.confirmTitle = confirmTitle;
        self.theme = theme;
        self.defaultDate = [CatDateSelectTool caculateCurrentDate];
        self.startYear = @"1900";
        self.endYear = @"2100";
        self.minDate = minDate;
        self.maxDate = maxDate;
    }
    return self;
}

-(instancetype)initWithCancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle theme:(CatDateSelectTheme)theme defaultDate:(NSString *)defaultDate startYear:(NSString *)startYear endYear:(NSString *)endYear minDate:(nullable NSString *)minDate maxDate:(nullable NSString *)maxDate{
    if (self = [super init]) {
        self.cancelTitle = cancelTitle;
        self.confirmTitle = confirmTitle;
        self.theme = theme;
        self.defaultDate = defaultDate;
        self.startYear = startYear;
        self.endYear = endYear;
        self.minDate = minDate;
        self.maxDate = maxDate;
        
        NSAssert(defaultDate.length >= 10, @"所给时间字符串有问题");
    }
    return self;
}
-(void)popUpCatDateSelectView{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    self.maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(), HEIGHT())];
    _maskView.backgroundColor = RGBA(51, 51, 51, 0.5);
    _maskView.alpha = 0.0f;
    _maskView.userInteractionEnabled = YES;
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissCatDateSelectView)];
    [_maskView addGestureRecognizer:tap];
    [window addSubview:_maskView];
    
    self.dateSelectView = [[CatDateSelectView alloc]initWithCancelTitle:_cancelTitle confirmTitle:_confirmTitle theme:_theme defaultDate:_defaultDate startYear:_startYear endYear:_endYear minDate:_minDate maxDate:_maxDate selectContentColor:_selectContentColor unSelectContentColor:_unSelectContentColor selectBarColor:_selectBarColor hideWeekDay:_hideWeekDay];
    _dateSelectView.delegate = self;
    [window addSubview:_dateSelectView];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 1.0f;
        self.dateSelectView.alpha = 1.0f;
        self.dateSelectView.frame = CGRectMake(0, HEIGHT()-kCatDateSelectViewHeight, WIDTH(), kCatDateSelectViewHeight);
    }];
}

-(void)dismissCatDateSelectView{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0.0f;
        self.dateSelectView.alpha = 0.0f;
        self.dateSelectView.frame = CGRectMake(0, HEIGHT(), WIDTH(), kCatDateSelectViewHeight);
    } completion:^(BOOL finished) {
        [self.dateSelectView removeFromSuperview];
        self.dateSelectView = nil;
        [self.maskView removeFromSuperview];
        self.maskView = nil;
    }];
}

#pragma mark - delegates
-(void)catDateSelectViewCancel:(CatDateSelectView *)dateSelectView{
    if (_delegate && [_delegate respondsToSelector:@selector(catDateSelectCancel:)]) {
        [_delegate catDateSelectCancel:self];
    }
    [self dismissCatDateSelectView];
}
-(void)catDateSelectViewConfirm:(CatDateSelectView *)dateSelectView selectYear:(nonnull NSString *)selectYear selectMonth:(nonnull NSString *)selectMonth selectDay:(nonnull NSString *)selectDay selectWeek:(nonnull NSString *)selectWeek{
    NSLog(@"---------%@-%@-%@%@", selectYear, selectMonth, selectDay, selectWeek);
    if (_delegate && [_delegate respondsToSelector:@selector(catDateSelectConfirm:selectYear:selectMonth:selectDay:selectWeek:)]) {
        [_delegate catDateSelectConfirm:self selectYear:selectYear selectMonth:selectMonth selectDay:selectDay selectWeek:selectWeek];
    }
    [self dismissCatDateSelectView];
}

@end
