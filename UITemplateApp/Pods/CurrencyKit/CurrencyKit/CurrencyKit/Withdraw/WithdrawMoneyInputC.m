//
//  WithdrawMoneyInputController.m
//  CurrencyKit
//
//  Created by gwh on 2019/11/12.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "WithdrawMoneyInputC.h"

@interface WithdrawMoneyInputC ()

@property (nonatomic, retain) CC_Label *totalMoneyLabel;
@property (nonatomic, retain) CC_Label *enableMoneyLabel;
@property (nonatomic, retain) CC_Label *serviceMoneyLabel;
@property (nonatomic, retain) CC_Label *realMoneyLabel;
@property (nonatomic, retain) WithdrawBasicInfoQueryModel *withdrawBasicInfoQueryModel;

@end

@implementation WithdrawMoneyInputC

- (void)updateChargeFeeQuery {
    
    [ccs.accountLib_withdraw withdrawChargeRangeConfigQuerySuccess:^(HttpModel * _Nonnull result) {
        
        self.moneyTextField.text = self.withdrawBasicInfoQueryModel.allowWithdrawAmount.value;
        [self updateChargeFee];
    } fail:^(NSString * _Nonnull errorMsg, HttpModel * _Nonnull result) {
        
    }];
}

- (void)updateChargeFee {

    CC_Money *withdrawMoney = ccs.money;
    [withdrawMoney moneyWithString:_moneyTextField.text];
    
    CC_Money *chargeFee = [ccs accountLib_getChargeMoneyWithWithdrawMoney:withdrawMoney isAccumulation:YES];
    
    if (chargeFee.number > _withdrawBasicInfoQueryModel.maxWithdrawAmount.number) {
        
        [chargeFee moneyWithString:_withdrawBasicInfoQueryModel.maxWithdrawAmount.value];
    } else if (chargeFee.number < _withdrawBasicInfoQueryModel.minWithdrawAmount.number) {
        
        [chargeFee moneyWithString:_withdrawBasicInfoQueryModel.minWithdrawAmount.value];
    }
    
    _serviceMoneyLabel.text = chargeFee.value;
    
    [withdrawMoney cutMoney:chargeFee];
    _realMoneyLabel.text = withdrawMoney.value;
    
}

- (void)updateWithdrawAmount:(WithdrawBasicInfoQueryModel *)withdrawBasicInfoQueryModel {
    
    _withdrawBasicInfoQueryModel = withdrawBasicInfoQueryModel;
    
    _totalMoneyLabel.text = withdrawBasicInfoQueryModel.withdrawAmount.value;
    _enableMoneyLabel.text = withdrawBasicInfoQueryModel.allowWithdrawAmount.value;
    
    [self updateChargeFeeQuery];
}

