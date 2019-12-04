//
//  SearchWithDateController.m
//  CurrencyKit
//
//  Created by gwh on 2019/11/12.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "SearchWithDateC.h"
#import "CurrencyConfig.h"
#import "CatDateSelect.h"

@interface SearchWithDateC () <CatDateSelectDelegate>

@property (nonatomic, retain) CatDateSelect *dateSelect1;

@property (nonatomic, retain) CC_Button *currentButton;

@end

@implementation SearchWithDateC

- (void)cc_willInit {
    
    _displayView = ccs.View;
    
    _displayView
    .cc_frame(0, 0, WIDTH(), RH(50))
    .cc_backgroundColor(UIColor.whiteColor)
    .cc_addToView(self.cc_displayView);
    
    CC_ImageView *dateImageView = ccs.ImageView;
    dateImageView
    .cc_frame(RH(10), RH(15), RH(20), RH(20))
    .cc_imageNamed(@"withdraw_date")
    .cc_addToView(_displayView);
    
    _fromButton = ccs.Button
    .cc_frame(RH(40), 0, RH(80), RH(50))
    .cc_setTitleColorForState(HEX(#666666), UIControlStateNormal)
    .cc_font(RF(15))
    .cc_setTitleForState(@"2019-08-01", UIControlStateNormal)
    .cc_addToView(_displayView);
    [_fromButton cc_addTappedOnceDelay:.1 withBlock:^(CC_Button *btn) {
        
        [self tappedFromDateButton:btn];
    }];
    
    CC_ImageView *arrowImageView = ccs.ImageView;
    arrowImageView
    .cc_frame(_fromButton.right + RH(5), RH(20), RH(10), RH(10))
    .cc_imageNamed(@"withdraw_right_arrow")
    .cc_addToView(_displayView);
    
    _toButton = ccs.Button
    .cc_frame(_fromButton.right + RH(20), 0, RH(80), RH(50))
    .cc_setTitleColorForState(HEX(#666666), UIControlStateNormal)
    .cc_font(RF(15))
    .cc_setTitleForState(@"2019-10-12", UIControlStateNormal)
    .cc_addToView(_displayView);
    [_toButton cc_addTappedOnceDelay:.1 withBlock:^(CC_Button *btn) {
        
        [self tappedToDateButton:btn];
    }];
    
    UIColor *buttonColor = CurrencyConfig.shared.chooseButtonColor;
    UIColor *buttonTitleColor = CurrencyConfig.shared.chooseButtonTextColor;
    UIColor *buttonBorderColor = CurrencyConfig.shared.chooseButtonBorderColor;
    
    CC_Button *searchButton = ccs.Button;
    searchButton
    .cc_frame(WIDTH() - RH(70), RH(10), RH(55), RH(30))
    .cc_setTitleColorForState(buttonTitleColor, UIControlStateNormal)
    .cc_backgroundColor(buttonColor)
    .cc_borderColor(buttonBorderColor)
    .cc_borderWidth(1)
    .cc_cornerRadius(4)
    .cc_font(RF(12))
    .cc_setTitleForState(@"搜索", UIControlStateNormal)
    .cc_addToView(_displayView);
    [searchButton cc_addTappedOnceDelay:.1 withBlock:^(CC_Button *btn) {
        
        [self tappedSearchButton:btn];
    }];
    
}

- (void)tappedFromDateButton:(CC_Button *)button {
    
    _currentButton = button;
    
    _dateSelect1 = [[CatDateSelect alloc]initWithCancelTitle:@"取消" confirmTitle:@"确认" theme:CatDateSelectThemeDay defaultDate:@"2019-11-13" startYear:@"1900" endYear:@"2100" minDate:@"1970-01-01" maxDate:@"2020-12-31"];
    _dateSelect1.delegate = self;
    [_dateSelect1 popUpCatDateSelectView];
}

- (void)tappedToDateButton:(CC_Button *)button {
    
    _currentButton = button;
    
    _dateSelect1 = [[CatDateSelect alloc]initWithCancelTitle:@"取消" confirmTitle:@"确认" theme:CatDateSelectThemeDay defaultDate:@"2019-11-13" startYear:@"1900" endYear:@"2100" minDate:@"1970-01-01" maxDate:@"2020-12-31"];
    _dateSelect1.delegate = self;
    [_dateSelect1 popUpCatDateSelectView];
}

- (void)tappedSearchButton:(CC_Button *)button {
    
    [self.cc_delegate cc_performSelector:@selector(controller:searchFromDate:toDate:) params:self, _fromButton.titleLabel.text, _toButton.titleLabel.text];
}

#pragma mark - delegate
- (void)catDateSelectCancel:(CatDateSelect *)dateSelect {
    
}

- (void)catDateSelectConfirm:(CatDateSelect *)dateSelect selectYear:(NSString *)selectYear selectMonth:(NSString *)selectMonth selectDay:(NSString *)selectDay selectWeek:(NSString *)selectWeek {
    
    NSString *title = [ccs string:@"%@-%@-%@", selectYear, selectMonth, selectDay];
    _currentButton.cc_setTitleForState(title, UIControlStateNormal);
}

@end
