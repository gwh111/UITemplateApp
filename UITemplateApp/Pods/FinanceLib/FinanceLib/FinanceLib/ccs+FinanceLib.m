//
//  ccs+FinanceLib.m
//  FinanceLib
//
//  Created by gwh on 2019/11/18.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "ccs+FinanceLib.h"

@implementation ccs (FinanceLib)

+ (Bank *)financeLib_bank {
    return FinanceLib.shared.bank;
}

+ (void)financeLib_configureMainURLs:(NSArray *)urls {
    FinanceService.shared.mainURLs = urls;
    FinanceService.shared.mainURL = urls[ccs.getEnvironment];
}

@end
