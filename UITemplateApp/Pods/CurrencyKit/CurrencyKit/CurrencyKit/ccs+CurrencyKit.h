//
//  ccs+CurrenyKit.h
//  CurrencyKit
//
//  Created by gwh on 2019/11/12.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "ccs.h"

#import "CurrencyConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface ccs (CurrencyKit)

+ (CurrencyConfig *)currencyKit_config;

// 充值
+ (void)currencyKit_pushChargeViewController;

// 提现
+ (void)currencyKit_pushWithdrawViewController;

// 收支明细
+ (void)currencyKit_pushAccountDetailViewController;

// 银行卡管理
+ (void)currencyKit_pushBankCardManageViewController;

// 冻结明细
+ (void)currencyKit_pushFreezeDetailViewController;

@end

NS_ASSUME_NONNULL_END
