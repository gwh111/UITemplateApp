//
//  CatSearchLenovoView.h
//  UITemplateKit
//
//  Created by ml on 2019/7/12.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CatSimpleTableCell.h"

NS_ASSUME_NONNULL_BEGIN
@class CatSearchLenovoView,CatSearchView;

@protocol CatSearchLenovoViewDelegate <NSObject>

/**
 展示联想词条

 @param lenoveView 联想视图
 @param cell cell
 @param keyWord 关键词
 @param index 索引
 @note 若keyWord是字符串,则认为是一个简单的词条,会添加到cell中,减少一些操作,若是模型,则抛给代理对象进行处理
 */
- (void)searchLenovoView:(CatSearchLenovoView *)lenoveView
         willDisplayCell:(CatSimpleTableCell *)cell
                 keyWord:(id)keyWord
                forIndex:(NSInteger)index;

/**
 点击联想词

 @param lenoveView 联想视图
 @param index 索引
 */
- (void)searchLenovoView:(CatSearchLenovoView *)lenoveView
     didSelectRowAtIndex:(NSInteger)index;

@optional

/**
 联想视图手势开始滚动,用于退下系统键盘
 
 @param lenovoView 联想视图
 */
- (void)searchLenovoViewWillBeginDragging:(CatSearchLenovoView *)lenovoView;

@end

@interface CatSearchLenovoView : UIView

@property (nonatomic,copy) NSArray *keyWords;
@property (nonatomic,weak) id<CatSearchLenovoViewDelegate> delegate;
@property (nonatomic,weak) CatSearchView *searchView;
@property (nonatomic,strong,readonly) UITableView *tableView;
/** 发生点击操作,代表一次搜索结束,后面返回的新的结果集,直接忽略 */
@property (nonatomic,assign,getter=isSingleSearchEnd) BOOL singleSearchEnd;

/**
 返回一个联想视图

 @return 联想视图
 */
+ (instancetype)getOne;

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
