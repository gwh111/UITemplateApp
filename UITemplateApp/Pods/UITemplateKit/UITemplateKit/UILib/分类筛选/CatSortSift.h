//
//  CatSortSift.h
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/16.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CatSortSiftView.h"

NS_ASSUME_NONNULL_BEGIN

@class CatSortSift;
@protocol CatSortSiftDelegate <NSObject>

@optional
- (void)catSortSift:(CatSortSift *)catSortSift didSelectRowAtSection:(NSInteger)section index:(NSInteger)index;

@end

@interface CatSortSift : NSObject<CatSortSiftViewDelegate>

@property (nonatomic, strong) CatSortSiftView* sortSiftView;

@property (nonatomic, weak) id<CatSortSiftDelegate>delegate;
/**
 初始化
 
 @param frame frame
 @param title 大标题
 @param dataArr 数据
 @param theme 选项列表样式
 */
- (instancetype)initOn:(UIView*)view frame:(CGRect)frame title:(nullable NSString*)title dataArr:(NSArray<CatSortSiftOutModel*>*)dataArr theme:(CatSortSiftTheme)theme;

/**
 更新数据
 
 @param dataArr 数据数组
 */
- (void)updateDataArr:(NSArray<CatSortSiftOutModel*>*)dataArr;

@end

NS_ASSUME_NONNULL_END
