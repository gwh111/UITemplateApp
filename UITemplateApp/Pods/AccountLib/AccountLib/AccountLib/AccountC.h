//
//  AccountHelper.h
//  AccountLib
//
//  Created by gwh on 2019/11/18.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Foundation.h"
#import "ccs.h"
#import "WithdrawBasicInfoQueryModel.h"
#import "AccountWithdrawBankDefaultQueryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AccountC : NSObject

@property (nonatomic, retain) NSArray *fundChannels;
@property (nonatomic, retain) NSArray *withdrawChargeRangeConfigSimples;

@property (nonatomic, retain) WithdrawBasicInfoQueryModel *withdrawBasicInfoQueryModel;
@property (nonatomic, retain) AccountWithdrawBankDefaultQueryModel *accountWithdrawBankDefaultQueryModel;

+ (instancetype)shared;

- (CC_Money *)getChargeMoneyWithPayMoney:(CC_Money *)pay channelIndex:(NSUInteger)channelIndex;

- (CC_Money *)getChargeMoneyWithWithdrawMoney:(CC_Money *)withdraw isAccumulation:(BOOL)isAccumulation;

- (void)chargeWithChannel:(NSDictionary *)channelDic response:(NSDictionary *)responseDic;

@end

NS_ASSUME_NONNULL_END
