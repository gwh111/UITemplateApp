//
//  Withdraw.m
//  AccountLib
//
//  Created by gwh on 2019/11/14.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "Withdraw.h"
#import "WithdrawBasicInfoQueryModel.h"

@implementation Withdraw

- (NSString *)module {
    return @"withdraw";
}

- (void)configAccountWithdrawBankCreate:(void(^)(HttpModel *httpModel))block {
    [self config:@"accountWithdrawBankCreate" block:block];
}

- (void)accountWithdrawBankCreateFinish:(HttpModel *)resultDic {
    [self config:@"accountWithdrawBankCreate" finish:resultDic];
    [ccs maskStop];
}

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
                                     fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock {
    
    [ccs maskStart];
    
    NSString *service = [ccs string:@"%@/%@", self.module, @"accountWithdrawBankCreate"];
    
    HttpModel *model = ccs.httpModel;
    model.mockExterfaceVersion = @"1";
    model.mockSourceVersion = self.sourceVersion;
    model.mockAppCode = self.appCode;
    model.mockRequestPath = service;
    
    NSMutableDictionary *params = ccs.mutDictionary;
    [params cc_setKey:@"service" value:service];
    [params cc_setKey:@"bankCode" value:bankCode];
    [params cc_setKey:@"bankSubBranchId" value:bankSubBranchId];
    [params cc_setKey:@"cardNo" value:cardNo];
    [params cc_setKey:@"cityId" value:cityId];
    [params cc_setKey:@"defaultSelect" value:@(defaultSelect)];
    [params cc_setKey:@"provinceId" value:provinceId];
    
    model.requestParams = params;
    
    if ([self checkConfig:@"accountWithdrawBankCreate" httpModel:model success:successBlock fail:failBlock]) {
        return;
    }
    
    [ccs.httpTask post:AccountService.shared.mainURL params:params model:model finishBlock:^(NSString *error, HttpModel *result) {
        
        [ccs maskStop];
        if (error) {
            failBlock(error, result);
            return;
        }
        successBlock(result);
    }];
    
}

- (void)configAccountWithdrawBankDefaultQuery:(void(^)(HttpModel *httpModel))block {
    [self config:@"accountWithdrawBankDefaultQuery" block:block];
}

- (void)accountWithdrawBankDefaultQueryFinish:(HttpModel *)resultDic {
    [self config:@"accountWithdrawBankDefaultQuery" finish:resultDic];
    [ccs maskStop];
}

/**
* 默认账户查询
*/
- (void)accountWithdrawBankDefaultQuerySuccess:(void(^)(HttpModel *result))successBlock
                                     fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock {
    
    [ccs maskStart];
    
    NSString *service = [ccs string:@"%@/%@", self.module, @"accountWithdrawBankDefaultQuery"];
    
    HttpModel *model = ccs.httpModel;
    model.mockExterfaceVersion = @"1";
    model.mockSourceVersion = self.sourceVersion;
    model.mockAppCode = self.appCode;
    model.mockRequestPath = service;
    
    NSMutableDictionary *params = ccs.mutDictionary;
    [params cc_setKey:@"service" value:service];
    
    model.requestParams = params;
    
    if ([self checkConfig:@"accountWithdrawBankDefaultQuery" httpModel:model success:successBlock fail:failBlock]) {
        return;
    }
    
    [ccs.httpTask post:AccountService.shared.mainURL params:params model:model finishBlock:^(NSString *error, HttpModel *result) {
        
        [ccs maskStop];
        if (error) {
            failBlock(error, result);
            return;
        }
        AccountWithdrawBankDefaultQueryModel *resultModel = [ccs model:AccountWithdrawBankDefaultQueryModel.class];
        [resultModel cc_setProperty:result.resultDic[@"accountWithdrawBankSimple"] modelKVDic:@{@"aId":@"id"}];
        AccountC.shared.accountWithdrawBankDefaultQueryModel = resultModel;
        successBlock(result);
    }];
    
}

- (AccountWithdrawBankDefaultQueryModel *)accountWithdrawBankDefaultQueryModel {
    return AccountC.shared.accountWithdrawBankDefaultQueryModel;
}

- (void)configAccountWithdrawBankDelete:(void(^)(HttpModel *httpModel))block {
    [self config:@"accountWithdrawBankDelete" block:block];
}

