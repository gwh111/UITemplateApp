//
//  AccountLib.m
//  AccountLib
//
//  Created by gwh on 2019/11/11.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "AccountLib.h"

@implementation AccountLib

+ (instancetype)shared {
    return [ccs registerSharedInstance:self block:^{

        [AccountLib.shared start];
    }];
}

- (void)start {

    AccountLib.shared.account = [ccs init:Account.class];
    AccountLib.shared.deposit = [ccs init:Deposit.class];
    AccountLib.shared.freeze = [ccs init:Freeze.class];
    AccountLib.shared.withdraw = [ccs init:Withdraw.class];
}

@end
