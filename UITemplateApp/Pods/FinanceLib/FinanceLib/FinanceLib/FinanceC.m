//
//  FinanceController.m
//  FinanceLib
//
//  Created by gwh on 2019/11/18.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "FinanceC.h"

@implementation FinanceC

+ (instancetype)shared {
    return [ccs registerSharedInstance:self];
}

@end
