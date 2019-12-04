//
//  Deposit.m
//  AccountLib
//
//  Created by gwh on 2019/11/11.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "Deposit.h"

@implementation Deposit

- (NSString *)module {
    return @"deposit";
}

- (void)configDepositAmountConfigQuery:(void(^)(HttpModel *httpModel))block {
    [self config:@"depositAmountConfigQuery" block:block];
}

- (void)depositAmountConfigQueryFinish:(HttpModel *)resultDic {
    [self config:@"depositAmountConfigQuery" finish:resultDic];
    [ccs maskStop];
}

/**
* 充值金额配置查询
*/
- (void)depositAmountConfigQuerySuccess:(void(^)(HttpModel *result))successBlock
                                       fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock {
    
    [ccs maskStart];
    
    NSString *service = [ccs string:@"%@/%@", self.module, @"depositAmountConfigQuery"];
    
    HttpModel *model = ccs.httpModel;
    model.mockExterfaceVersion = @"1";
    model.mockSourceVersion = @"1.2.20191024.63-SNAPSHOT";
    model.mockAppCode = @"user.account.api.mobile.base";
    model.mockRequestPath = service;
    
    NSMutableDictionary *params = ccs.mutDictionary;
    [params cc_setKey:@"service" value:service];
    
    model.requestParams = params;
    
    if ([self checkConfig:@"depositAmountConfigQuery" httpModel:model success:successBlock fail:failBlock]) {
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

- (void)configDepositApply:(void(^)(HttpModel *httpModel))block {
    [self config:@"depositApply" block:block];
}

- (void)depositApplyFinish:(HttpModel *)resultDic {
    [self config:@"depositApply" finish:resultDic];
    [ccs maskStop];
}

/**
* 充值申请
* @param chargeFee  服务费
* @param depositAmount  充值金额
* @param fundChannelId  资金通道id
*/
- (void)depositApplyWithChargeFee:(CC_Money *)chargeFee depositAmount:(CC_Money *)depositAmount fundChannelId:(NSString *)fundChannelId
                          success:(void(^)(HttpModel *result))successBlock
                             fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock {
    
    [ccs maskStart];
    
    NSString *service = [ccs string:@"%@/%@", self.module, @"depositApply"];
    
    HttpModel *model = ccs.httpModel;
    model.mockExterfaceVersion = @"1";
    model.mockSourceVersion = @"1.2.20191024.63-SNAPSHOT";
    model.mockAppCode = @"user.account.api.mobile.base";
    model.mockRequestPath = service;
    
    NSMutableDictionary *params = ccs.mutDictionary;
    [params cc_setKey:@"service" value:service];
    
    [params cc_setKey:@"chargeFee" value:chargeFee.value];
    [params cc_setKey:@"depositAmount" value:depositAmount.value];
    [params cc_setKey:@"fundChannelId" value:fundChannelId];
    
    model.requestParams = params;
    
    if ([self checkConfig:@"depositApply" httpModel:model success:successBlock fail:failBlock]) {
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

- (void)configDepositApplyNeedIdentify:(void(^)(HttpModel *httpModel))block {
    [self config:@"depositApplyNeedIdentify" block:block];
}

- (void)depositApplyNeedIdentifyFinish:(HttpModel *)resultDic {
    [self config:@"depositApplyNeedIdentify" finish:resultDic];
    [ccs maskStop];
}

/**
* 充值申请是否需要实名
*/
- (void)depositApplyNeedIdentifyWithSuccess:(void(^)(HttpModel *result))successBlock fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock {
    
    [ccs maskStart];
    
    NSString *service = [ccs string:@"%@/%@", self.module, @"depositApplyNeedIdentify"];
    HttpModel *model = ccs.httpModel;
    model.mockExterfaceVersion = @"1";
    model.mockSourceVersion = @"1.2.20191024.63-SNAPSHOT";
    model.mockAppCode = @"user.account.api.mobile.base";
    model.mockRequestPath = service;
    
    NSMutableDictionary *params = ccs.mutDictionary;
    [params cc_setKey:@"service" value:service];
    
    model.requestParams = params;
    
    if ([self checkConfig:@"depositApplyNeedIdentify" httpModel:model success:successBlock fail:failBlock]) {
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

- (void)configDepositReturn:(void(^)(HttpModel *httpModel))block {
    [self config:@"depositReturn" block:block];
}

- (void)depositReturnFinish:(HttpModel *)resultDic {
    [self config:@"depositReturn" finish:resultDic];
    [ccs maskStop];
}

/**
* 充值回跳
* @param depositApplyNo  充值申请单号
*/
- (void)depositReturnWithDepositApplyNo:(NSString *)depositApplyNo success:(void(^)(HttpModel *result))successBlock fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock {
    
    [ccs maskStart];
    
    NSString *service = [ccs string:@"%@/%@", self.module, @"depositReturn"];
    
    HttpModel *model = ccs.httpModel;
    model.mockExterfaceVersion = @"1";
    model.mockSourceVersion = @"1.2.20191024.63-SNAPSHOT";
    model.mockAppCode = @"user.account.api.mobile.base";
    model.mockRequestPath = service;
    
    NSMutableDictionary *params = ccs.mutDictionary;
    [params cc_setKey:@"service" value:service];
    
    [params cc_setKey:@"depositApplyNo" value:depositApplyNo];
    
    model.requestParams = params;
    
    if ([self checkConfig:@"depositReturn" httpModel:model success:successBlock fail:failBlock]) {
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

- (void)configFundChannelQuery:(void(^)(HttpModel *httpModel))block {
    [self config:@"fundChannelQuery" block:block];
}

- (void)fundChannelQueryFinish:(HttpModel *)resultDic {
    [self config:@"fundChannelQuery" finish:resultDic];
    [ccs maskStop];
}

/**
* 资金通道查询
*/
- (void)fundChannelQueryWithSuccess:(void(^)(HttpModel *result))successBlock fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock {
    
    [ccs maskStart];
    
    NSString *service = [ccs string:@"%@/%@", self.module, @"fundChannelQuery"];
    
    HttpModel *model = ccs.httpModel;
    model.mockExterfaceVersion = @"1";
    model.mockSourceVersion = @"1.2.20191024.63-SNAPSHOT";
    model.mockAppCode = @"user.account.api.mobile.base";
    model.mockRequestPath = service;
    
    NSMutableDictionary *params = ccs.mutDictionary;
    [params cc_setKey:@"service" value:service];
    
    model.requestParams = params;
    
    if ([self checkConfig:@"fundChannelQuery" httpModel:model success:successBlock fail:failBlock]) {
        return;
    }
    
    [ccs.httpTask post:AccountService.shared.mainURL params:params model:model finishBlock:^(NSString *error, HttpModel *result) {
        
        [ccs maskStop];
        if (error) {
            failBlock(error, result);
            return;
        }
        AccountC.shared.fundChannels = result.resultDic[@"fundChannels"];
        successBlock(result);
    }];
    
}


@end
