//
//  CatSortSiftTool.h
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/16.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ccs.h"

NS_ASSUME_NONNULL_BEGIN

@interface CatSortSiftInModel : NSObject
//图片URL
@property (nonatomic, strong) NSString* imgUrl;
//小类名
@property (nonatomic, strong) NSString* title;
@end

@interface CatSortSiftOutModel : NSObject
//大类名
@property (nonatomic, strong) NSString* headTitle;
//是否选中
@property (nonatomic, assign, getter=isSelect) BOOL select;
//数组
@property (nonatomic, strong) NSArray<CatSortSiftInModel*>* inDataArr;
//item宽度--CatSortSiftThemeHorizontal需用
@property (nonatomic, readonly, assign) CGFloat modelWidth;

@end

@interface CatSortSiftTool : NSObject

+(CGFloat)caculateItemWidth:(NSString*)title;

@end

NS_ASSUME_NONNULL_END
