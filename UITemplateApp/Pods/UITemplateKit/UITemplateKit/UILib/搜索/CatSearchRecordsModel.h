//
//  CatSearchRecordsModel.h
//  UITemplateKit
//
//  Created by ml on 2019/8/8.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CatSearchRecordsModel : NSObject

@property (nonatomic,assign) NSUInteger maxCount;

- (instancetype)initWithName:(NSString *)name;

/**
 所有已排序的关键词字符串数组
 
 @return 关键词数组
 */
- (NSArray *)sortKeywords;

/**
 每个关键词的信息,比如点击时间
 
 @param keyword 关键词
 @return 关键词信息
 */
- (NSDictionary *)getKeyword:(NSString *)keyword;

/**
 保存关键词
 
 @param keyword 关键词
 */
- (void)saveWithKeyword:(NSString *)keyword;

- (void)removeWithKeyword:(NSString *)keyword;

- (void)removeAllKeywords;


@end

NS_ASSUME_NONNULL_END
