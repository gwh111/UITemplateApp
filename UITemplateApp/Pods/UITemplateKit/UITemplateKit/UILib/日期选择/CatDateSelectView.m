//
//  CatDateSelectView.m
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/13.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CatDateSelectView.h"

@interface CatDateSelectView ()<UIPickerViewDelegate, UIPickerViewDataSource>

//最小的日期
@property (nonatomic, assign) NSInteger startYear;
//最大的日期
@property (nonatomic, assign) NSInteger endYear;
//最小可选日期
@property (nonatomic, strong) NSString* minDate;
//最大可选日期
@property (nonatomic, strong) NSString* maxDate;

@property (nonatomic, strong) NSString* cancelTitle;
@property (nonatomic, strong) NSString* confirmTitle;
@property (nonatomic, strong) NSString* defaultDate;
@property (nonatomic, assign) CatDateSelectTheme theme;
//选中文字颜色
@property (nonatomic, strong) UIColor* selectContentColor;
//未选中文字颜色
@property (nonatomic, strong) UIColor* unSelectContentColor;
//选中背景条颜色
@property (nonatomic, strong) UIColor* selectBarColor;
//当前所选日期 yyyy-MM-dd
@property (nonatomic, strong) NSString* currentDate;
//是否隐藏星期几
@property (nonatomic, assign) BOOL hideWeekDay;

@property (nonatomic, strong) NSArray *yearArr , *monthArr , *dayArr , *weekArr, *showDayArr;
@property (nonatomic, strong) NSString *yearNow , *monthNow , *dayNow;
// 当前 '年' '月' '日' 数组中所占的索引值
@property (nonatomic, assign) NSInteger rowLeft , rowMiddle , rowRight;
// pickerview上显示的第几个
@property (nonatomic, assign) NSInteger chosenYear , chosenMonth , chosenDay;

//当前选择的背景块
@property (nonatomic, strong) UIView* backCurrentView;
@property (nonatomic, strong) CC_Button* cancelBtn;
@property (nonatomic, strong) CC_Button* confirmBtn;
@property (nonatomic, strong) UIPickerView* pickerView;
@end
@implementation CatDateSelectView

-(instancetype)initWithCancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle theme:(CatDateSelectTheme)theme defaultDate:(NSString *)defaultDate startYear:(nonnull NSString *)startYear endYear:(nonnull NSString *)endYear minDate:(nullable NSString *)minDate maxDate:(nullable NSString *)maxDate selectContentColor:(nullable UIColor *)selectContentColor unSelectContentColor:(nullable UIColor *)unSelectContentColor selectBarColor:(nullable UIColor *)selectBarColor hideWeekDay:(BOOL)hideWeekDay{
    if (self = [super init]) {
        self.cancelTitle = cancelTitle;
        self.confirmTitle = confirmTitle;
        self.theme = theme;
        self.currentDate = defaultDate;
        self.startYear = [startYear integerValue];
        self.endYear = [endYear integerValue];
        self.minDate = minDate;
        self.maxDate = maxDate;
        self.selectContentColor = selectContentColor?selectContentColor:RGBA(36, 151, 235,1);
        self.unSelectContentColor = unSelectContentColor?unSelectContentColor:RGBA(51, 51, 51, 1);
        self.selectBarColor = selectBarColor?selectBarColor:RGBA(248, 248, 248, 1);
        self.hideWeekDay = hideWeekDay;
        [self setupViews];
        [self baseConfig];
    }
    return self;
}

