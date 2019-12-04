//
//  AccountHelper.m
//  AccountLib
//
//  Created by gwh on 2019/11/18.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "AccountC.h"

@interface AccountC ()

@property (nonatomic, retain) CC_Money *payMoney;
@property (nonatomic, retain) CC_Money *chargeMoney;
@property (nonatomic, assign) NSUInteger currentIndex;
@property (nonatomic, retain) NSArray *fundChannelChargeRanges;

@end

@implementation AccountC

+ (instancetype)shared {
    return [ccs registerSharedInstance:self];
}

- (void)chargeWithChannel:(NSDictionary *)channelDic response:(NSDictionary *)responseDic {
    
    // 建一个charge类 挂在controller上
}

- (CC_Money *)getChargeMoneyWithWithdrawMoney:(CC_Money *)withdraw isAccumulation:(BOOL)isAccumulation {
    
    if (!_withdrawChargeRangeConfigSimples) {
        CCLOG(@"没有提现手续费区间");
    }

    if (isAccumulation) {
//        _withdrawChargeRangeConfigSimples = @[@{
//          @"chargeFee": @0.2,
//          @"chargeRate": @0.1,
//          @"fundChannelId": @4921,
//          @"id": @4251,
//          @"includeMax": @YES,
//          @"includeMin": @NO,
//          @"maxAmount": @84.49,
//          @"maxChargeFee": @37.2,
//          @"minAmount": @0
//        },];
        
        return [self getAccumulationChargeMoneyWithPayMoney:withdraw fundChannelChargeRanges:_withdrawChargeRangeConfigSimples];
    } else {
        
        return [self getNormalChargeMoneyWithPayMoney:withdraw fundChannelChargeRanges:_withdrawChargeRangeConfigSimples];
    }
    
    return nil;
}

- (CC_Money *)getChargeMoneyWithPayMoney:(CC_Money *)pay channelIndex:(NSUInteger)channelIndex {
    
    if (_fundChannels.count <= 0) {
        CCLOG(@"没有充值通道");
    }
//    _fundChannelChargeRanges = _fundChannels[channelIndex][@"fundChannelChargeRanges"];
    
    _fundChannelChargeRanges = @[@{
      @"chargeFee": @0.2,
      @"chargeRate": @0.1,
      @"fundChannelId": @4921,
      @"id": @4251,
      @"includeMax": @YES,
      @"includeMin": @NO,
      @"maxAmount": @84.49,
      @"maxChargeFee": @37.2,
      @"minAmount": @0
    },];
    
    return [self getAccumulationChargeMoneyWithPayMoney:pay fundChannelChargeRanges:_fundChannelChargeRanges];
}

#pragma mark common
- (CC_Money *)getNormalChargeMoneyWithPayMoney:(CC_Money *)pay fundChannelChargeRanges:(NSArray *)fundChannelChargeRanges {

    double calMoney = 0;
    double payMoney = pay.value.doubleValue;
    
    for (int i = 0; i < fundChannelChargeRanges.count; i++) {
        
        NSDictionary *rangeDic = fundChannelChargeRanges[i];
        BOOL includeMax = [rangeDic[@"includeMax"]boolValue];
        BOOL includeMin = [rangeDic[@"includeMin"]boolValue];
        float chargeFee = [rangeDic[@"chargeFee"]floatValue];
        float chargeRate = [rangeDic[@"chargeRate"]floatValue];
        float maxAmount = [rangeDic[@"maxAmount"]floatValue];
        float minAmount = [rangeDic[@"minAmount"]floatValue];
        float maxChargeFee = [rangeDic[@"maxChargeFee"]floatValue];
        float add = 0;
        BOOL isLarger = NO;
        BOOL isSmaller = NO;
        if (includeMin) {
            if (payMoney >= minAmount) {
                isLarger = YES;
            }
        } else {
            if (payMoney > minAmount) {
                isLarger = YES;
            }
        }
        if (includeMax) {
            if (payMoney <= maxAmount) {
                isSmaller = YES;
            }
        } else {
            if (payMoney < maxAmount) {
                isSmaller = YES;
            }
        }
        if (isLarger == NO) {
            // 没到区间 不算
        } else if (isSmaller == NO) {
            // 全算
        } else {
            // 中间
            float section = payMoney;
            add = chargeFee + chargeRate * section;
            break;
        }
        if (add > maxChargeFee) {
            add = maxChargeFee;
        }
        calMoney = calMoney + add;
    }
    
    CC_Money *chargeMoney = ccs.money;
    [chargeMoney moneyWithString:[ccs string:@"%f", calMoney]];
    
    return chargeMoney;
}

- (CC_Money *)getAccumulationChargeMoneyWithPayMoney:(CC_Money *)pay fundChannelChargeRanges:(NSArray *)fundChannelChargeRanges {
    
    double calMoney = 0;
    double payMoney = pay.value.doubleValue;
    
    for (int i = 0; i < _fundChannelChargeRanges.count; i++) {
        
        NSDictionary *rangeDic = _fundChannelChargeRanges[i];
        BOOL includeMax = [rangeDic[@"includeMax"]boolValue];
        BOOL includeMin = [rangeDic[@"includeMin"]boolValue];
        float chargeFee = [rangeDic[@"chargeFee"]floatValue];
        float chargeRate = [rangeDic[@"chargeRate"]floatValue];
        float maxAmount = [rangeDic[@"maxAmount"]floatValue];
        float minAmount = [rangeDic[@"minAmount"]floatValue];
        float maxChargeFee = [rangeDic[@"maxChargeFee"]floatValue];
        float add = 0;
        BOOL isLarger = NO;
        BOOL isSmaller = NO;
        if (includeMin) {
            if (payMoney >= minAmount) {
                isLarger = YES;
            }
        } else {
            if (payMoney > minAmount) {
                isLarger = YES;
            }
        }
        if (includeMax) {
            if (payMoney <= maxAmount) {
                isSmaller = YES;
            }
        } else {
            if (payMoney < maxAmount) {
                isSmaller = YES;
            }
        }
        if (isLarger == NO) {
            // 没到区间 不算
        } else if (isSmaller == NO) {
            // 全算
            float section = maxAmount - minAmount;
            add = chargeRate * section;
        } else {
            // 中间
            float section = maxAmount - payMoney;
            add = chargeFee + chargeRate * section;
        }
        if (add > maxChargeFee) {
            add = maxChargeFee;
        }
        calMoney = calMoney + add;
    }
    
    CC_Money *chargeMoney = ccs.money;
    [chargeMoney moneyWithString:[ccs string:@"%f", calMoney]];
    
    return chargeMoney;
}

@end
