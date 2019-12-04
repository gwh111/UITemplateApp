//
//  AccountService.m
//  AccountLib
//
//  Created by gwh on 2019/11/11.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "AccountService.h"

@implementation AccountService

+ (instancetype)shared {
    return [ccs registerSharedInstance:self block:^{
        AccountService.shared.appCode = @"user.account.api.mobile.base";
        AccountService.shared.sourceVersion = @"1.2.20191024.63-SNAPSHOT";
    }];
}

@end