- (void)accountWithdrawBankDeleteFinish:(HttpModel *)resultDic {
    [self config:@"accountWithdrawBankDelete" finish:resultDic];
    [ccs maskStop];
}

/**
* 删除账户提现银行卡
* @param aId  账号提现银行id
*/
- (void)accountWithdrawBankDeleteWithId:(NSString *)aId
                                  success:(void(^)(HttpModel *result))successBlock
                                     fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock {
    
    [ccs maskStart];
    
    NSString *service = [ccs string:@"%@/%@", self.module, @"accountLogGoToUrl"];
    
    HttpModel *model = ccs.httpModel;
    model.mockExterfaceVersion = @"1";
    model.mockSourceVersion = self.sourceVersion;
    model.mockAppCode = self.appCode;
    model.mockRequestPath = service;
    
    NSMutableDictionary *params = ccs.mutDictionary;
    [params cc_setKey:@"service" value:service];
    [params cc_setKey:@"id" value:aId];
    
    model.requestParams = params;
    
    if ([self checkConfig:@"accountWithdrawBankDelete" httpModel:model success:successBlock fail:failBlock]) {
        return;
    }
    
    [ccs.httpTask post:AccountService.shared.mainURL params:params model:model finishBlock:^(NSString *error, HttpModel *result) {
        
        [ccs maskStop];
        if (error) {
            failBlock(error, result);
            return;
        }
        successBlock(result);
    }];
    
}

- (void)configAccountWithdrawBankDetailQuery:(void(^)(HttpModel *httpModel))block {
    [self config:@"accountWithdrawBankDetailQuery" block:block];
}

- (void)accountWithdrawBankDetailQueryFinish:(HttpModel *)resultDic {
    [self config:@"accountWithdrawBankDetailQuery" finish:resultDic];
    [ccs maskStop];
}

/**
* 账户提现银行信息详情查询
* @param aId  账号提现银行id
*/
- (void)accountWithdrawBankDetailQueryWithId:(NSString *)aId
                                  success:(void(^)(HttpModel *result))successBlock
                                     fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock {
    
    [ccs maskStart];
    
    NSString *service = [ccs string:@"%@/%@", self.module, @"accountWithdrawBankDetailQuery"];
    
    HttpModel *model = ccs.httpModel;
    model.mockExterfaceVersion = @"1";
    model.mockSourceVersion = self.sourceVersion;
    model.mockAppCode = self.appCode;
    model.mockRequestPath = service;
    
    NSMutableDictionary *params = ccs.mutDictionary;
    [params cc_setKey:@"service" value:service];
    [params cc_setKey:@"id" value:aId];
    
    model.requestParams = params;
    
    if ([self checkConfig:@"accountWithdrawBankDetailQuery" httpModel:model success:successBlock fail:failBlock]) {
        return;
    }
    
    [ccs.httpTask post:AccountService.shared.mainURL params:params model:model finishBlock:^(NSString *error, HttpModel *result) {
        
        [ccs maskStop];
        if (error) {
            failBlock(error, result);
            return;
        }
        successBlock(result);
    }];
    
}

- (void)configAccountWithdrawBankModify:(void(^)(HttpModel *httpModel))block {
    [self config:@"accountWithdrawBankModify" block:block];
}

- (void)accountWithdrawBankModifyFinish:(HttpModel *)resultDic {
    [self config:@"accountWithdrawBankModify" finish:resultDic];
    [ccs maskStop];
}

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
                                     fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock {
    
    [ccs maskStart];
    
    NSString *service = [ccs string:@"%@/%@", self.module, @"accountWithdrawBankModify"];
    
    HttpModel *model = ccs.httpModel;
    model.mockExterfaceVersion = @"1";
    model.mockSourceVersion = self.sourceVersion;
    model.mockAppCode = self.appCode;
    model.mockRequestPath = service;
    
    NSMutableDictionary *params = ccs.mutDictionary;
    [params cc_setKey:@"service" value:service];
    [params cc_setKey:@"bankSubBranchId" value:bankSubBranchId];
    [params cc_setKey:@"cityId" value:cityId];
    [params cc_setKey:@"defaultSelect" value:@(defaultSelect)];
    [params cc_setKey:@"id" value:aId];
    [params cc_setKey:@"provinceId" value:provinceId];
    
    model.requestParams = params;
    
    if ([self checkConfig:@"accountWithdrawBankModify" httpModel:model success:successBlock fail:failBlock]) {
        return;
    }
    
    [ccs.httpTask post:AccountService.shared.mainURL params:params model:model finishBlock:^(NSString *error, HttpModel *result) {
        
        [ccs maskStop];
        if (error) {
            failBlock(error, result);
            return;
        }
        successBlock(result);
    }];
    
}

