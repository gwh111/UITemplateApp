//
//  CatSortSiftTool.m
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/16.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CatSortSiftTool.h"

@implementation CatSortSiftInModel

@end

@interface CatSortSiftOutModel ()

@property (nonatomic, readwrite, assign) CGFloat modelWidth;

@end

@implementation CatSortSiftOutModel

-(void)setHeadTitle:(NSString *)headTitle{
    _headTitle = headTitle;
    self.modelWidth = [CatSortSiftTool caculateItemWidth:headTitle];
}

@end

@implementation CatSortSiftTool

+(CGFloat)caculateItemWidth:(NSString *)title{
    if (title.length <= 0) return 0.0;
    CGFloat width = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:RF(17.0f)} context:nil].size.width;
    width += RH(80.0f);
    return width;
}

@end
