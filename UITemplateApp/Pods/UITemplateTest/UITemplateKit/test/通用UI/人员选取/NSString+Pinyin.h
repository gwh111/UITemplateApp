//
//  NSString+Pinyin.h
//  MingChat
//
//  Created by 李文仲 on 2019/3/6.
//  Copyright © 2019 罗礼豪. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Pinyin)

// eg NSLog ([@"我是谁" firstPinyinLettersForHans]) 将输出"WSS"
- (NSString *)firstPinyinLettersForHans;

// eg NSLog ([@"我是谁" firstPinyinLetterForHans]) 将输出"W"
- (NSString *)firstPinyinLetterForHans;

- (NSString *)emojiFiltter;
@end

NS_ASSUME_NONNULL_END
