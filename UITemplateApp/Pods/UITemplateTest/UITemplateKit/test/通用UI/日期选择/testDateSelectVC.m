//
//  testDateSelectVC.m
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/13.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "testDateSelectVC.h"
#import "CatDateSelect.h"
#import "ccs.h"

@interface testDateSelectVC ()<CatDateSelectDelegate>

@property (nonatomic, strong) CatDateSelect* dateSelect1;
@property (nonatomic, strong) CatDateSelect* dateSelect2;
@property (nonatomic, strong) CatDateSelect* dateSelect3;
@property (nonatomic, strong) CatDateSelect* dateSelect4;
@property (nonatomic, strong) CatDateSelect* dateSelect5;

@end

@implementation testDateSelectVC

- (void)cc_viewDidLoad {
    
    NSArray *nameList = @[@"年-弹窗", @"月-弹窗", @"日-弹窗-设定时间", @"日-弹窗-设定最大最小时间", @"日-弹窗-默认最大最小时间"];
    CC_TableView *tableView = ccs.TableView
    .cc_frame(0, 0, WIDTH(), self.cc_displayView.height)
    .cc_addToView(self.cc_displayView);
    [tableView cc_addTextList:nameList withTappedBlock:^(NSUInteger index) {
        
        [self actionWithIndex:index];
    }];
}

- (void)actionWithIndex:(NSUInteger)index {
    if (index == 0) {
        self.dateSelect1 = [[CatDateSelect alloc]initWithCancelTitle:@"取消" confirmTitle:@"确认" theme:CatDateSelectThemeYear];
//        self.dateSelect1 = [[CatDateSelect alloc]initWithCancelTitle:@"取消" confirmTitle:@"确认" theme:CatDateSelectThemeYear defaultDate:@"2020-02-14"];
        self.dateSelect1.delegate = self;
        [self.dateSelect1 popUpCatDateSelectView];
    }
    if (index == 1) {
        self.dateSelect2 = [[CatDateSelect alloc]initWithCancelTitle:@"取消" confirmTitle:@"确认" theme:CatDateSelectThemeMonth];
//        self.dateSelect2 = [[CatDateSelect alloc]initWithCancelTitle:@"取消" confirmTitle:@"确认" theme:CatDateSelectThemeMonth defaultDate:@"2020-02-14"];
        self.dateSelect2.delegate = self;
        [self.dateSelect2 popUpCatDateSelectView];
    }
    if (index == 2) {
        //        self.dateSelect3 = [[CatDateSelect alloc]initWithCancelTitle:@"取消" confirmTitle:@"确认" theme:CatDateSelectThemeDay];
        self.dateSelect3 = [[CatDateSelect alloc]initWithCancelTitle:@"取消" confirmTitle:@"确认" theme:CatDateSelectThemeDay defaultDate:@"2020-02-14" startYear:@"1900" endYear:@"2100" minDate:@"1970-01-01" maxDate:@"2020-12-31"];
        self.dateSelect3.delegate = self;
        [self.dateSelect3 popUpCatDateSelectView];
    }
    if (index == 3) {
        self.dateSelect4 = [[CatDateSelect alloc]initWithCancelTitle:@"取消" confirmTitle:@"确认" theme:CatDateSelectThemeDay startYear:@"1900" endYear:@"2100" minDate:@"1970-01-01" maxDate:@"2020-12-31"];
        self.dateSelect4.delegate = self;
        [self.dateSelect4 popUpCatDateSelectView];
    }
    if (index == 4) {
        self.dateSelect5 = [[CatDateSelect alloc]initWithCancelTitle:@"取消" confirmTitle:@"确认" theme:CatDateSelectThemeDay minDate:@"2000-01-01" maxDate:@"2020-12-31"];
        self.dateSelect5.delegate = self;
        [self.dateSelect5 popUpCatDateSelectView];
    }
}

- (CC_Button *)createBtn:(CGRect)rect title:(NSString *)title block:(void(^)(UIButton *button))block {
    
    CC_Button *btn = [[CC_Button alloc]initWithFrame:rect];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:title forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn cc_tappedInterval:0.1 withBlock:block];
    return btn;
}
#pragma mark - public

#pragma mark - notification

#pragma mark - delegate
- (void)catDateSelectCancel:(CatDateSelect *)dateSelect {
    
}

- (void)catDateSelectConfirm:(CatDateSelect *)dateSelect selectYear:(NSString *)selectYear selectMonth:(NSString *)selectMonth selectDay:(NSString *)selectDay selectWeek:(NSString *)selectWeek {
    
}
#pragma mark - property


@end
