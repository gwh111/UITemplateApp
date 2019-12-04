//
//  Area.h
//  CurrencyKit
//
//  Created by gwh on 2019/11/15.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AreaService.h"

NS_ASSUME_NONNULL_BEGIN

@interface Area : AreaService

- (void)configSubAreaQuery:(void(^)(HttpModel *httpModel))block;
- (void)subAreaQueryFinish:(HttpModel *)resultDic;

/**
* 子区域查询
* @param areaId  区域ID(如果区域类型是国家,areaId不传为中国)
* @param areaType  区域范围类型
*/
- (void)subAreaQueryWithAreaId:(NSString *)areaId areaType:(NSString *)areaType success:(void(^)(HttpModel *result))successBlock fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock;

@end

NS_ASSUME_NONNULL_END