-(void)baseConfig{
    
    // 当前时间 选择器默认显示时间
    NSRange range;
    range = NSMakeRange(0, 4);
    self.yearNow =[self.currentDate substringWithRange:range];
    self.chosenYear = [_yearNow integerValue];
    range = NSMakeRange(5, 2);
    self.monthNow = [self.currentDate substringWithRange:range];
    self.chosenMonth = [_monthNow integerValue];
    range = NSMakeRange(8, 2);
    self.dayNow = [self.currentDate substringWithRange:range];
    self.chosenDay = [_dayNow integerValue];
    
    //计算年月日数组
    NSMutableArray* muaArr = [[NSMutableArray alloc]init];
    for (NSInteger i = _startYear; i <= _endYear; i++) {
        [muaArr addObject:[NSString stringWithFormat:@"%ld", i]];
    }
    _yearArr = [muaArr copy];
    _monthArr = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
    _dayArr = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",
                @"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",
                @"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31"];
    _weekArr = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    //计算拼接完的日+周几
    self.showDayArr = [self caculateShowDayArr:_yearNow month:_monthNow];
    
    //计算当前日期位置
    NSUInteger rowLeft = [_yearArr indexOfObject:_yearNow];
    NSUInteger rowMiddle = [_monthArr indexOfObject:_monthNow];
    NSUInteger rowRight = [_dayArr indexOfObject:_dayNow];
    
    _rowLeft = rowLeft;
    _rowMiddle = rowMiddle;
    _rowRight = rowRight;
    
    if (self.theme >= 0) {
        [_pickerView selectRow:rowLeft inComponent:0 animated:YES];
    }
    if (self.theme >= 1) {
        [_pickerView selectRow:rowMiddle inComponent:1 animated:YES];
    }
    if (self.theme >= 2) {
        [_pickerView selectRow:rowRight inComponent:2 animated:YES];
    }
}

-(void)setupViews{
    self.backgroundColor = [UIColor whiteColor];
    self.frame = CGRectMake(0, HEIGHT(), WIDTH(), kCatDateSelectViewHeight);
    
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
        if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(catDateSelectViewCancel:)]) {
            [strongSelf.delegate catDateSelectViewCancel:strongSelf];
        }
    }];
    self.confirmBtn = [[CC_Button alloc]initWithFrame:CGRectMake(self.width/2.0, 0, self.width/2.0, RH(50.0f))];
    [_confirmBtn setTitle:_confirmTitle forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    _confirmBtn.titleLabel.font = RF(16.0f);
    [self addSubview:_confirmBtn];
    [_confirmBtn cc_tappedInterval:0.1 withBlock:^(id  _Nonnull view) {
        SS(strongSelf);
        
        if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(catDateSelectViewConfirm:selectYear:selectMonth:selectDay:selectWeek:)]) {
            if (strongSelf.theme == CatDateSelectThemeYear) {
                
                [strongSelf.delegate catDateSelectViewConfirm:strongSelf selectYear:strongSelf.yearArr[strongSelf.rowLeft] selectMonth:@"" selectDay:@"" selectWeek:@""];
            }else if (strongSelf.theme == CatDateSelectThemeMonth) {
                [strongSelf.delegate catDateSelectViewConfirm:strongSelf selectYear:strongSelf.yearArr[strongSelf.rowLeft] selectMonth:strongSelf.monthArr[strongSelf.rowMiddle] selectDay:@"" selectWeek:@""];
            }else if (strongSelf.theme == CatDateSelectThemeDay) {
                //计算周几
                NSString* str = [strongSelf.showDayArr[strongSelf.rowRight] substringFromIndex:2];
                
                [strongSelf.delegate catDateSelectViewConfirm:strongSelf selectYear:strongSelf.yearArr[strongSelf.rowLeft] selectMonth:strongSelf.monthArr[strongSelf.rowMiddle] selectDay:strongSelf.dayArr[strongSelf.rowRight] selectWeek:str];
            }
        }
    }];
    //pickerView
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, _cancelBtn.bottom, WIDTH(), RH(178.0f))];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    [self addSubview:_pickerView];
    
    //分割线
    UIView* horizontalLine1 = [[UIView alloc]initWithFrame:CGRectMake(0, _cancelBtn.bottom, self.width, RH(4.0f))];
    horizontalLine1.backgroundColor = RGBA(248, 248, 248, 1);
    [self addSubview:horizontalLine1];
    UIView* horizontalLine2 = [[UIView alloc]initWithFrame:CGRectMake(self.width/2.0-RH(0.5f), 0, RH(1.0f), RH(50.0f))];
    horizontalLine2.backgroundColor = RGBA(248, 248, 248, 1);
    [self addSubview:horizontalLine2];
}

