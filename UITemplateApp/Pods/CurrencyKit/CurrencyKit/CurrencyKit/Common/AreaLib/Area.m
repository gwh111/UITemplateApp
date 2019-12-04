//
//  Area.m
//  CurrencyKit
//
//  Created by gwh on 2019/11/15.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "Area.h"

@interface Area ()

@end

@implementation Area

extern NSString *TEXT_SUCCESS;
extern NSString *TEXT_FAIL;

- (NSString *)module {
    return @"area";
}

- (void)configSubAreaQuery:(void(^)(HttpModel *httpModel))block {
    [self config:@"subAreaQuery" block:block];
}

- (void)subAreaQueryFinish:(HttpModel *)resultDic {
    [self config:@"subAreaQuery" finish:resultDic];
    [ccs maskStop];
}

/**
* 子区域查询
* @param areaId  区域ID(如果区域类型是国家,areaId不传为中国)
* @param areaType  区域范围类型
*/
- (void)subAreaQueryWithAreaId:(NSString *)areaId areaType:(NSString *)areaType success:(void(^)(HttpModel *result))successBlock fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock {
    
    [ccs maskStart];
    
    NSString *service = [ccs string:@"%@/%@", self.module, @"subAreaQuery"];
    
    HttpModel *model = ccs.httpModel;
    model.mockExterfaceVersion = @"1";
    model.mockSourceVersion = self.sourceVersion;
    model.mockAppCode = self.appCode;
    model.mockRequestPath = service;
    
    NSMutableDictionary *params = ccs.mutDictionary;
    [params cc_setKey:@"service" value:service];
    
    [params cc_setKey:@"areaId" value:areaId];
    [params cc_setKey:@"areaType" value:areaType];
    
    model.requestParams = params;
    
    if ([self checkConfig:@"subAreaQuery" httpModel:model success:successBlock fail:failBlock]) {
        return;
    }
    
    [ccs.httpTask post:AreaService.shared.mainURL params:params model:model finishBlock:^(NSString *error, HttpModel *result) {
        
        [ccs maskStop];
        if (error) {
            failBlock(error, result);
            return;
        }
        successBlock(result);
    }];
    
}

@end
