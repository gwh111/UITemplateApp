//
//  Account.m
//  AccountLib
//
//  Created by gwh on 2019/11/11.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "Account.h"

@implementation Account

- (NSString *)module {
    return @"account";
}

- (void)configAccountLogGoToUrl:(void(^)(HttpModel *httpModel))block {
    [self config:@"accountLogGoToUrl" block:block];
}

- (void)accountLogGoToUrlFinish:(HttpModel *)resultDic {
    [self config:@"accountLogGoToUrl" finish:resultDic];
    [ccs maskStop];
}

/**
* 账户日志跳转地址
* @param accountLogId  账户日志id
*/
- (void)accountLogGoToUrlWithAccountLogId:(NSString *)accountLogId
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
    [params cc_setKey:@"accountLogId" value:accountLogId];
    
    model.requestParams = params;
    
    if ([self checkConfig:@"accountLogGoToUrl" httpModel:model success:successBlock fail:failBlock]) {
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

- (void)configAccountLogPageQuery:(void(^)(HttpModel *httpModel))block {
    [self config:@"accountLogPageQuery" block:block];
}

- (void)accountLogPageQueryFinish:(HttpModel *)resultDic {
    [self config:@"accountLogPageQuery" finish:resultDic];
    [ccs maskStop];
}

/**
* 账户日志分页查询
* @param currentPage  当前页
* @param endDate  结束日期
* @param pageSize  每页条数
* @param startDate  开始日期
*/
- (void)accountLogPageQueryWithCurrentPage:(int)currentPage
                                   endDate:(NSString *)endDate
                                  pageSize:(int)pageSize
                                 startDate:(NSString *)startDate
                                   success:(void(^)(HttpModel *result))successBlock
                                      fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock {
    
    [ccs maskStart];
    
    NSString *service = [ccs string:@"%@/%@", self.module, @"accountLogPageQuery"];
    
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
    
    if ([self checkConfig:@"accountLogPageQuery" httpModel:model success:successBlock fail:failBlock]) {
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
