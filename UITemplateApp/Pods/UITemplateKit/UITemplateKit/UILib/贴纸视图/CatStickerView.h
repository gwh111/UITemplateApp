//
//  CatStickerView.h
//  UITemplateKit
//
//  Created by ml on 2019/7/10.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CatSimpleView.h"
#import "CatStickerViewLayout.h"

NS_ASSUME_NONNULL_BEGIN

@class CatStickerView;

@protocol CatStickerViewDatesource <NSObject>

- (NSInteger)stickerView:(CatStickerView *)stickerView
   numberOfRowsInSection:(NSInteger)section;

/**
 该回调用于对view进行设值与修改
 
 @param stickerView 贴纸视图
 @param view 当前贴纸子视图
 @param indexPath 索引
 @warning view的point由内部自行计算,提供view的size
 */
- (void)stickerView:(CatStickerView *)stickerView
    willDisplayView:(CatCombineView *)view
        atIndexPath:(NSIndexPath *)indexPath;

@optional

/// 默认为1
- (NSInteger)numberOfSectionsInStickerView;

- (CatCombineView *)stickerView:(CatStickerView *)stickerView viewForHeaderInSection:(NSInteger)section;

/**
 自定义子视图
 
 @param stickerView 贴纸视图
 @param indexPath 索引
 @return 子视图
 @note 用于更具体的定义
 */
- (CatCombineView *)stickerView:(CatStickerView *)stickerView
   customViewForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol CatStickerViewDelegate <NSObject>

@optional

- (CatStickerViewLayout *)stickerView:(CatStickerView *)stickerView
                    layoutAtIndexPath:(NSIndexPath *)indexPath;

- (void)stickerView:(CatStickerView *)stickerView didSelectAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface CatStickerView : UIView

@property (nonatomic,strong,readonly) UIScrollView *scrollView;
/** 占位视图,比如选择照片时的提示控件 */
@property (nonatomic,strong) CatCombineView *placeholderView;

/** 头部视图 */
@property (nonatomic,strong) CatCombineView *headerView;
/** 尾视图 */
@property (nonatomic,strong) CatCombineView *footerView;

/** 头部视图是否是否跟随滚动 */
@property (nonatomic,assign) BOOL combineScroll;

/** 设置控件高度 默认会根据内容计算高度,若内容超出屏幕,不容易计算contentSize */
@property (nonatomic,assign) CGFloat fixedHeight;

/**
 是否自动换行 默认自动换行
 scrollView的contentSize为可滚动距离为内容的宽度
 不自动换行的情况下,只支持一组
 */
@property (nonatomic,assign) BOOL autoLinebreak;

/**
 子控件的间距 默认值
     interitemSpacing => RH(6)
     lineSpacing => RH(10)
     marginSectionInset => UIEdgeInsetsMake(0, RH(16), 0, RH(16))
 */
@property (nonatomic,strong) CatStickerViewLayout *layout;
/** 是否允许滚动 */
@property (nonatomic,assign) BOOL scrollable;
@property (nonatomic,weak) id<CatStickerViewDatesource> datasource;
@property (nonatomic,weak) id<CatStickerViewDelegate> delegate;

- (CatCombineView *)stickerViewForIndexPath:(NSIndexPath *)indexPath;


/**
 获得stickerView中所有CatSimpleView类型的视图,不包括headerView和sectionView

 用于选择操作,选中某一行要求其他行隐藏某些属性
 
 @return CatCombineView数组
 */
- (NSArray <CatCombineView *>*)fetchSimpleViews;

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