-(void)numberOfDaysEachMonth {
    NSString *year = _yearArr[_rowLeft];
    
    self.chosenYear = [year integerValue];
    self.chosenMonth = _rowMiddle+1;
    
    if ((self.chosenMonth == 1) || (self.chosenMonth == 3) || (self.chosenMonth == 5) ||(self.chosenMonth == 7)||(self.chosenMonth == 8)||(self.chosenMonth == 10)||(self.chosenMonth == 12)) {
        
    } else if ((self.chosenMonth == 4)||(self.chosenMonth == 6)||(self.chosenMonth == 9)||(self.chosenMonth == 11)) {
        if (_rowRight > 29) {
            _rowRight =  29;
        }
    } else if ((self.chosenYear % 100 != 0)&(self.chosenYear % 4 == 0)) {
        if (_rowRight > 28) {
            _rowRight =  28;
        }
    } else if ((self.chosenYear % 400 == 0)) {
        if (_rowRight > 28) {
            _rowRight =  28;
        }
    } else if (_rowRight > 27) {
        _rowRight =  27;
    }
}

-(NSString*)caculateWeekWithYear:(NSString*)year month:(NSString*)month day:(NSString*)day{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date=[formatter dateFromString:[NSString stringWithFormat:@"%@-%@-%@", year, month, day]];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    comps = [calendar components:unitFlags fromDate:date];
    return _weekArr[[comps weekday] - 1];
}

-(NSArray*)caculateShowDayArr:(NSString*)year month:(NSString*)month{
    NSMutableArray* muaDayArr = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < [self caculateDaysCount]; i++) {
        NSString* dayStr = _dayArr[i];
        NSString* showDayStr = [NSString stringWithFormat:@"%@%@", dayStr, _hideWeekDay?@"":[self caculateWeekWithYear:year month:month day:dayStr]];
        [muaDayArr addObject:showDayStr];
    }
    return [muaDayArr copy];
}

