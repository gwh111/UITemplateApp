//
//  BankCardAddViewController.m
//  CurrencyKit
//
//  Created by gwh on 2019/11/13.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "BankCardAddVC.h"
#import "BankCardEditC.h"
#import "CurrencyConfig.h"
#import "SubBankChooseVC.h"
#import "BankChooseC.h"
#import "AreaChooseC.h"

@interface BankCardAddVC ()

@property (nonatomic, retain) BankCardEditC *edit;
@property (nonatomic, retain) BankChooseC *bankChoose;
@property (nonatomic, retain) AreaChooseC *areaChoose;
@property (nonatomic, retain) CC_Button *addButton;

@property (nonatomic, retain) NSDictionary *bankDic;
@property (nonatomic, retain) NSDictionary *subBankDic;
@property (nonatomic, retain) NSString *cityId;
@property (nonatomic, retain) NSString *provinceId;
@property (nonatomic, retain) NSString *defaultSelect;

@end

@implementation BankCardAddVC

- (void)addBankCard {
    
    NSString *bankCode = [ccs string:@"%@", _bankDic[@"id"]];
    [ccs.accountLib_withdraw accountWithdrawBankCreateWithBankCode:bankCode bankSubBranchId:@"" cardNo:_edit.cardNumberTextField.text cityId:_cityId defaultSelect:_edit.defaultSelectSwitch.on provinceId:_provinceId success:^(HttpModel * _Nonnull result) {
        
        [ccs popViewController];
        [ccs showNotice:@"添加成功"];
    } fail:^(NSString * _Nonnull errorMsg, HttpModel * _Nonnull result) {
        
        [ccs showNotice:errorMsg];
    }];
    
}

- (void)cc_viewDidPopFrom:(CC_ViewController *)viewController userInfo:(id)userInfo {
    
    if ([viewController isKindOfClass:SubBankChooseVC.class]) {

        _subBankDic = userInfo;
        [_edit updateSubBank:_subBankDic[@"bankSubbranchName"]];
    }
}

- (void)cc_viewWillLoad {
    
    self.cc_title = @"添加银行卡";
    
    self.view.backgroundColor = HEX(#F5F5F5);
   
    _edit = [ccs init:BankCardEditC.class];
    [self cc_registerController:_edit];
    
    _bankChoose = [ccs init:BankChooseC.class];
    [self cc_registerController:_bankChoose];
    
    _areaChoose = [ccs init:AreaChooseC.class];
    [self cc_registerController:_areaChoose];
    
}

- (void)cc_viewDidLoad {
	 // Do any additional setup after loading the view.
    
    UIColor *buttonColor = CurrencyConfig.shared.doneButtonColor;
    UIColor *buttonTitleColor = CurrencyConfig.shared.doneButtonTextColor;
    float buttonRadius = CurrencyConfig.shared.doneButtonRadius;
    
    _addButton = ccs.Button
    .cc_frame(RH(20), _edit.displayView.bottom + RH(50), WIDTH() - RH(40), RH(40))
    .cc_cornerRadius(buttonRadius)
    .cc_setBackgroundColorForState(HEX(#D7D9DB), UIControlStateNormal)
    .cc_setBackgroundColorForState(buttonColor, UIControlStateHighlighted)
    .cc_setTitleColorForState(buttonTitleColor, UIControlStateNormal)
    .cc_setTitleForState(@"确认添加", UIControlStateNormal)
    .cc_addToView(self);
    [_addButton cc_addTappedOnceDelay:.1 withBlock:^(CC_Button *btn) {
        [self addBankCard];
    }];
    
    [self update];
}

- (void)update {
    
    _addButton.top = _edit.displayView.bottom + RH(20);
    
    [self cc_adaptUI];
}

- (void)popBankChooseController {
    
    [_bankChoose showBankChooseOn:self.view];
}

- (void)popAreaChooseViewController {
    
    [_areaChoose showAreaChooseOn:self.view];
}

- (void)gotoSubBankChooseViewController {
    
    SubBankChooseVC *detail = [ccs init:SubBankChooseVC.class];
    detail.bankId = _bankDic[@"id"];
    [ccs pushViewController:detail];
}

- (void)controller:(BankChooseC *)controller tappedWithBankDic:(NSDictionary *)bankDic {
    
    _bankDic = bankDic;
    [_edit updateBank:bankDic[@"name"]];
}

- (void)controller:(AreaChooseC *)controller tappedArea:(NSArray *)areaList {
    
    NSString *name = @"";
    for (int i = 0; i < areaList.count; i++) {
        name = [ccs string:@"%@%@",name ,areaList[i][@"name"]];
    }
    [_edit updateArea:name];
    
    _provinceId = [ccs string:@"%@", areaList[0][@"id"]];
    _cityId = [ccs string:@"%@", areaList[1][@"id"]];
}

- (void)updateInfoFinish:(BOOL)finish {
    
    _addButton.highlighted = finish;
}

@end
