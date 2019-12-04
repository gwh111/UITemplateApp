//
//  ccs+CurrenyKit.m
//  CurrencyKit
//
//  Created by gwh on 2019/11/12.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "ccs+CurrencyKit.h"

#import "CurrencyKit.h"

@implementation ccs (CurrencyKit)

+ (CurrencyConfig *)currencyKit_config {
    return CurrencyConfig.shared;
}

+ (void)currencyKit_pushChargeViewController {
    id vc = [ccs init:ChargeVC.class];
    [ccs pushViewController:vc];
}

+ (void)currencyKit_pushWithdrawViewController {
    id vc = [ccs init:WithdrawVC.class];
    [ccs pushViewController:vc];
}

+ (void)currencyKit_pushAccountDetailViewController {
    id vc = [ccs init:AccountDetailVC.class];
    [ccs pushViewController:vc];
}

+ (void)currencyKit_pushBankCardManageViewController {
    id vc = [ccs init:BankCardManageVC.class];
    [ccs pushViewController:vc];
}

+ (void)currencyKit_pushFreezeDetailViewController {
    id vc = [ccs init:FreezeDetailVC.class];
    [ccs pushViewController:vc];
}

@end
