//
//  NSMutableArray+Unique.h
//  Patient
//
//  Created by ml on 2019/7/16.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CCUnique <NSObject>

- (NSString *)cc_unique;

@end

/**
 场景:
 
 支持数组去重
 
 */
@interface NSMutableArray (CCUnique)

- (void)addModel:(id<CCUnique>)model;
- (void)addModelsFromArray:(NSArray <id<CCUnique>> *)models;
- (void)updateModelWithModel:(id<CCUnique>)model;
- (void)removeModelWithUniqueID:(NSString *)ID;
- (id<CCUnique>)findModelWithUniqueID:(NSString *)ID;

@end

NS_ASSUME_NONNULL_END
