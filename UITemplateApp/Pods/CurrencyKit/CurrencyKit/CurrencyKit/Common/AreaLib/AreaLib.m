//
//  AreaLib.m
//  CurrencyKit
//
//  Created by gwh on 2019/11/19.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "AreaLib.h"

@implementation AreaLib

+ (instancetype)shared {
    return [ccs registerSharedInstance:self block:^{

        [AreaLib.shared start];
    }];
}

- (void)start {

    Area *area = [ccs init:Area.class];
    AreaLib.shared.area = area;
}

@end
