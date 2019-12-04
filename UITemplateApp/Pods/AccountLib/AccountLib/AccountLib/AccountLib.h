//
//  AccountLib.h
//  AccountLib
//
//  Created by gwh on 2019/11/11.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Foundation.h"

#import "Account.h"
#import "Deposit.h"
#import "Freeze.h"
#import "Withdraw.h"

#import "AccountC.h"

NS_ASSUME_NONNULL_BEGIN

@interface AccountLib : NSObject

@property (nonatomic, retain) Account *account;
@property (nonatomic, retain) Deposit *deposit;
@property (nonatomic, retain) Freeze *freeze;
@property (nonatomic, retain) Withdraw *withdraw;

+ (instancetype)shared;

@end

NS_ASSUME_NONNULL_END
