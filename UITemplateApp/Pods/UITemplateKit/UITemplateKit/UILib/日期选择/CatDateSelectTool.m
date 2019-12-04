//
//  CatDateSelectTool.m
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/13.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CatDateSelectTool.h"

@implementation CatDateSelectTool

+ (NSString *)caculateCurrentDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    return currentTimeString;
}

+ (NSDate *)dateFromString:(NSString *)dateStr{
    //时间字符串
    NSString *str = dateStr;
    if (dateStr.length < 19) {
        str = [NSString stringWithFormat:@"%@ 00:00:00", dateStr];
    }
    //规定时间格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //设置时区  全球标准时间CUT 必须设置 我们要设置中国的时区
    NSTimeZone *zone = [[NSTimeZone alloc] initWithName:@"CUT"];
    [formatter setTimeZone:zone];
    //变回日期格式
    NSDate *stringDate = [formatter dateFromString:str];
    return stringDate;
}
//比较两个日期的大小
+ (BOOL)compareDate:(NSDate*)stary withDate:(NSDate*)end {
    NSComparisonResult result = [stary compare: end];
    if (result==NSOrderedSame)
    {
        //相等
        return NO;
    }else if (result == NSOrderedAscending)
    {
        //结束时间大于开始时间
        return YES;
    }else if (result == NSOrderedDescending)
    {
        //结束时间小于开始时间
        return NO;
    }
    return NO;
}
@end
