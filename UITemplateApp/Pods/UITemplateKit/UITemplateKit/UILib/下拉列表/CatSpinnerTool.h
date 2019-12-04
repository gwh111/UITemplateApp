//
//  CatSpinnerTool.h
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/5.
//  Copyright © 2019 gwh. All rights reserved.
//

#define kCatSpinnerListCellHeight RH(48.0f)
#import <Foundation/Foundation.h>
#import "ccs.h"

NS_ASSUME_NONNULL_BEGIN

@class CatSpinnerList;
@interface CatSpinnerModel : NSObject
//内容
@property (nonatomic, strong) NSString* itemContent;
//图片名
@property (nonatomic, strong) NSString* itemIconName;
//宽度
@property (nonatomic, assign) CGFloat modelWidth;
//文字颜色
@property (nonatomic, strong) UIColor* textColor;
//背景颜色
@property (nonatomic, strong) UIColor* backColor;

@end

@interface CatSpinnerTool : NSObject

/**
 把标题数组转模型数组

 @param itemArr 标题数组
 @param iconArr 图片名数组
 @param catSpinnerList 下拉列表
 @return 模型数组
 */
+ (NSArray*)tranformArrayWithArray:(NSArray<NSString*>*)itemArr iconArr:(NSArray<NSString*>*)iconArr catSpinnerList:(CatSpinnerList*)catSpinnerList;

@end

NS_ASSUME_NONNULL_END
