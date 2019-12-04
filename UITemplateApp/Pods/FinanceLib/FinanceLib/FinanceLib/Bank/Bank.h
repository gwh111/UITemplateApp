//
//  Bank.h
//  FinanceLib
//
//  Created by gwh on 2019/11/12.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FinanceService.h"

NS_ASSUME_NONNULL_BEGIN

@interface Bank : FinanceService

- (void)configBankSubbranchQuery:(void(^)(HttpModel *httpModel))block;
- (void)bankSubbranchQueryFinish:(HttpModel *)resultDic;

/**
* 银行支行查询
* @param bankId  银行id
* @param cityId  市id
* @param districtId  县区id
* @param provinceId  省id
*/
- (void)bankSubbranchQueryWithBankId:(NSString *)bankId cityId:(NSString *)cityId districtId:(NSString *)districtId provinceId:(NSString *)provinceId success:(void(^)(HttpModel *result))successBlock fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock;

@end

NS_ASSUME_NONNULL_END
