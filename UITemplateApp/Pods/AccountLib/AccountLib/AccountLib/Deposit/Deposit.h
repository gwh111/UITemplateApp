//
//  Deposit.h
//  AccountLib
//
//  Created by gwh on 2019/11/11.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountService.h"

NS_ASSUME_NONNULL_BEGIN

@interface Deposit : AccountService

- (void)configDepositAmountConfigQuery:(void(^)(HttpModel *httpModel))block;
- (void)depositAmountConfigQueryFinish:(HttpModel *)resultDic;

/**
* 充值金额配置查询
*/
- (void)depositAmountConfigQuerySuccess:(void(^)(HttpModel *result))successBlock
                                       fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock;

- (void)configDepositApply:(void(^)(HttpModel *httpModel))block;
- (void)depositApplyFinish:(HttpModel *)resultDic;

/**
* 充值申请
* @param chargeFee  服务费
* @param depositAmount  充值金额
* @param fundChannelId  资金通道id
*/
- (void)depositApplyWithChargeFee:(CC_Money *)chargeFee depositAmount:(CC_Money *)depositAmount fundChannelId:(NSString *)fundChannelId
                          success:(void(^)(HttpModel *result))successBlock
                             fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock;

- (void)configDepositApplyNeedIdentify:(void(^)(HttpModel *httpModel))block;
- (void)depositApplyNeedIdentifyFinish:(HttpModel *)resultDic;

/**
* 充值申请是否需要实名
*/
- (void)depositApplyNeedIdentifyWithSuccess:(void(^)(HttpModel *result))successBlock fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock;

- (void)configDepositReturn:(void(^)(HttpModel *httpModel))block;
- (void)depositReturnFinish:(HttpModel *)resultDic;

/**
* 充值回跳
* @param depositApplyNo  充值申请单号
*/
- (void)depositReturnWithDepositApplyNo:(NSString *)depositApplyNo success:(void(^)(HttpModel *result))successBlock fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock;

- (void)configFundChannelQuery:(void(^)(HttpModel *httpModel))block;
- (void)fundChannelQueryFinish:(HttpModel *)resultDic;

/**
* 资金通道查询
*/
- (void)fundChannelQueryWithSuccess:(void(^)(HttpModel *result))successBlock fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock;


@end

NS_ASSUME_NONNULL_END
