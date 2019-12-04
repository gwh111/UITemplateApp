//
//  ccs+AccountLib.h
//  AccountLib
//
//  Created by gwh on 2019/11/11.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "ccs.h"
#import "AccountLib.h"

NS_ASSUME_NONNULL_BEGIN

@interface ccs (AccountLib)

+ (Freeze *)accountLib_freeze;
+ (Deposit *)accountLib_deposit;
+ (Account *)accountLib_account;
+ (Withdraw *)accountLib_withdraw;

+ (void)accountLib_configureMainURLs:(NSArray *)urls;

/**
* 获取充值手续费
* @param pay  充值金额
* @param channelIndex  充值通道索引
*/
+ (CC_Money *)accountLib_getChargeMoneyWithPayMoney:(CC_Money *)pay channelIndex:(NSUInteger)channelIndex;

/**
* 获取提现手续费
* @param withdraw  提现金额
* @param isAccumulation  是否用累加方式
*/
+ (CC_Money *)accountLib_getChargeMoneyWithWithdrawMoney:(CC_Money *)withdraw isAccumulation:(BOOL)isAccumulation;

@end

NS_ASSUME_NONNULL_END
