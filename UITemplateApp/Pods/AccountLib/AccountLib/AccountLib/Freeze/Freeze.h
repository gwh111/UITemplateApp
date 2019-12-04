//
//  Freeze.h
//  AccountLib
//
//  Created by gwh on 2019/11/11.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountService.h"

NS_ASSUME_NONNULL_BEGIN

@interface Freeze : AccountService

- (void)configFreezeLogQuery:(void(^)(HttpModel *httpModel))block;
- (void)freezeLogQueryFinish:(HttpModel *)resultDic;

/**
* 冻结日志查询
* @param currentPage  服务费
* @param freezeId  冻结明细id
* @param pageSize  每页条数
*/
- (void)freezeLogQueryWithCurrentPage:(int)currentPage freezeId:(NSString *)freezeId pageSize:(int)pageSize success:(void(^)(HttpModel *result))successBlock fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock;

- (void)configFreezePageQuery:(void(^)(HttpModel *httpModel))block;
- (void)freezePageQueryFinish:(HttpModel *)resultDic;

/**
* 冻结分页查询
* @param currentPage  服务费
* @param endDate  结束日期
* @param pageSize  每页条数
* @param startDate  开始日期
*/
- (void)freezePageQueryWithCurrentPage:(int)currentPage endDate:(NSString *)endDate pageSize:(int)pageSize startDate:(NSString *)startDate success:(void(^)(HttpModel *result))successBlock fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock;

@end

NS_ASSUME_NONNULL_END
