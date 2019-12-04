//
//  ccs+AccountLib.m
//  AccountLib
//
//  Created by gwh on 2019/11/11.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "ccs+AccountLib.h"

@implementation ccs (AccountLib)

+ (Freeze *)accountLib_freeze {
    return AccountLib.shared.freeze;
}

+ (Deposit *)accountLib_deposit {
    return AccountLib.shared.deposit;
}

+ (Account *)accountLib_account {
    return AccountLib.shared.account;
}

+ (Withdraw *)accountLib_withdraw {
    return AccountLib.shared.withdraw;
}

+ (void)accountLib_configureMainURLs:(NSArray *)urls {
    AccountService.shared.mainURLs = urls;
    AccountService.shared.mainURL = urls[ccs.getEnvironment];
}

+ (CC_Money *)accountLib_getChargeMoneyWithPayMoney:(CC_Money *)pay channelIndex:(NSUInteger)channelIndex {
    return [AccountC.shared getChargeMoneyWithPayMoney:pay channelIndex:channelIndex];
}

+ (CC_Money *)accountLib_getChargeMoneyWithWithdrawMoney:(CC_Money *)withdraw isAccumulation:(BOOL)isAccumulation {
    return [AccountC.shared getChargeMoneyWithWithdrawMoney:withdraw isAccumulation:isAccumulation];
}

@end
