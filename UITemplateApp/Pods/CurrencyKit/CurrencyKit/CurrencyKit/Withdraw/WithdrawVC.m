//
//  WithdrawViewController.m
//  CurrencyKit
//
//  Created by gwh on 2019/11/12.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "WithdrawVC.h"
#import "WithdrawMoneyInputC.h"
#import "WithdrawMethodC.h"
#import "WithdrawBankCardC.h"
#import "WithdrawDetailVC.h"
#import "CurrencyConfig.h"
#import "BankCardAddVC.h"
#import "PayPasswordC.h"
#import "WithdrawInfoC.h"

@interface WithdrawVC ()

@property (nonatomic, retain) WithdrawMoneyInputC *moneyInput;
@property (nonatomic, retain) WithdrawMethodC *method;
@property (nonatomic, retain) WithdrawBankCardC *bankCard;
@property (nonatomic, retain) PayPasswordC *payPassword;
@property (nonatomic, retain) WithdrawInfoC *info;

@property (nonatomic, retain) CC_Button *chargeButton;

@property (nonatomic, retain) WithdrawBasicInfoQueryModel *withdrawBasicInfoQueryModel;

@end

@implementation WithdrawVC

- (void)updateBasicInfo {
    
    Withdraw *withdraw = ccs.accountLib_withdraw;
    [withdraw withdrawBasicInfoQuerySuccess:^(HttpModel * _Nonnull result) {
        
        self.withdrawBasicInfoQueryModel = withdraw.withdrawBasicInfoQueryModel;
       
        [self update];
    } fail:^(NSString * _Nonnull errorMsg, HttpModel * _Nonnull result) {
        
    }];
}

- (void)cc_viewWillLoad {
    
    self.cc_title = @"提现";

    self.view.backgroundColor = HEX(#F5F5F5);
    
    _moneyInput = [ccs init:WithdrawMoneyInputC.class];
    [self cc_registerController:_moneyInput];
    
    _method = [ccs init:WithdrawMethodC.class];
    [self cc_registerController:_method];
    
    _bankCard = [ccs init:WithdrawBankCardC.class];
    [self cc_registerController:_bankCard];
    
    _payPassword = [ccs init:PayPasswordC.class];
    [self cc_registerController:_payPassword];
    
    _info = [ccs init:WithdrawInfoC.class];
    [self cc_registerController:_info];
}

- (void)cc_viewDidLoad {
	 // Do any additional setup after loading the view.
    
    [self.cc_displayView cc_tappedInterval:.1 withBlock:^(id  _Nonnull view) {
        [self.moneyInput.moneyTextField resignFirstResponder];
    }];
    
    UIColor *buttonColor = CurrencyConfig.shared.doneButtonColor;
    UIColor *buttonTitleColor = CurrencyConfig.shared.doneButtonTextColor;
    float buttonRadius = CurrencyConfig.shared.doneButtonRadius;
    
    _chargeButton = ccs.Button
    .cc_frame(RH(20), _method.displayView.bottom + RH(50), WIDTH() - RH(40), RH(40))
    .cc_cornerRadius(buttonRadius)
    .cc_backgroundColor(buttonColor)
    .cc_setTitleColorForState(buttonTitleColor, UIControlStateNormal)
    .cc_setTitleForState(@"确认提现", UIControlStateNormal)
    .cc_addToView(self);
    [_chargeButton cc_addTappedOnceDelay:.1 withBlock:^(CC_Button *btn) {
        
        [self.payPassword showPayPasswordOn:self.view];
    }];
    
    
    [_method.withdrawAskButton cc_addTappedOnceDelay:.1 withBlock:^(CC_Button *btn) {
        
        [self.info showWithdrawInfoOn:self.view text:self.withdrawBasicInfoQueryModel.withdrawExplain];
    }];
    
    [self update];
    [self updateBasicInfo];
    [self cc_adaptUI];
    
}

- (void)update {
    
    [_moneyInput updateWithdrawAmount:_withdrawBasicInfoQueryModel];
    
    _method.displayView.top = _moneyInput.displayView.bottom;
    _chargeButton.top = _method.displayView.bottom + RH(20);
    
    [self cc_adaptUI];
}

- (void)popBankCardView {
    
    [_bankCard showBankCardOn:self.view];
}

- (void)gotoWithdrawDetailViewController {
    
    WithdrawDetailVC *detail = [ccs init:WithdrawDetailVC.class];
    [ccs pushViewController:detail];
}

- (void)gotoAddBankCardViewController {
    
    [_bankCard.displayView removeFromSuperview];
    
    BankCardAddVC *vc = [ccs init:BankCardAddVC.class];
    [ccs pushViewController:vc];
}

- (void)controller:(WithdrawBankCardC *)controller bankSelected:(NSDictionary *)selectBankDic {
    
    [_method update:selectBankDic];
}

@end
