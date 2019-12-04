//
//  CatSortSift.m
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/16.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CatSortSift.h"

@interface CatSortSift ()

@end

@implementation CatSortSift

-(instancetype)initOn:(UIView*)view frame:(CGRect)frame title:(nullable NSString *)title dataArr:(NSArray<CatSortSiftOutModel *> *)dataArr theme:(CatSortSiftTheme)theme{
    if (self = [super init]) {
        self.sortSiftView = [[CatSortSiftView alloc]initWithFrame:frame title:title dataArr:dataArr theme:theme];
        _sortSiftView.delegate = self;
        [view addSubview:_sortSiftView];
    }
    return self;
}

-(void)updateDataArr:(NSArray<CatSortSiftOutModel *> *)dataArr{
    [_sortSiftView updateDataArr:dataArr];
}

#pragma mark -delegate
-(void)catSortSiftView:(CatSortSiftView *)catSortSiftView didSelectRowAtSection:(NSInteger)section index:(NSInteger)index{
    if (_delegate && [_delegate respondsToSelector:@selector(catSortSift:didSelectRowAtSection:index:)]) {
        [_delegate catSortSift:self didSelectRowAtSection:section index:index];
    }
}
@end
