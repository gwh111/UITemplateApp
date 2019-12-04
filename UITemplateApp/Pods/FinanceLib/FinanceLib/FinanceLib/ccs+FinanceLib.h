//
//  ccs+FinanceLib.h
//  FinanceLib
//
//  Created by gwh on 2019/11/18.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "ccs.h"
#import "FinanceLib.h"

NS_ASSUME_NONNULL_BEGIN

@interface ccs (FinanceLib)

+ (Bank *)financeLib_bank;

+ (void)financeLib_configureMainURLs:(NSArray *)urls;

@end

NS_ASSUME_NONNULL_END
