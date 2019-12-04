//
//  Account.h
//  AccountLib
//
//  Created by gwh on 2019/11/11.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountService.h"

NS_ASSUME_NONNULL_BEGIN

@interface Account : AccountService

- (void)configAccountLogGoToUrl:(void(^)(HttpModel *httpModel))block;
- (void)accountLogGoToUrlFinish:(HttpModel *)resultDic;

/**
* 账户日志跳转地址
* @param accountLogId  账户日志id
*/
- (void)accountLogGoToUrlWithAccountLogId:(NSString *)accountLogId
                                  success:(void(^)(HttpModel *result))successBlock
                                     fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock;

- (void)configAccountLogPageQuery:(void(^)(HttpModel *httpModel))block;
- (void)accountLogPageQueryFinish:(HttpModel *)resultDic;

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
                                      fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock;


@end

NS_ASSUME_NONNULL_END
