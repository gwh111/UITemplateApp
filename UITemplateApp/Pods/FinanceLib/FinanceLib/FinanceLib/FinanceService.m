//
//  FinanceService.m
//  FinanceLib
//
//  Created by gwh on 2019/11/12.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "FinanceService.h"
#import "FinanceC.h"

@implementation FinanceService

+ (instancetype)shared {
    return [ccs registerSharedInstance:self block:^{
        FinanceService.shared.appCode = @"user.finance.api.mobile.base";
        FinanceService.shared.sourceVersion = @"1.2.20191024.63-SNAPSHOT";
    }];
}

@end