- (void)configAccountWithdrawBankQuery:(void(^)(HttpModel *httpModel))block {
    [self config:@"accountWithdrawBankQuery" block:block];
}

- (void)accountWithdrawBankQueryFinish:(HttpModel *)resultDic {
    [self config:@"accountWithdrawBankQuery" finish:resultDic];
    [ccs maskStop];
}

/**
* 账户提现银行信息查询
*/
- (void)accountWithdrawBankQuerySuccess:(void(^)(HttpModel *result))successBlock
                                     fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock {
    
    [ccs maskStart];
    
    NSString *service = [ccs string:@"%@/%@", self.module, @"accountWithdrawBankQuery"];
    
    HttpModel *model = ccs.httpModel;
    model.mockExterfaceVersion = @"1";
    model.mockSourceVersion = self.sourceVersion;
    model.mockAppCode = self.appCode;
    model.mockRequestPath = service;
    
    NSMutableDictionary *params = ccs.mutDictionary;
    [params cc_setKey:@"service" value:service];
    
    model.requestParams = params;
    
    if ([self checkConfig:@"accountWithdrawBankQuery" httpModel:model success:successBlock fail:failBlock]) {
        return;
    }
    
    [ccs.httpTask post:AccountService.shared.mainURL params:params model:model finishBlock:^(NSString *error, HttpModel *result) {
        
        [ccs maskStop];
        if (error) {
            failBlock(error, result);
            return;
        }
        successBlock(result);
    }];
    
}

- (void)configAccountWithdrawBankSetDefault:(void(^)(HttpModel *httpModel))block {
    [self config:@"accountWithdrawBankSetDefault" block:block];
}

- (void)accountWithdrawBankSetDefaultFinish:(HttpModel *)resultDic {
    [self config:@"accountWithdrawBankSetDefault" finish:resultDic];
    [ccs maskStop];
}

/**
* 账户提现银行设为默认
* @param aId  账号提现银行id
*/
- (void)accountWithdrawBankSetDefaultWithId:(NSString *)aId
                                  success:(void(^)(HttpModel *result))successBlock
                                     fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock {
    
    [ccs maskStart];
    
    NSString *service = [ccs string:@"%@/%@", self.module, @"accountWithdrawBankSetDefault"];
    
    HttpModel *model = ccs.httpModel;
    model.mockExterfaceVersion = @"1";
    model.mockSourceVersion = self.sourceVersion;
    model.mockAppCode = self.appCode;
    model.mockRequestPath = service;
    
    NSMutableDictionary *params = ccs.mutDictionary;
    [params cc_setKey:@"service" value:service];
    [params cc_setKey:@"id" value:aId];
    
    model.requestParams = params;
    
    if ([self checkConfig:@"accountWithdrawBankSetDefault" httpModel:model success:successBlock fail:failBlock]) {
        return;
    }
    
    [ccs.httpTask post:AccountService.shared.mainURL params:params model:model finishBlock:^(NSString *error, HttpModel *result) {
        
        [ccs maskStop];
        if (error) {
            failBlock(error, result);
            return;
        }
        successBlock(result);
    }];
    
}

- (void)configWithdrawApply:(void(^)(HttpModel *httpModel))block {
    [self config:@"withdrawApply" block:block];
}

- (void)withdrawApplyFinish:(HttpModel *)resultDic {
    [self config:@"withdrawApply" finish:resultDic];
    [ccs maskStop];
}

