//
//  BankCardManageViewController.m
//  CurrencyKit
//
//  Created by gwh on 2019/11/14.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "BankCardManageVC.h"
#import "BankCardAddVC.h"
#import "BankCardManageC.h"
#import "MyBankCardVC.h"

@interface BankCardManageVC ()

@property (nonatomic, retain) BankCardManageC *manage;

@end

@implementation BankCardManageVC

- (void)cc_viewDidPopFrom:(CC_ViewController *)viewController userInfo:(id)userInfo {
    
    if ([viewController isKindOfClass:MyBankCardVC.class]) {
        
        [_manage updateBankList];
    }
    
}

- (void)cc_viewWillLoad {
    
    self.cc_title = @"银行卡管理";
    
    self.view.backgroundColor = HEX(#F5F5F5);
    
    _manage = [ccs init:BankCardManageC.class];
    [self cc_registerController:_manage];
   
}

- (void)cc_viewDidLoad {
	 // Do any additional setup after loading the view.
    
    CC_Button *button = ccs.Button;
    button
    .cc_frame(WIDTH() - RH(35), RH(20), RH(20), RH(20))
    .cc_setImageForState(IMAGE(@"bankCard_add"), UIControlStateNormal)
    .cc_addToView(self.cc_navigationBar);
    
    button.bottom = self.cc_navigationBar.height - RH(12);
    [button cc_addTappedOnceDelay:.1 withBlock:^(CC_Button *btn) {
        
        id add = [ccs init:BankCardAddVC.class];
        [ccs pushViewController:add];
    }];
    
    
}

- (void)controller:(BankCardManageC *)controller tappedWithCardId:(NSString *)cardId {
    
    MyBankCardVC *vc = [ccs init:MyBankCardVC.class];
    vc.cardId = cardId;
    [ccs pushViewController:vc];
}

@end

