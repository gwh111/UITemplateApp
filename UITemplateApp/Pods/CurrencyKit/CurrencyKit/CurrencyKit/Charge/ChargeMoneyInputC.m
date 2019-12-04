//
//  ChargeMoneyChooseController.m
//  CurrencyKit
//
//  Created by gwh on 2019/11/12.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "ChargeMoneyInputC.h"

@interface ChargeMoneyInputC ()

@property (nonatomic, retain) CC_LabelGroup *moneyGroup;
@property (nonatomic, retain) NSArray *moneyTextList;

@end

@implementation ChargeMoneyInputC

- (void)updateChargeMoney {
    
    [ccs.accountLib_deposit depositAmountConfigQuerySuccess:^(HttpModel * _Nonnull result) {
        
//        NSArray *moneyList = @[@"1.01元", @"0.01元", @"0.02元",
//                               @"0.01元", @"0.01元"];
        self.moneyTextList = result.resultDic[@"amountList"];
        [self updateWithMoneyList:self.moneyTextList];
        
    } fail:^(NSString * _Nonnull errorMsg, HttpModel * _Nonnull result) {
        
        [ccs showNotice:errorMsg];
    }];
    
}


- (void)cc_willInit {
    
    _displayView = ccs.View;
    
    _displayView
    .cc_frame(0, 0, WIDTH(), RH(300))
    .cc_backgroundColor(UIColor.whiteColor)
    .cc_addToView(self.cc_displayView);
    
    CC_Label *accountTextLabel = ccs.Label;
    accountTextLabel
    .cc_frame(RH(15), RH(15), RH(50), RH(35))
    .cc_textColor(HEX(#333333))
    .cc_font(RF(13))
    .cc_text(@"账户：")
    .cc_addToView(_displayView);
    
    CC_Label *accountLabel = ccs.Label;
    accountLabel
    .cc_frame(accountTextLabel.right, RH(15), RH(200), RH(35))
    .cc_textColor(HEX(#333333))
    .cc_font(RF(22))
    .cc_text(@"amsde")
    .cc_addToView(_displayView);
    
    CC_Label *chargeMoneyTextLabel = ccs.Label;
    chargeMoneyTextLabel
    .cc_frame(RH(15), accountTextLabel.bottom + RH(10), RH(60), RH(35))
    .cc_textColor(HEX(#333333))
    .cc_font(RF(15))
    .cc_text(@"充值金额")
    .cc_addToView(_displayView);
    
    CC_Label *markTextLabel = ccs.Label;
    markTextLabel
    .cc_frame(RH(15), chargeMoneyTextLabel.bottom + RH(10), RH(30), RH(35))
    .cc_textColor(HEX(#333333))
    .cc_font(RF(19))
    .cc_text(@"¥")
    .cc_addToView(_displayView);
    
    _moneyTextField = ccs.TextField;
    _moneyTextField
    .cc_frame(markTextLabel.right, markTextLabel.top, WIDTH() - RH(100), RH(35))
    .cc_placeholder(@"请输入金额")
    .cc_font(RF(22))
    .cc_addToView(_displayView);
    _moneyTextField.delegate = self;
    _moneyTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_moneyTextField addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventEditingChanged];
    
    CC_Label *yuanTextLabel = ccs.Label;
    yuanTextLabel
    .cc_frame(_moneyTextField.right, chargeMoneyTextLabel.bottom + RH(10), RH(30), RH(35))
    .cc_textColor(HEX(#BFBFBF))
    .cc_font(RF(15))
    .cc_text(@"元")
    .cc_addToView(_displayView);
    
    ccs.View
    .cc_frame(markTextLabel.left, markTextLabel.bottom, WIDTH() - RH(50), 1)
    .cc_backgroundColor(HEX(#F5F5F5))
    .cc_addToView(_displayView);
    
    CC_Label *moneyChooseTextLabel = ccs.Label;
    moneyChooseTextLabel
    .cc_frame(RH(15), markTextLabel.bottom + RH(10), RH(200), RH(35))
    .cc_textColor(HEX(#333333))
    .cc_font(RF(12))
    .cc_text(@"选择充值金额")
    .cc_addToView(_displayView);
    
    _moneyGroup = ccs.LabelGroup;
    _moneyGroup
    .cc_frame(0, moneyChooseTextLabel.bottom, RH(200), RH(35))
    .cc_addToView(_displayView);
    _moneyGroup.delegate = self;
    _moneyGroup.itemWidth = RH(110);
    [_moneyGroup updateType:CCLabelAlignmentTypeLeft width:WIDTH() stepWidth:RH(10) sideX:RH(15) sideY:RH(10) itemHeight:RH(35) margin:RH(60)];
    
//    _moneyTextList = @[@"0.01元", @"0.01元", @"0.02元",
//                        @"0.01元", @"0.01元", @"0.01元", @"0.01元"];
//    [_moneyGroup updateLabels:_moneyTextList selected:@[@"1", @"0", @"0", @"0", @"0", @"0", @"0"]];
    
    [self updateChargeMoney];
}

- (void)cc_init {
    
}

- (void)updateWithMoneyList:(NSArray *)moneyList {
    
    NSMutableArray *select = ccs.mutArray;
    NSMutableArray *moneyListText = ccs.mutArray;
    int count = (int)moneyList.count;
    for (int i = 0; i < count; i++) {
        if (i == 0) {
            [select cc_addObject:@"1"];
        } else {
            [select cc_addObject:@"0"];
        }
        [moneyListText addObject:[ccs string:@"%@元",moneyList[i]]];
    }
    [_moneyGroup updateLabels:moneyListText selected:select];
    
    if (moneyList.count > 0) {
        _moneyTextField.text = [ccs string:@"%@", moneyList[0]];
    }
    [self updateText];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    [_moneyGroup clearSelect];
    if (textField.text.length >= 8) {
        if (string.length > 0) {
            return NO;
        }
    }
    return YES;
}

- (void)changedTextField:(id)textField {
    
    [self updateText];
}

- (void)labelGroup:(CC_LabelGroup *)group initWithButton:(CC_Button *)button {
    
    button.cc_cornerRadius(4)
    .cc_setTitleColorForState(HEX(#F8492F), UIControlStateNormal)
    .cc_setTitleColorForState(UIColor.whiteColor, UIControlStateSelected)
    .cc_setBackgroundColorForState(UIColor.whiteColor, UIControlStateNormal)
    .cc_setBackgroundColorForState(HEX(#F8492F), UIControlStateSelected)
    .cc_borderColor(HEX(#F8492F))
    .cc_borderWidth(1);
}

- (void)labelGroup:(CC_LabelGroup *)group button:(UIButton *)button tappedAtIndex:(NSUInteger)index {
    
    [group clearSelect];
    [group updateSelect:YES atIndex:(int)index];
    NSString *text = [ccs string:@"%@", _moneyTextList[index]];
    _moneyTextField.text = text;
    [self updateText];
}

- (void)labelGroupInitFinish:(CC_LabelGroup *)group {
    
    _displayView.height = group.bottom + RH(10);
}

- (void)updateText {
    
    NSString *text = _moneyTextField.text;
    
    CC_Money *money = [ccs init:CC_Money.class];
    [money moneyWithString:text];
    
    CCLOG(@"%@", money.value);
    [self.cc_delegate cc_performSelector:@selector(controller:moneyChanged:) params:self, money];
}

@end