/**
* 提现申请
* @param accountPassword  支付密码
* @param amount  用户输入的提现金额
* @param chargeFee  手续费
* @param withdrawBankId  用户提现的银行主键
*/
- (void)withdrawApplyWithAccountPassword:(NSString *)accountPassword amount:(NSString *)amount chargeFee:(NSString *)chargeFee withdrawBankId:(NSString *)withdrawBankId
                                  success:(void(^)(HttpModel *result))successBlock
                                     fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock {
    
    [ccs maskStart];
    
    NSString *service = [ccs string:@"%@/%@", self.module, @"withdrawApply"];
    
    HttpModel *model = ccs.httpModel;
    model.mockExterfaceVersion = @"1";
    model.mockSourceVersion = self.sourceVersion;
    model.mockAppCode = self.appCode;
    model.mockRequestPath = service;
    
    NSMutableDictionary *params = ccs.mutDictionary;
    [params cc_setKey:@"service" value:service];
    [params cc_setKey:@"accountPassword" value:accountPassword];
    [params cc_setKey:@"amount" value:amount];
    [params cc_setKey:@"chargeFee" value:chargeFee];
    [params cc_setKey:@"withdrawBankId" value:withdrawBankId];
    
    model.requestParams = params;
    
    if ([self checkConfig:@"withdrawApply" httpModel:model success:successBlock fail:failBlock]) {
        return;
    }
    
    [ccs.httpTask post:AccountService.shared.mainURL params:params model:model finishBlock:^(NSString *error, HttpModel *result) {
        
        [ccs maskStop];
        if (error) {
            failBlock(error, result);
            return;
        }
        successBlock(result);
    }];
    
}

- (void)configWithdrawApplyPageQuery:(void(^)(HttpModel *httpModel))block {
    [self config:@"withdrawApplyPageQuery" block:block];
}

- (void)withdrawApplyPageQueryFinish:(HttpModel *)resultDic {
    [self config:@"withdrawApplyPageQuery" finish:resultDic];
    [ccs maskStop];
}

/**
* 提现明细分页查询
* @param currentPage  当前页
* @param endDate  结束时间
* @param pageSize  每页条数
* @param startDate  开始时间
*/
- (void)withdrawApplyPageQueryWithCurrentPage:(int)currentPage endDate:(NSString *)endDate pageSize:(int)pageSize startDate:(NSString *)startDate
                                  success:(void(^)(HttpModel *result))successBlock
                                     fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock {
    
    [ccs maskStart];
    
    NSString *service = [ccs string:@"%@/%@", self.module, @"withdrawApplyPageQuery"];
    
    HttpModel *model = ccs.httpModel;
    model.mockExterfaceVersion = @"1";
    model.mockSourceVersion = self.sourceVersion;
    model.mockAppCode = self.appCode;
    model.mockRequestPath = service;
    
    NSMutableDictionary *params = ccs.mutDictionary;
    [params cc_setKey:@"service" value:service];
    [params cc_setKey:@"currentPage" value:@(currentPage)];
    [params cc_setKey:@"endDate" value:endDate];
    [params cc_setKey:@"pageSize" value:@(pageSize)];
    [params cc_setKey:@"startDate" value:startDate];
    
    model.requestParams = params;
    
    if ([self checkConfig:@"withdrawApplyPageQuery" httpModel:model success:successBlock fail:failBlock]) {
        return;
    }
    
    [ccs.httpTask post:AccountService.shared.mainURL params:params model:model finishBlock:^(NSString *error, HttpModel *result) {
        
        [ccs maskStop];
        if (error) {
            failBlock(error, result);
            return;
        }
        successBlock(result);
    }];
    
}

- (void)configWithdrawBasicInfoQuery:(void(^)(HttpModel *httpModel))block {
    [self config:@"withdrawBasicInfoQuery" block:block];
}

- (void)withdrawBasicInfoQueryFinish:(HttpModel *)resultDic {
    [self config:@"withdrawBasicInfoQuery" finish:resultDic];
    [ccs maskStop];
}