-(NSInteger)caculateDaysCount{
    if ((self.chosenMonth == 1) || (self.chosenMonth == 3) || (self.chosenMonth == 5) ||(self.chosenMonth == 7)||(self.chosenMonth == 8)||(self.chosenMonth == 10)||(self.chosenMonth == 12)) {
        return 31;
    }
    if ((self.chosenMonth == 4)||(self.chosenMonth == 6)||(self.chosenMonth == 9)||(self.chosenMonth == 11)) {
        return 30;
    }
    if ((self.chosenYear % 100 != 0)&(self.chosenYear % 4 == 0)) {
        return 29;
    }
    if ((self.chosenYear % 400 == 0)) {
        return 29;
    }
    return 28;
}
#pragma mark - delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.theme+1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return _yearArr.count;
    } else if (component == 1) {
        return _monthArr.count;
    } else if (component == 2) {
        if ((self.chosenMonth == 1) || (self.chosenMonth == 3) || (self.chosenMonth == 5) ||(self.chosenMonth == 7)||(self.chosenMonth == 8)||(self.chosenMonth == 10)||(self.chosenMonth == 12)) {
            return 31;
        }
        if ((self.chosenMonth == 4)||(self.chosenMonth == 6)||(self.chosenMonth == 9)||(self.chosenMonth == 11)) {
            return 30;
        }
        if ((self.chosenYear % 100 != 0)&(self.chosenYear % 4 == 0)) {
            return 29;
        }
        if ((self.chosenYear % 400 == 0)) {
            return 29;
        }
        return 28;
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0){
        return  [_yearArr objectAtIndex:row];
    } else if (component == 1){
        return [_monthArr objectAtIndex:row];
    } else if (component == 2){
        return [_showDayArr objectAtIndex:row];
    }
    return nil;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return RH(46.0f);
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel) {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setFont:RF(22.0f)];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    
    if (component == 0) {
        if (row == _rowLeft) {
            pickerLabel.textColor = _selectContentColor;
        } else {
            pickerLabel.textColor = _unSelectContentColor;
        }
    } else if (component == 1) {
        if (row == _rowMiddle) {
            pickerLabel.textColor = _selectContentColor;
        } else {
            pickerLabel.textColor = _unSelectContentColor;
        }
    } else if (component == 2) {
        if (row == _rowRight) {
            pickerLabel.textColor = _selectContentColor;
        } else {
            pickerLabel.textColor = _unSelectContentColor;
        }
    }
    return pickerLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString *year , *month , *day;
    
    if (component == 0) {
        _rowLeft = row;
        [self numberOfDaysEachMonth];
    }
    if (component == 1) {
        _rowMiddle = row;
        [self numberOfDaysEachMonth];
    }
    if (component == 2) {
        _rowRight = row;
    }
    year = _yearArr[_rowLeft];
    month = _monthArr[_rowMiddle];
    day = _dayArr[_rowRight];
    
    self.chosenYear = [year integerValue];
    self.chosenMonth = [month integerValue];
    self.chosenDay = [day integerValue];
    
    [pickerView reloadAllComponents];
    
    //保证有最大、最小限制的值，才能进行限制
    if (_maxDate.length >= 10 && _minDate.length >= 10) {
        NSString* selectDate = [NSString stringWithFormat:@"%ld-%ld-%ld", _chosenYear, _chosenMonth, _chosenDay];
        if ([CatDateSelectTool compareDate:[CatDateSelectTool dateFromString:selectDate] withDate:[CatDateSelectTool dateFromString:_minDate]]) {
            //比最小能选的日期小
            [self recaculateSelectDate:_minDate];
        } else if ([CatDateSelectTool compareDate:[CatDateSelectTool dateFromString:_maxDate] withDate:[CatDateSelectTool dateFromString:selectDate]]) {
            //比最大能选的日期大
            [self recaculateSelectDate:_maxDate];
        }
    }
    
    self.showDayArr = [self caculateShowDayArr:[NSString stringWithFormat:@"%ld", _chosenYear] month:[NSString stringWithFormat:@"%ld", _chosenMonth]];
}

-(void)recaculateSelectDate:(NSString*)dateStr {
    
    // 当前时间 选择器默认显示时间
    NSRange range;
    range = NSMakeRange(0, 4);
    self.yearNow =[dateStr substringWithRange:range];
    self.chosenYear = [_yearNow integerValue];
    range = NSMakeRange(5, 2);
    self.monthNow = [dateStr substringWithRange:range];
    self.chosenMonth = [_monthNow integerValue];
    range = NSMakeRange(8, 2);
    self.dayNow = [dateStr substringWithRange:range];
    self.chosenDay = [_dayNow integerValue];
    //计算当前日期位置
    NSUInteger rowLeft = [_yearArr indexOfObject:_yearNow];
    NSUInteger rowMiddle = [_monthArr indexOfObject:_monthNow];
    NSUInteger rowRight = [_dayArr indexOfObject:_dayNow];
    
    _rowLeft = rowLeft;
    _rowMiddle = rowMiddle;
    _rowRight = rowRight;
    
    if (self.theme >= 0) {
        [_pickerView selectRow:rowLeft inComponent:0 animated:YES];
    }
    if (self.theme >= 1) {
        [_pickerView selectRow:rowMiddle inComponent:1 animated:YES];
    }
    if (self.theme >= 2) {
        [_pickerView selectRow:rowRight inComponent:2 animated:YES];
    }
}
@end
