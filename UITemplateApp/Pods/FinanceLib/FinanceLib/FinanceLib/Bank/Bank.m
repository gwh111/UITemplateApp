//
//  Bank.m
//  FinanceLib
//
//  Created by gwh on 2019/11/12.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "Bank.h"

@implementation Bank

- (NSString *)module {
    return @"bank";
}

- (void)configBankSubbranchQuery:(void(^)(HttpModel *httpModel))block {
    [self config:@"bankSubbranchQuery" block:block];
}

- (void)bankSubbranchQueryFinish:(HttpModel *)resultDic {
    [self config:@"bankSubbranchQuery" finish:resultDic];
    [ccs maskStop];
}

/**
* 银行支行查询
* @param bankId  银行id
* @param cityId  市id
* @param districtId  县区id
* @param provinceId  省id
*/
- (void)bankSubbranchQueryWithBankId:(NSString *)bankId cityId:(NSString *)cityId districtId:(NSString *)districtId provinceId:(NSString *)provinceId success:(void(^)(HttpModel *result))successBlock fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock {
    
    [ccs maskStart];
    
    NSString *service = [ccs string:@"%@/%@", self.module, @"bankSubbranchQuery"];
    
    HttpModel *model = ccs.httpModel;
    model.mockExterfaceVersion = @"1";
    model.mockSourceVersion = self.sourceVersion;
    model.mockAppCode = self.appCode;
    model.mockRequestPath = service;
    
    NSMutableDictionary *params = ccs.mutDictionary;
    [params cc_setKey:@"service" value:service];
    
    [params cc_setKey:@"bankId" value:bankId];
    [params cc_setKey:@"cityId" value:cityId];
    [params cc_setKey:@"districtId" value:districtId];
    [params cc_setKey:@"provinceId" value:provinceId];
    
    model.requestParams = params;
    
    if ([self checkConfig:@"bankSubbranchQuery" httpModel:model success:successBlock fail:failBlock]) {
        return;
    }
    
    [ccs.httpTask post:FinanceService.shared.mainURL params:params model:model finishBlock:^(NSString *error, HttpModel *result) {
        
        [ccs maskStop];
        if (error) {
            failBlock(error, result);
            return;
        }
        successBlock(result);
    }];
    
}

@end
