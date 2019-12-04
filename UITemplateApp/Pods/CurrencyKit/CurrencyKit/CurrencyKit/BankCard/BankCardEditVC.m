//
//  BankCardEditViewController.m
//  CurrencyKit
//
//  Created by gwh on 2019/11/14.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "BankCardEditVC.h"
#import "BankCardEditC.h"
#import "CurrencyConfig.h"
#import "SubBankChooseVC.h"
#import "BankChooseC.h"
#import "AreaChooseC.h"

@interface BankCardEditVC ()

@property (nonatomic, retain) BankCardEditC *edit;
@property (nonatomic, retain) BankChooseC *bankChoose;
@property (nonatomic, retain) AreaChooseC *areaChoose;
@property (nonatomic, retain) CC_Button *editButton;

@property (nonatomic, retain) NSDictionary *subBankDic;

@end

@implementation BankCardEditVC

- (void)updateBankInfo {
    
    [ccs.accountLib_withdraw accountWithdrawBankDetailQueryWithId:_cardId success:^(HttpModel * _Nonnull result) {
        
        NSDictionary *infoDic = result.resultDic[@"accountWithdrawBankSimple"];
        NSString *cardNo = infoDic[@"cardNo"];
        NSString *bankName = infoDic[@"bankName"];
        NSString *bankSubBranchName = infoDic[@"bankSubBranchName"];
        NSString *city;
        NSString *province;
        NSString *area = @"";
        if (![ccs function_isEmpty:infoDic[@"citySimple"]]) {
            city = infoDic[@"citySimple"][@"name"];
            area = [ccs string:@"%@", city];
        }
        if (![ccs function_isEmpty:infoDic[@"citySimple"]]) {
            province = infoDic[@"provinceSimple"][@"name"];
            area = [ccs string:@"%@ %@", area, province];
        }
        [self.edit updateCardNumber:cardNo];
        [self.edit updateArea:area];
        [self.edit updateBank:bankName];
        [self.edit updateSubBank:bankSubBranchName];
        
    } fail:^(NSString * _Nonnull errorMsg, HttpModel * _Nonnull result) {
        
    }];
}

- (void)cc_viewDidPopFrom:(CC_ViewController *)viewController userInfo:(id)userInfo {
    
    if ([viewController isKindOfClass:SubBankChooseVC.class]) {

        _subBankDic = userInfo;
        [_edit updateSubBank:_subBankDic[@"bankSubbranchName"]];
    }
}

- (void)cc_viewWillLoad {
    
    self.cc_title = @"修改银行卡信息";
    
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
    
    _editButton = ccs.Button
    .cc_frame(RH(20), _edit.displayView.bottom + RH(50), WIDTH() - RH(40), RH(40))
    .cc_cornerRadius(buttonRadius)
    .cc_backgroundColor(buttonColor)
    .cc_setBackgroundColorForState(HEX(#D7D9DB), UIControlStateNormal)
    .cc_setBackgroundColorForState(buttonColor, UIControlStateHighlighted)
    .cc_setTitleColorForState(buttonTitleColor, UIControlStateNormal)
    .cc_setTitleForState(@"确认", UIControlStateNormal)
    .cc_addToView(self);
    [_editButton cc_addTappedOnceDelay:.1 withBlock:^(CC_Button *btn) {
        [self editBankCard];
    }];
    
    [self updateBankInfo];
    [self update];
}

- (void)update {
    
    _editButton.top = _edit.displayView.bottom + RH(20);
    
    [self cc_adaptUI];
}

- (void)popBankChooseController {
    
    [_bankChoose showBankChooseOn:self.view];
}

- (void)popAreaChooseViewController {
    
    [_areaChoose showAreaChooseOn:self.view];
}

- (void)controller:(BankChooseC *)controller tappedWithBankDic:(NSDictionary *)bankDic {
    
//    _bankDic = bankDic;
    [_edit updateBank:bankDic[@"name"]];
}

- (void)controller:(AreaChooseC *)controller tappedArea:(NSArray *)areaList {
    
    NSString *name = @"";
    for (int i = 0; i < areaList.count; i++) {
        name = [ccs string:@"%@%@",name ,areaList[i][@"name"]];
    }
    [_edit updateArea:name];
}

- (void)updateInfoFinish:(BOOL)finish {
    
    _editButton.highlighted = finish;
}

- (void)editBankCard {
    
    [ccs.accountLib_withdraw accountWithdrawBankModifyWithBankSubBranchId:@"" cityId:@"" defaultSelect:YES aId:_cardId provinceId:@"" success:^(HttpModel * _Nonnull result) {
        
        [ccs popViewController];
        [ccs showNotice:@"修改成功"];
    } fail:^(NSString * _Nonnull errorMsg, HttpModel * _Nonnull result) {
        
        [ccs showNotice:errorMsg];
    }];
}

@end
