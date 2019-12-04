//
//  CatDateSelectTool.h
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/13.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ccs.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CatDateSelectTheme) {
    CatDateSelectThemeYear,
    CatDateSelectThemeMonth,
    CatDateSelectThemeDay,
};
@interface CatDateSelectTool : NSObject

/**
 计算当前时间 yyyy-MM-dd

 @return 当前时间
 */
+ (NSString*)caculateCurrentDate;

+(NSDate*)dateFromString:(NSString*)dateStr;

+ (BOOL)compareDate:(NSDate*)stary withDate:(NSDate*)end;
@end

NS_ASSUME_NONNULL_END