/**
* 提现基础信息查询
*/
- (void)withdrawBasicInfoQuerySuccess:(void(^)(HttpModel *result))successBlock
                                     fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock {
    
    [ccs maskStart];
    
    NSString *service = [ccs string:@"%@/%@", self.module, @"withdrawBasicInfoQuery"];
    
    HttpModel *model = ccs.httpModel;
    model.mockExterfaceVersion = @"1";
    model.mockSourceVersion = self.sourceVersion;
    model.mockAppCode = self.appCode;
    model.mockRequestPath = service;
    
    NSMutableDictionary *params = ccs.mutDictionary;
    [params cc_setKey:@"service" value:service];
    
    model.requestParams = params;
    
    if ([self checkConfig:@"withdrawBasicInfoQuery" httpModel:model success:successBlock fail:failBlock]) {
        return;
    }
    
    [ccs.httpTask post:AccountService.shared.mainURL params:params model:model finishBlock:^(NSString *error, HttpModel *result) {
        
        [ccs maskStop];
        if (error) {
            failBlock(error, result);
            return;
        }
        WithdrawBasicInfoQueryModel *resultModel = [ccs model:WithdrawBasicInfoQueryModel.class];
        [resultModel cc_setProperty:result.resultDic];
        AccountC.shared.withdrawBasicInfoQueryModel = resultModel;
        successBlock(result);
    }];
    
}

- (WithdrawBasicInfoQueryModel *)withdrawBasicInfoQueryModel {
    return AccountC.shared.withdrawBasicInfoQueryModel;
}

- (void)configWithdrawChargeRangeConfigQuery:(void(^)(HttpModel *httpModel))block {
    [self config:@"withdrawChargeRangeConfigQuery" block:block];
}

- (void)withdrawChargeRangeConfigQueryFinish:(HttpModel *)resultDic {
    [self config:@"withdrawChargeRangeConfigQuery" finish:resultDic];
    [ccs maskStop];
}

/**
* 提现收费区间配置查询
*/
- (void)withdrawChargeRangeConfigQuerySuccess:(void(^)(HttpModel *result))successBlock
                                     fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock {
    
    [ccs maskStart];
    
    NSString *service = [ccs string:@"%@/%@", self.module, @"withdrawChargeRangeConfigQuery"];
    
    HttpModel *model = ccs.httpModel;
    model.mockExterfaceVersion = @"1";
    model.mockSourceVersion = self.sourceVersion;
    model.mockAppCode = self.appCode;
    model.mockRequestPath = service;
    
    NSMutableDictionary *params = ccs.mutDictionary;
    [params cc_setKey:@"service" value:service];
    
    model.requestParams = params;
    
    if ([self checkConfig:@"withdrawChargeRangeConfigQuery" httpModel:model success:successBlock fail:failBlock]) {
        return;
    }
    
    [ccs.httpTask post:AccountService.shared.mainURL params:params model:model finishBlock:^(NSString *error, HttpModel *result) {
        
        [ccs maskStop];
        if (error) {
            failBlock(error, result);
            return;
        }
        AccountC.shared.withdrawChargeRangeConfigSimples = result.resultDic[@"withdrawChargeRangeConfigSimples"];
        successBlock(result);
    }];
    
}

- (void)configWithdrawSupportBankQuery:(void(^)(HttpModel *httpModel))block {
    [self config:@"withdrawSupportBankQuery" block:block];
}

- (void)withdrawSupportBankQueryFinish:(HttpModel *)resultDic {
    [self config:@"withdrawSupportBankQuery" finish:resultDic];
    [ccs maskStop];
}

/**
* 支持提现的银行查询
*/
- (void)withdrawSupportBankQuerySuccess:(void(^)(HttpModel *result))successBlock
                                     fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock {
    
    [ccs maskStart];
    
    NSString *service = [ccs string:@"%@/%@", self.module, @"withdrawSupportBankQuery"];
    
    HttpModel *model = ccs.httpModel;
    model.mockExterfaceVersion = @"1";
    model.mockSourceVersion = self.sourceVersion;
    model.mockAppCode = self.appCode;
    model.mockRequestPath = service;
    
    NSMutableDictionary *params = ccs.mutDictionary;
    [params cc_setKey:@"service" value:service];
    
    model.requestParams = params;
    
    if ([self checkConfig:@"withdrawSupportBankQuery" httpModel:model success:successBlock fail:failBlock]) {
        return;
    }
    
    [ccs.httpTask post:AccountService.shared.mainURL params:params model:model finishBlock:^(NSString *error, HttpModel *result) {
        
        [ccs maskStop];
        if (error) {
            failBlock(error, result);
            return;
        }
        successBlock(result);
    }];
    
}

@end
