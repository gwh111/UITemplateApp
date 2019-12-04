//
//  FinanceLib.h
//  FinanceLib
//
//  Created by gwh on 2019/11/12.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ccs.h"
#import "FinanceC.h"
#import "Bank.h"

NS_ASSUME_NONNULL_BEGIN

@interface FinanceLib : NSObject

@property (nonatomic, retain) Bank *bank;

+ (instancetype)shared;

@end

NS_ASSUME_NONNULL_END
