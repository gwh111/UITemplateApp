//
//  ExampleModel.m
//  UITemplateLib
//
//  Created by yichen on 2019/5/28.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "ExampleModel.h"

@implementation ExampleModel

-(instancetype)init {
    if (self = [super init]) {
        self.name = [self randomStringWithLength:3];
        self.time = @"7分钟前";
        self.title = [self randomStringWithLength:8];
        self.content = [self randomStringWithLength:arc4random()%50];
        NSMutableArray *arr = [NSMutableArray array];
        for (int i = 0; i < arc4random()%6; i ++) {
            [arr addObject:@"666"];
        }
        self.imgArr = arr.mutableCopy;
    }
    return self;
}

-(NSString *)randomStringWithLength:(NSInteger)len {
    NSString *letters = @"央视新闻29日讯，据华为公司最新消息，华为已提起诉讼并将于周二提出简易判决动议。华为公司发布了华为技术有限公司首席法务官宋柳平27日的相关声明，声明如下:华为已提起诉讼并将于周二提出简易判决动议，要求法院宣布该法案违宪。该禁令是典型的剥夺公权法案，违反了正当程序。· 该法案直接判定华为有罪，对华为施加了大量限制措施，其目的显而易见，就是将华为赶出美国市场。这是“用立法代替审判”的暴政，是美国宪法明确禁止的；· 希望美国法院能和处理以前的剥夺公权条款和违反正当程序案件一样，宣布华为禁令违宪并禁止执行。这一声明也发表在了美国《华尔街日报》等媒体上";

    return [letters substringWithRange:NSMakeRange(arc4random()%([letters length] - len - 2), len)];
}

@end
