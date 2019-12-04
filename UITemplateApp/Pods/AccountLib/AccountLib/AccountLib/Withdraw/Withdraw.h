//
//  Withdraw.h
//  AccountLib
//
//  Created by gwh on 2019/11/14.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountService.h"

NS_ASSUME_NONNULL_BEGIN

@interface Withdraw : AccountService

- (void)configAccountWithdrawBankCreate:(void(^)(HttpModel *httpModel))block;
- (void)accountWithdrawBankCreateFinish:(HttpModel *)resultDic;

/**
* 账户提现银行信息创建
* @param bankCode  银行代码
* @param bankSubBranchId  支行id
* @param cardNo  卡号
* @param cityId  城市id
* @param defaultSelect  是否默认
* @param provinceId  省id
*/
- (void)accountWithdrawBankCreateWithBankCode:(NSString *)bankCode bankSubBranchId:(NSString *)bankSubBranchId cardNo:(NSString *)cardNo cityId:(NSString *)cityId defaultSelect:(BOOL)defaultSelect provinceId:(NSString *)provinceId
                                  success:(void(^)(HttpModel *result))successBlock
                                         fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock;

- (void)configAccountWithdrawBankDefaultQuery:(void(^)(HttpModel *httpModel))block;
- (void)accountWithdrawBankDefaultQueryFinish:(HttpModel *)resultDic;

/**
* 默认账户查询
*/
- (void)accountWithdrawBankDefaultQuerySuccess:(void(^)(HttpModel *result))successBlock
                                          fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock;

- (AccountWithdrawBankDefaultQueryModel *)accountWithdrawBankDefaultQueryModel;

- (void)configAccountWithdrawBankDelete:(void(^)(HttpModel *httpModel))block;
- (void)accountWithdrawBankDeleteFinish:(HttpModel *)resultDic;

/**
* 删除账户提现银行卡
* @param aId  账号提现银行id
*/
- (void)accountWithdrawBankDeleteWithId:(NSString *)aId
                                  success:(void(^)(HttpModel *result))successBlock
                                   fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock;

- (void)configAccountWithdrawBankDetailQuery:(void(^)(HttpModel *httpModel))block;
- (void)accountWithdrawBankDetailQueryFinish:(HttpModel *)resultDic;

/**
* 账户提现银行信息详情查询
* @param aId  账号提现银行id
*/
- (void)accountWithdrawBankDetailQueryWithId:(NSString *)aId
                                  success:(void(^)(HttpModel *result))successBlock
                                        fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock;

- (void)configAccountWithdrawBankModify:(void(^)(HttpModel *httpModel))block;
- (void)accountWithdrawBankModifyFinish:(HttpModel *)resultDic;

/**
* 账户提现银行信息修改
* @param bankSubBranchId  支行id
* @param cityId  城市id
* @param defaultSelect  是否默认选择
* @param aId  账户提现银行id
* @param provinceId  省id
*/
- (void)accountWithdrawBankModifyWithBankSubBranchId:(NSString *)bankSubBranchId cityId:(NSString *)cityId defaultSelect:(BOOL)defaultSelect aId:(NSString *)aId provinceId:(NSString *)provinceId
                                  success:(void(^)(HttpModel *result))successBlock
                                                fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock;

- (void)configAccountWithdrawBankQuery:(void(^)(HttpModel *httpModel))block;
- (void)accountWithdrawBankQueryFinish:(HttpModel *)resultDic;

/**
* 账户提现银行信息查询
*/
- (void)accountWithdrawBankQuerySuccess:(void(^)(HttpModel *result))successBlock
                                   fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock;

- (void)configAccountWithdrawBankSetDefault:(void(^)(HttpModel *httpModel))block;
- (void)accountWithdrawBankSetDefaultFinish:(HttpModel *)resultDic;

/**
* 账户提现银行设为默认
* @param aId  账号提现银行id
*/
- (void)accountWithdrawBankSetDefaultWithId:(NSString *)aId
                                  success:(void(^)(HttpModel *result))successBlock
                                       fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock;

- (void)configWithdrawApply:(void(^)(HttpModel *httpModel))block;
- (void)withdrawApplyFinish:(HttpModel *)resultDic;

/**
* 提现申请
* @param accountPassword  支付密码
* @param amount  用户输入的提现金额
* @param chargeFee  手续费
* @param withdrawBankId  用户提现的银行主键
*/
- (void)withdrawApplyWithAccountPassword:(NSString *)accountPassword amount:(NSString *)amount chargeFee:(NSString *)chargeFee withdrawBankId:(NSString *)withdrawBankId
                                  success:(void(^)(HttpModel *result))successBlock
                                    fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock;

- (void)configWithdrawApplyPageQuery:(void(^)(HttpModel *httpModel))block;
- (void)withdrawApplyPageQueryFinish:(HttpModel *)resultDic;

/**
* 提现明细分页查询
* @param currentPage  当前页
* @param endDate  结束时间
* @param pageSize  每页条数
* @param startDate  开始时间
*/
- (void)withdrawApplyPageQueryWithCurrentPage:(int)currentPage endDate:(NSString *)endDate pageSize:(int)pageSize startDate:(NSString *)startDate
                                  success:(void(^)(HttpModel *result))successBlock
                                         fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock;

- (void)configWithdrawBasicInfoQuery:(void(^)(HttpModel *httpModel))block;
- (void)withdrawBasicInfoQueryFinish:(HttpModel *)resultDic;

/**
* 提现基础信息查询
*/
- (void)withdrawBasicInfoQuerySuccess:(void(^)(HttpModel *result))successBlock
                                 fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock;

- (WithdrawBasicInfoQueryModel *)withdrawBasicInfoQueryModel;

- (void)configWithdrawChargeRangeConfigQuery:(void(^)(HttpModel *httpModel))block;
- (void)withdrawChargeRangeConfigQueryFinish:(HttpModel *)resultDic;

/**
* 提现收费区间配置查询
*/
- (void)withdrawChargeRangeConfigQuerySuccess:(void(^)(HttpModel *result))successBlock
                                         fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock;

- (void)configWithdrawSupportBankQuery:(void(^)(HttpModel *httpModel))block;
- (void)withdrawSupportBankQueryFinish:(HttpModel *)resultDic;

/**
* 支持提现的银行查询
*/
- (void)withdrawSupportBankQuerySuccess:(void(^)(HttpModel *result))successBlock
                                   fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock;


@end

NS_ASSUME_NONNULL_END