- (void)cc_willInit {
    
    _displayView = ccs.View;
    
    _displayView
    .cc_frame(0, 0, WIDTH(), RH(300))
    .cc_backgroundColor(UIColor.whiteColor)
    .cc_addToView(self.cc_displayView);
    
    CC_Label *totalMoneyTextLabel = ccs.Label;
    totalMoneyTextLabel
    .cc_frame(RH(15), RH(15), RH(100), RH(35))
    .cc_textColor(HEX(#666666))
    .cc_font(RF(13))
    .cc_text(@"提现总金额")
    .cc_addToView(_displayView);
    
    _totalMoneyLabel = ccs.Label
    .cc_frame(RH(15), totalMoneyTextLabel.bottom, RH(300), RH(35))
    .cc_textColor(HEX(#333333))
    .cc_font(RF(22))
    .cc_text(@"41523元")
    .cc_addToView(_displayView);
    
    CC_Label *enableMoneyTextLabel = ccs.Label;
    enableMoneyTextLabel
    .cc_frame(RH(15), _totalMoneyLabel.bottom, RH(100), RH(35))
    .cc_textColor(HEX(#666666))
    .cc_font(RF(13))
    .cc_text(@"可提现金额")
    .cc_addToView(_displayView);
    
    _enableMoneyLabel = ccs.Label
    .cc_frame(RH(15), enableMoneyTextLabel.bottom, RH(300), RH(35))
    .cc_textColor(HEX(#333333))
    .cc_font(RF(22))
    .cc_text(@"41522元")
    .cc_addToView(_displayView);
    
    CC_Label *markTextLabel = ccs.Label;
    markTextLabel
    .cc_frame(RH(15), _enableMoneyLabel.bottom + RH(10), RH(30), RH(35))
    .cc_textColor(HEX(#333333))
    .cc_font(RF(19))
    .cc_text(@"¥")
    .cc_addToView(_displayView);
    
    _moneyTextField = ccs.TextField;
    _moneyTextField
    .cc_frame(markTextLabel.right, markTextLabel.top, WIDTH() - RH(100), RH(35))
    .cc_placeholder(@"请输入提现金额(最低一元)")
    .cc_font(RF(17))
    .cc_addToView(_displayView);
    _moneyTextField.delegate = self;
    _moneyTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_moneyTextField addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventEditingChanged];
    
    CC_Button *allButton = ccs.Button
    .cc_frame(_moneyTextField.right, markTextLabel.top, RH(50), RH(35))
    .cc_setTitleColorForState(HEX(#F8492F), UIControlStateNormal)
    .cc_font(RF(15))
    .cc_setTitleForState(@"全部", UIControlStateNormal)
    .cc_addToView(_displayView);
    [allButton cc_addTappedOnceDelay:.1 withBlock:^(CC_Button *btn) {
       
        self.moneyTextField.text = self.withdrawBasicInfoQueryModel.allowWithdrawAmount.value;
        [self updateChargeFee];
    }];
    
    ccs.View
    .cc_frame(markTextLabel.left, markTextLabel.bottom + RH(10), WIDTH() - RH(50), 1)
    .cc_backgroundColor(HEX(#F5F5F5))
    .cc_addToView(_displayView);
    
    CC_View *grayLine = ccs.View;
    grayLine
    .cc_frame(0, _moneyTextField.bottom + RH(30), WIDTH(), 2)
    .cc_backgroundColor(HEX(#F5F5F5))
    .cc_addToView(_displayView);
    
    CC_Label *serviceMoneyTextLabel = ccs.Label;
    serviceMoneyTextLabel
    .cc_frame(RH(15), grayLine.bottom + RH(15), RH(300), RH(35))
    .cc_textColor(HEX(#666666))
    .cc_font(RF(13))
    .cc_text(@"应收服务费（包含个人缴纳各项税费等）")
    .cc_addToView(_displayView);
    
    _serviceMoneyLabel = ccs.Label
    .cc_frame(RH(15), serviceMoneyTextLabel.bottom, RH(300), RH(35))
    .cc_textColor(HEX(#333333))
    .cc_font(RF(22))
    .cc_text(@"0.2")
    .cc_addToView(_displayView);
    
    CC_Label *realMoneyTextLabel = ccs.Label;
    realMoneyTextLabel
    .cc_frame(RH(15), _serviceMoneyLabel.bottom, RH(300), RH(35))
    .cc_textColor(HEX(#666666))
    .cc_font(RF(13))
    .cc_text(@"实际到账金额")
    .cc_addToView(_displayView);
    
    _realMoneyLabel = ccs.Label
    .cc_frame(RH(15), realMoneyTextLabel.bottom, RH(300), RH(35))
    .cc_textColor(HEX(#333333))
    .cc_font(RF(22))
    .cc_text(@"445")
    .cc_addToView(_displayView);
    
    _displayView.height = _realMoneyLabel.bottom + RH(20);
}

- (void)cc_init {
    
}

- (void)update {
    
}

- (void)changedTextField:(id)textField {

    [self updateChargeFee];
}

@end
