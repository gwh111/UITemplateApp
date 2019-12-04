//
//  ChargeMethod.h
//  CurrencyKit
//
//  Created by gwh on 2019/11/22.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "ccs.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChargeMethod : NSObject

// https://docs.open.alipay.com/204/105295/
// 应用注册scheme,在AliSDKDemo-Info.plist定义URL types
@property (nonatomic, retain) NSString *AlipaySDK_appScheme;

- (void)chargeWithChannel:(NSDictionary *)channelDic response:(NSDictionary *)responseDic;

@end

NS_ASSUME_NONNULL_END
