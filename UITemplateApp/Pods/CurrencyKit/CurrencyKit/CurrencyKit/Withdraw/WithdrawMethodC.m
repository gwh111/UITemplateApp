//
//  WithdrawMethodController.m
//  CurrencyKit
//
//  Created by gwh on 2019/11/12.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "WithdrawMethodC.h"

@interface WithdrawMethodC ()

@property (nonatomic, retain) CC_ImageView *iconImageView;
@property (nonatomic, retain) CC_Label *bankNameLabel;
@property (nonatomic, retain) CC_Label *cardNumberLabel;
@property (nonatomic, retain) AccountWithdrawBankDefaultQueryModel *accountWithdrawBankDefaultQueryModel;

@end

@implementation WithdrawMethodC

- (void)updateWithdrawBank {
    
    [ccs.accountLib_withdraw accountWithdrawBankDefaultQuerySuccess:^(HttpModel * _Nonnull result) {
        
        self.accountWithdrawBankDefaultQueryModel = AccountC.shared.accountWithdrawBankDefaultQueryModel;
        [self update];
        
    } fail:^(NSString * _Nonnull errorMsg, HttpModel * _Nonnull result) {
        
    }];
}

- (void)cc_willInit {

    _displayView = ccs.View;
    
    _displayView
    .cc_frame(0, 0, WIDTH(), RH(300))
    .cc_addToView(self.cc_displayView);
    
    CC_Label *chooseTextLabel = ccs.Label;
    chooseTextLabel
    .cc_frame(RH(15), RH(10), RH(100), RH(35))
    .cc_textColor(HEX(#666666))
    .cc_font(RF(13))
    .cc_text(@"请选择提现银行卡")
    .cc_addToView(_displayView);
    
    CC_View *bankCardView = ccs.View
    .cc_frame(0, chooseTextLabel.bottom, WIDTH(), RH(80))
    .cc_backgroundColor(UIColor.whiteColor)
    .cc_addToView(_displayView);
    [bankCardView cc_tappedInterval:.1 withBlock:^(id  _Nonnull view) {
        [self.cc_delegate cc_performSelector:@selector(popBankCardView) params:nil];
    }];
    
    {
        _iconImageView = ccs.ImageView
        .cc_frame(RH(20), RH(20), RH(40), RH(40))
        .cc_backgroundColor(UIColor.grayColor)
        .cc_addToView(bankCardView);
        
        _bankNameLabel = ccs.Label
        .cc_frame(_iconImageView.right + RH(10), RH(23), bankCardView.width - RH(50), RH(22))
        .cc_textColor(HEX(#333333))
        .cc_font(BRF(16))
        .cc_text(@"招商银行")
        .cc_addToView(bankCardView);
        
        _cardNumberLabel = ccs.Label
        .cc_frame(_iconImageView.right + RH(10), _bankNameLabel.bottom, _bankNameLabel.width, RH(22))
        .cc_textColor(HEX(#333333))
        .cc_font(BRF(15))
        .cc_text(@"**** **** **** 4565")
        .cc_addToView(bankCardView);
    }
    
    NSMutableAttributedString *att = ccs.mutableAttributedString;
    CC_TextAttachment *attachment = ccs.textAttachment;
    attachment.image = IMAGE(@"withdraw_ask.png");
    attachment.emojiSize = 14;
    attachment.offsetY = -2;
    [att appendAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
    [att cc_appendAttStr:@" 提现说明" color:HEX(#666666) font:RF(12)];
    
    _withdrawAskButton = ccs.Button
    .cc_frame(RH(20), bankCardView.bottom + RH(15), RH(200), RH(30))
    .cc_setAttributedTitleForState(att, UIControlStateNormal)
    .cc_addToView(_displayView);
    _withdrawAskButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    CC_Button *withdrawDetailButton = ccs.Button
    .cc_frame(WIDTH() - RH(80), bankCardView.bottom + RH(15), RH(60), RH(30))
    .cc_setTitleColorForState(HEX(#666666), UIControlStateNormal)
    .cc_setTitleForState(@"提现明细", UIControlStateNormal)
    .cc_font(RF(12))
    .cc_addToView(_displayView);
    withdrawDetailButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [withdrawDetailButton cc_addTappedOnceDelay:.1 withBlock:^(CC_Button *btn) {
        [self.cc_delegate cc_performSelector:@selector(gotoWithdrawDetailViewController) params:nil];
    }];
    
    _displayView.height = withdrawDetailButton.bottom;
    
    [self updateWithdrawBank];
}

- (void)update {
    
    _bankNameLabel.text = _accountWithdrawBankDefaultQueryModel.bankName;
    _cardNumberLabel.text = _accountWithdrawBankDefaultQueryModel.cardNo;
}

- (void)update:(NSDictionary *)accountWithdrawBankSimple {

    _bankNameLabel.text = accountWithdrawBankSimple[@"bankName"];
    _cardNumberLabel.text = accountWithdrawBankSimple[@"cardNo"];
}

@end
