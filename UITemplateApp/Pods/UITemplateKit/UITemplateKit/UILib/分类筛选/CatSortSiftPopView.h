//
//  CatSortSiftPopView.h
//  Doctor
//
//  Created by 路飞 on 2019/6/13.
//  Copyright © 2019 gwh. All rights reserved.
//

#define kCatSortSiftPopViewHeight  RH(374.0f)

#import <UIKit/UIKit.h>
#import "ccs.h"

NS_ASSUME_NONNULL_BEGIN

@class CatSortSiftPopView;
@protocol CatSortSiftPopViewDelegate <NSObject>
@optional
//选中左侧index
- (void)catSortSiftPopViewSelect:(CatSortSiftPopView*)catSortSiftPopView leftIndex:(NSInteger)leftIndex;
//选中两侧index
- (void)catSortSiftPopViewSelect:(CatSortSiftPopView*)catSortSiftPopView leftIndex:(NSInteger)leftIndex rightIndex:(NSInteger)rightIndex;

@end

@interface CatSortSiftPopView : UIView

@property (nonatomic, weak) id<CatSortSiftPopViewDelegate>delegate;
@property (nonatomic, strong,readonly) UITableView* leftTableV;
@property (nonatomic, strong,readonly) UITableView* rightTableV;

/// 默认选中字体
@property (nonatomic,strong) UIColor *defaultSelectedTextColor;
/// 默认选中背景色
@property (nonatomic,strong) UIColor *defaultSelectedBackgroundColor;

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
 初始化
 
 @param title 标题
 @param leftSelectImage 左边选中指示图片
 @param rightSelectImage 右边选中指示图片
 @param leftSelectIndex 左边选中索引
 @param rightSelectIndex 右边选中索引
 @param array 数据
 @param height 高度
 @return 实例
 */
- (instancetype)initWithTitle:(NSString*)title leftSelectImage:(UIImage*)leftSelectImage rightSelectImage:(UIImage*)rightSelectImage leftSelectIndex:(NSInteger)leftSelectIndex rightSelectIndex:(NSInteger)rightSelectIndex array:(NSArray*)array height:(CGFloat)height;

/**
 更新左侧选择索引对应的右侧数据
 
 @param leftSelectIndex 左边选中索引
 @param rightSelectIndex 右边选中索引
 @param rightArr 右侧数据
 */
- (void)updateLeftSelectIndex:(NSInteger)leftSelectIndex rightSelectIndex:(NSInteger)rightSelectIndex rightArr:(NSArray*)rightArr;

@end

NS_ASSUME_NONNULL_END
