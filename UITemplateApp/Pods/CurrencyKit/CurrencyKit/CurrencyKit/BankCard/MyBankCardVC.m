//
//  MyBankCardViewController.m
//  CurrencyKit
//
//  Created by gwh on 2019/11/15.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "MyBankCardVC.h"
#import "CurrencyConfig.h"
#import "BankCardEditVC.h"

@interface MyBankCardVC ()

@property (nonatomic, retain) CC_View *cardView;
@property (nonatomic, retain) CC_ImageView *iconImageView;
@property (nonatomic, retain) CC_Label *bankNameLabel;
@property (nonatomic, retain) CC_Label *cardTypeLabel;
@property (nonatomic, retain) CC_Label *bankSubNameLabel;
@property (nonatomic, retain) CC_Label *bankCardNumberLabel;
@property (nonatomic, retain) CC_Button *setDefaultButton;

@end

@implementation MyBankCardVC

- (void)updateMyBank {
    [ccs.accountLib_withdraw accountWithdrawBankDetailQueryWithId:_cardId success:^(HttpModel * _Nonnull result) {
        
        [self update:result.resultDic[@"accountWithdrawBankSimple"]];
        
    } fail:^(NSString * _Nonnull errorMsg, HttpModel * _Nonnull result) {
        
        [ccs showNotice:errorMsg];
    }];
}

- (void)update:(NSDictionary *)bankDic {
    
    _bankNameLabel.text = bankDic[@"bankName"];
    _bankCardNumberLabel.text = bankDic[@"cardNo"];
    _bankSubNameLabel.text = bankDic[@"bankSubBranchName"];
    _cardTypeLabel.text = bankDic[@"cardType"][@"message"];
    
    WS(weakSelf)
    [_iconImageView cc_setImageWithURL:[NSURL URLWithString:bankDic[@"logoUrl"]] placeholderImage:nil processBlock:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, BOOL finished) {
        
        NSData *data = UIImageJPEGRepresentation(image, 1);
        UIImage *jpg = [UIImage imageWithData:data];
        UIColor *color = [CC_Color cc_colorOfImage:jpg];
        weakSelf.cardView.backgroundColor = color;
    }];
    
}

- (void)cc_viewWillLoad {
    
    self.cc_title = @"我的银行卡";
    
    self.view.backgroundColor = HEX(#F5F5F5);
   
    _cardView = ccs.View
    .cc_frame(0, 0, WIDTH(), RH(160))
    .cc_cornerRadius(10)
    .cc_backgroundColor(COLOR_LIGHT_RED)
    .cc_addToView(self);
    
    _iconImageView = ccs.ImageView
    .cc_frame(RH(20), RH(30), RH(30), RH(30))
    .cc_backgroundColor(UIColor.whiteColor)
    .cc_addToView(_cardView);
    
    _bankNameLabel = ccs.Label
    .cc_frame(_iconImageView.right + RH(10), RH(25), RH(200), RH(20))
    .cc_textColor(HEX(#ffffff))
    .cc_font(RF(17))
    .cc_text(@"中国工商银行")
    .cc_addToView(_cardView);
    
    _setDefaultButton = ccs.Button
    .cc_frame(_cardView.width - RH(90), _bankNameLabel.top, RH(70), RH(25))
    .cc_setTitleColorForState(HEX(#ffffff), UIControlStateNormal)
    .cc_font(RF(12))
    .cc_cornerRadius(4)
    .cc_borderColor(UIColor.whiteColor)
    .cc_borderWidth(1)
    .cc_setTitleForState(@"删除本账户", UIControlStateNormal)
    .cc_addToView(_cardView);
    
    _cardTypeLabel = ccs.Label
    .cc_frame(_iconImageView.right + RH(10), _bankNameLabel.bottom + RH(5), RH(200), RH(20))
    .cc_textColor(HEX(#ffffff))
    .cc_font(RF(12))
    .cc_text(@"储蓄卡")
    .cc_addToView(_cardView);
    
    _bankSubNameLabel = ccs.Label
    .cc_frame(_iconImageView.right + RH(10), _cardTypeLabel.bottom, RH(200), RH(30))
    .cc_textColor(HEX(#ffffff))
    .cc_font(RF(11))
    .cc_text(@"杭州文三路支行")
    .cc_addToView(_cardView);
    
    _bankCardNumberLabel = ccs.Label
    .cc_frame(_iconImageView.right + RH(10), _bankSubNameLabel.bottom, _cardView.width, RH(40))
    .cc_textColor(HEX(#ffffff))
    .cc_font(RF(20))
    .cc_text(@"****     ****     ****     6878")
    .cc_addToView(_cardView);
    
    UIColor *color = CurrencyConfig.shared.chooseButtonBorderColor;
    float radius = CurrencyConfig.shared.doneButtonRadius;
    CC_Button *doneButton = ccs.Button
    .cc_frame(RH(20), _cardView.bottom + RH(30), WIDTH() - RH(40), RH(40))
    .cc_setTitleColorForState(color, UIControlStateNormal)
    .cc_font(RF(15))
    .cc_cornerRadius(radius)
    .cc_borderColor(color)
    .cc_borderWidth(1)
    .cc_setTitleForState(@"修改银行卡信息", UIControlStateNormal)
    .cc_addToView(self);
    [doneButton cc_addTappedOnceDelay:.1 withBlock:^(CC_Button *btn) {
        
        BankCardEditVC *vc = [ccs init:BankCardEditVC.class];
        vc.cardId = self.cardId;
        [ccs pushViewController:vc];
    }];
}

- (void)cc_viewDidLoad {
	 // Do any additional setup after loading the view.
    
    [self updateMyBank];
    
    [_setDefaultButton cc_addTappedOnceDelay:.1 withBlock:^(CC_Button *btn) {
       
        [self delete];
    }];
}

- (void)delete {
    
    [ccs.accountLib_withdraw accountWithdrawBankDeleteWithId:_cardId success:^(HttpModel * _Nonnull result) {
        
        [ccs popViewController];
        [ccs showNotice:@"删除成功"];
    } fail:^(NSString * _Nonnull errorMsg, HttpModel * _Nonnull result) {
       
        [ccs showNotice:errorMsg];
    }];
}

@end
