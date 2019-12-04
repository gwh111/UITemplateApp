//
//  Freeze.m
//  AccountLib
//
//  Created by gwh on 2019/11/11.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "Freeze.h"

@implementation Freeze

- (NSString *)module {
    return @"freeze";
}

- (void)configFreezeLogQuery:(void(^)(HttpModel *httpModel))block {
    [self config:@"freezeLogQuery" block:block];
}

- (void)freezeLogQueryFinish:(HttpModel *)resultDic {
    [self config:@"freezeLogQuery" finish:resultDic];
    [ccs maskStop];
}

/**
* 冻结日志查询
* @param currentPage  服务费
* @param freezeId  冻结明细id
* @param pageSize  每页条数
*/
- (void)freezeLogQueryWithCurrentPage:(int)currentPage freezeId:(NSString *)freezeId pageSize:(int)pageSize success:(void(^)(HttpModel *result))successBlock fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock {
    
    [ccs maskStart];
    
    NSString *service = [ccs string:@"%@/%@", self.module, @"freezeLogQuery"];
    
    HttpModel *model = ccs.httpModel;
    model.mockExterfaceVersion = @"1";
    model.mockSourceVersion = self.sourceVersion;
    model.mockAppCode = self.appCode;
    model.mockRequestPath = service;
    
    NSMutableDictionary *params = ccs.mutDictionary;
    [params cc_setKey:@"service" value:service];
    
    [params cc_setKey:@"currentPage" value:@(currentPage)];
    [params cc_setKey:@"freezeId" value:freezeId];
    [params cc_setKey:@"pageSize" value:@(pageSize)];
    
    model.requestParams = params;
    
    if ([self checkConfig:@"freezeLogQuery" httpModel:model success:successBlock fail:failBlock]) {
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

- (void)configFreezePageQuery:(void(^)(HttpModel *httpModel))block {
    [self config:@"freezePageQuery" block:block];
}

- (void)freezePageQueryFinish:(HttpModel *)resultDic {
    [self config:@"freezePageQuery" finish:resultDic];
    [ccs maskStop];
}

/**
* 冻结分页查询
* @param currentPage  服务费
* @param endDate  结束日期
* @param pageSize  每页条数
* @param startDate  开始日期
*/
- (void)freezePageQueryWithCurrentPage:(int)currentPage endDate:(NSString *)endDate pageSize:(int)pageSize startDate:(NSString *)startDate success:(void(^)(HttpModel *result))successBlock fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock {
    
    [ccs maskStart];
    
    NSString *service = [ccs string:@"%@/%@", self.module, @"freezePageQuery"];
    
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
    
    if ([self checkConfig:@"freezePageQuery" httpModel:model success:successBlock fail:failBlock]) {
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
