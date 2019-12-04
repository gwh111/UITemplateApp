//
//  ChargeViewController.m
//  CurrencyKit
//
//  Created by gwh on 2019/11/12.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "ChargeVC.h"
#import "ChargeMoneyInputC.h"
#import "ChargeMethodC.h"

@interface ChargeVC ()

@property (nonatomic, retain) ChargeMoneyInputC *chargeMoney;
@property (nonatomic, retain) ChargeMethodC *method;

@end

@implementation ChargeVC

- (void)cc_viewWillLoad {
   
    self.cc_title = @"充值";
    
    self.view.backgroundColor = HEX(#F5F5F5);
    
    _chargeMoney = [ccs init:ChargeMoneyInputC.class];
    [self cc_registerController:_chargeMoney];
    
    _method = [ccs init:ChargeMethodC.class];
    [self cc_registerController:_method];
}

- (void)cc_viewDidLoad {
	 // Do any additional setup after loading the view.
    
    [self.cc_displayView cc_tappedInterval:.1 withBlock:^(id  _Nonnull view) {
        [self.chargeMoney.moneyTextField resignFirstResponder];
    }];
    
    [self update];
}

- (void)update {
    
    _method.displayView.top = _chargeMoney.displayView.bottom;
    
    [self cc_adaptUI];
}

- (void)controller:(ChargeMoneyInputC *)controller moneyChanged:(CC_Money *)money {
    
    [_method updatePay:money];
}

- (void)finishUpdateController:(ChargeMethodC *)controller {
    
    [self update];
}



@end
