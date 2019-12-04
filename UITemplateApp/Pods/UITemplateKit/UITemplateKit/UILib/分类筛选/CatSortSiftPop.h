//
//  CatSortSiftPop.h
//  Doctor
//
//  Created by 路飞 on 2019/6/13.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CatSortSiftPopView.h"

NS_ASSUME_NONNULL_BEGIN

@class CatSortSiftPop;
@protocol CatSortSiftPopDelegate <NSObject>
@optional
//选中左侧index
- (void)catSortSiftPopSelect:(CatSortSiftPop*)catSortSiftPop leftIndex:(NSInteger)leftIndex;
//选中两侧index
- (void)catSortSiftPopSelect:(CatSortSiftPop*)catSortSiftPop leftIndex:(NSInteger)leftIndex rightIndex:(NSInteger)rightIndex;

@end
/**
 左右两列筛选
 */
@interface CatSortSiftPop : NSObject

@property (nonatomic, strong, readonly) NSString* title;
@property (nonatomic, strong, readonly) UIImage* leftSelectImage;
@property (nonatomic, strong, readonly) UIImage* rightSelectImage;
@property (nonatomic, assign, readonly) NSInteger leftSelectIndex;
@property (nonatomic, assign, readonly) NSInteger rightSelectIndex;
@property (nonatomic, strong, readonly) NSArray* array;
@property (nonatomic, strong, readonly) CatSortSiftPopView* sortSiftPopView;

@property (nonatomic, weak) id<CatSortSiftPopDelegate>delegate;
/**
 初始化

 @param title 标题
 @param leftSelectImage 左边选中指示图片
 @param rightSelectImage 右边选中指示图片
 @param leftSelectIndex 左边选中索引
 @param rightSelectIndex 右边选中索引
 @param array 数据
 @return 实例
 */
- (instancetype)initWithTitle:(NSString*)title leftSelectImage:(UIImage*)leftSelectImage rightSelectImage:(UIImage*)rightSelectImage leftSelectIndex:(NSInteger)leftSelectIndex rightSelectIndex:(NSInteger)rightSelectIndex array:(NSArray*)array;

/**
 弹出列表选择控件
 */
- (void)popUpCatSortSiftPopView;

/**
 隐藏列表选择控件
 */
- (void)dismissCatSortSiftPopView;

/**
 更新左侧选择索引对应的右侧数据

 @param leftSelectIndex 左边选中索引
 @param rightSelectIndex 右边选中索引
 @param rightArr 右侧数据
 */
- (void)updateLeftSelectIndex:(NSInteger)leftSelectIndex rightSelectIndex:(NSInteger)rightSelectIndex rightArr:(NSArray*)rightArr;

@end

NS_ASSUME_NONNULL_END
