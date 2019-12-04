//
//  FinanceLib.m
//  FinanceLib
//
//  Created by gwh on 2019/11/12.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "FinanceLib.h"

@implementation FinanceLib

+ (instancetype)shared {
    return [ccs registerSharedInstance:self block:^{
        FinanceLib.shared.bank = [ccs init:Bank.class];
    }];
}

@end
