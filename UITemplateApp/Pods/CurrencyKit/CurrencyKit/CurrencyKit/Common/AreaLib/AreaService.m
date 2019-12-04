//
//  AreaController.m
//  CurrencyKit
//
//  Created by gwh on 2019/11/19.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "AreaService.h"

@implementation AreaService

+ (instancetype)shared {
    return [ccs registerSharedInstance:self block:^{
        AreaService.shared.appCode = @"user.area.api.mobile.base";
        AreaService.shared.sourceVersion = @"1.2.20191024.63-SNAPSHOT";
    }];
}

@end
