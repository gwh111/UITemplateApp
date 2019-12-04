//
//  ChargeMethod.m
//  CurrencyKit
//
//  Created by gwh on 2019/11/22.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "ChargeMethod.h"
//#import <AlipaySDK/AlipaySDK.h>

@implementation ChargeMethod

- (void)chargeWithChannel:(NSDictionary *)channelDic response:(NSDictionary *)responseDic {
    
    NSString *channelBankCode = channelDic[@"channelBankCode"];
    
    if ([channelBankCode isEqualToString:@"ALIPAY"]) {
        [self handleAlipaySDKWithChannel:channelDic response:responseDic];
    }
    
}

- (void)handleAlipaySDKWithChannel:(NSDictionary *)channelDic response:(NSDictionary *)responseDic {
    
    NSString *resultValueString = responseDic[@"resultValueString"];
    NSDictionary *resultValueDic = [ccs function_jsonWithString:resultValueString];
    
    //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
    if (_AlipaySDK_appScheme) {
        _AlipaySDK_appScheme = @"alisdkdemo";
    }
    NSString *appScheme = _AlipaySDK_appScheme;
    
    // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                             resultValueDic[@"SIGN_DATA"], resultValueDic[@"sign"]];
    // NOTE: 调用支付结果开始支付
    void(^callBack)(NSDictionary *resultdic);
    
    id aliPay = [cc_message cc_targetClass:@"AlipaySDK" method:@"defaultService" params:nil];
    [cc_message cc_targetInstance:aliPay method:@"payOrder:fromScheme:callback:" params:orderString, appScheme, callBack];
    
    callBack = ^(NSDictionary *resultDic){
        NSLog(@"reslut = %@",resultDic);
    };
    
//    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//        NSLog(@"reslut = %@",resultDic);
//    }];
}

@end
