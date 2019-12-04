//
//  CatSpinnerTool.m
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/5.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CatSpinnerTool.h"
#import "CatSpinnerList.h"

@implementation CatSpinnerModel

@end
@implementation CatSpinnerTool

+(NSArray *)tranformArrayWithArray:(NSArray<NSString *> *)itemArr iconArr:(NSArray<NSString *> *)iconArr catSpinnerList:(CatSpinnerList *)catSpinnerList{
    NSMutableArray* muaArr = @[].mutableCopy;
    CGFloat maxWidth = 0.0f;
    //判断是否有图片数组
    BOOL hasIcon = iconArr.count>0;
    for (NSInteger i = 0; i < itemArr.count; i++) {
        CatSpinnerModel* model = [CatSpinnerModel new];
        model.itemContent = itemArr[i];
        model.textColor = RGBA(0, 0, 0, 1);
        model.backColor = [UIColor whiteColor];
        //取最长的内容
        
        CGSize size = [itemArr[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, kCatSpinnerListCellHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:RF(17.0f)} context:nil].size;
        if (size.width > maxWidth) {
            maxWidth = size.width;
        }
        if (hasIcon) {
            model.itemIconName = i<iconArr.count?iconArr[i]:nil;
        }
        [muaArr addObject:model];
    }
    
    if (hasIcon) {
        maxWidth += RH(72.0f);
    }else{
        maxWidth += RH(40.0f);
    }
    
    //设置宽度
    for (CatSpinnerModel* model in muaArr) {
        model.modelWidth = maxWidth;
    }
    return [muaArr copy];
}

@end
