//
//  NSArray+CCFetch.h
//  Patient
//
//  Created by ml on 2019/8/7.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CCFetch <NSObject>

- (NSString *)cc_fetchKey;

@end

/**
 场景:
 
 比如CatPager视图 设置items需要的是字符串数组,在需要可配置的情况下,服务器返回的是一般是NSDictionary
 让模型提供信息指定要展示的key
 
 */
@interface NSArray (CCFetch)

+ (NSArray *)fetchAll:(NSArray<NSObject<CCFetch> *> *)models;

@end

NS_ASSUME_NONNULL_END
