//
//  CatSearchRecordsModel.m
//  UITemplateKit
//
//  Created by ml on 2019/8/8.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatSearchRecordsModel.h"
#import "ccs.h"

@interface CatSearchRecordsModel ()

@property (nonatomic,strong) NSMutableArray *records;
@property (nonatomic,copy) NSString *name;

@end

@implementation CatSearchRecordsModel

- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        _name = name;
        _records = [[NSUserDefaults standardUserDefaults] objectForKey:_name];
        if (!_records) {
            _records = [NSMutableArray array];
        }else {
            NSMutableArray *arrM = [NSMutableArray arrayWithArray:_records];
            _records = arrM;
        }
        _maxCount = 10;
    }
    return self;
}

- (NSArray *)sortKeywords {
    NSArray *arr = [_records sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [[obj1 objectForKey:@"timestamp"] doubleValue] < [[obj2 objectForKey:@"timestamp"] doubleValue];
    }];
    
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arr.count];
    for (int i = 0; i < arr.count; ++i) {
        [arrM addObject:[arr[i] objectForKey:@"keyword"]];
    }
    
    return arrM.copy;
}

- (NSDictionary *)getKeyword:(NSString *)keyword {
    if ([ccs function_isEmpty:keyword]) { return nil; }
    for (int i = 0; i < _records.count; ++i) {
        if([[_records[i] objectForKey:@"keyword"] isEqualToString:keyword]) {
            return _records[i];
        }
    }
    return nil;
}

- (void)saveWithKeyword:(NSString *)keyword {
    NSParameterAssert(keyword);
    
    NSDictionary *keywordDic = @{
                                 @"keyword":keyword,
                                 @"timestamp":@([[NSDate date] timeIntervalSince1970])
                                 };
    int index = -1;
    for (int i = 0; i < _records.count; ++i) {
        if ([[_records[i] objectForKey:@"keyword"] isEqualToString:keyword]) {
            /// 已存在 更新搜索时间
            index = i;
        }
    }
    
    if(index != -1) {
        [_records removeObjectAtIndex:index];
    }else {
        /// 原来不存在该关键词且当前已达到最大记录数,移除最旧的
        if (_records.count == _maxCount) {
            NSArray *arr = [_records sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                return [[obj1 objectForKey:@"timestamp"] doubleValue] < [[obj2 objectForKey:@"timestamp"] doubleValue];
            }];
            
            NSMutableArray *arrM = [NSMutableArray arrayWithArray:arr];
            [arrM removeLastObject];
            _records = arrM;
        }
    }
    
    [_records addObject:keywordDic];
    [[NSUserDefaults standardUserDefaults] setObject:_records forKey:_name];
}

- (void)removeWithKeyword:(NSString *)keyword {
    int index = -1;
    for (int i = 0; i < _records.count; ++i) {
        if ([[_records[i] objectForKey:@"keyword"] isEqualToString:keyword]) {
            index = i;
            break;
        }
    }
    
    if (index != -1) {
        [_records removeObjectAtIndex:index];
    }
    [[NSUserDefaults standardUserDefaults] setObject:_records forKey:_name];
}

- (void)removeAllKeywords {
    _records = @[].mutableCopy;
    [[NSUserDefaults standardUserDefaults] setObject:_records forKey:_name];
}

@end
