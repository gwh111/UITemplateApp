//
//  CatComPagination.h
//  Patient
//
//  Created by ml on 2019/8/8.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ccs.h"

NS_ASSUME_NONNULL_BEGIN


@interface CatPaginator : NSObject

@property (nonatomic,assign) NSInteger items;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger itemsPerPage;
@property (nonatomic,assign) NSInteger pages;

@end

@class CatComPagination;

@protocol CatComPaginationDelegate <NSObject>

/**
 分页操作逻辑

 @param pagination 分页逻辑对象
 */
- (void)paginationFetchAction:(CatComPagination *)pagination;

@optional

/**
 设置占位图

 @param pagination 分页逻辑对象
 */
- (void)paginationEmptyAction:(CatComPagination *)pagination;

@end

typedef void (^CatComPaginationCompletion)(void);

/**
 Usage:
 #import "CatComPagination.h"
 
 @property (nonatomic,strong) CatComPagination *pagination;
 ....
 
 _pagination = [[CatComPagination alloc] initWithDelegate:self scrollView:_tableView];
 
 WS(weakSelf)
 MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    SS(strongSelf);
    [strongSelf.pagination forwardPaginationAction];
 }];
 _tableView.mj_header = header;
 
 MJRefreshBackStateFooter *footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
    SS(strongSelf)
    [strongSelf.pagination forwardPaginationAction];
 }];
 _tableView.mj_footer = footer;
 
 - (void)paginationFetchAction:(CatComPagination *)pagination {
    CatComPaginationCompletion completion = nil;
    if (pagination.direction) {
        // 分页参数设置 第一页
        currentPage = 1
 
        /// 回调
        completion = ^{
            [self.tableView.mj_footer resetNoMoreData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
        };
    }else {
        if ([pagination stopFetchWhenNoMoreData]) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
 
        /// 分页参数设置 下一页
        /// currentPage++;
 
        completion = ^{
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
        };
    }
 
     /// 可选,不同索引设置不同参数
     if (index == 0) {
     }else if (index == 1) {
     }
 
    /// 发送请求
    [[CC_HttpTask getInstance] post:CC_MAIN_URL params:nil model:nil finishCallbackBlock:^(NSString *error, ResModel *result) {
        if (error) {
            [CC_NoticeView showError:error];
        }else {
            if (result) {
                NSDictionary *resp = result.resultDic[@"response"];
                /// 传递分页器 && 最新数据
                [_pagination setupWithPagination:paginator
                                         lastest:resp[@"xxx"]
                                      completion:completion];
            }
        }
    }];
 }
 
 - (void)paginationEmptyAction:(CatComPagination *)pagination {
    /// 设置占位图
 }
 
 /// 可选
 /// 在分页器代理中设置index
 - (void)catPager:(CatPager *)catPager didSelectRowAtIndex:(NSInteger)index {
    _pagination.index = index;
    [_pagination forwardPaginationAction];
 }
 
 */
@interface CatComPagination : NSObject

/** 将原来放在控制器中的数据源移到这里 */
@property(nonatomic,copy) NSArray *dataSourceProvider;

/** 分页器 */
@property (nonatomic,strong,readonly) CatPaginator *paginator;
@property(nonatomic,weak) UIScrollView *scrollView;

/** YES:下拉刷新 NO 上拉:加载更多 */
@property(nonatomic,assign) BOOL direction;

/** 由外界提供的索引值,多个UITableView的情况下有用 */
@property(nonatomic,assign) NSInteger index;

/**
 1. 创建分页逻辑对象

 @param delegate 代理对象
 @param scrollView 绑定的滚动视图
 @return 分页逻辑对象
 */
- (instancetype)initWithDelegate:(id<CatComPaginationDelegate>)delegate
                      scrollView:(UIScrollView *)scrollView;

/**
 2.外部手动调用,用于触发代理的 paginationFetchAction: 方法以实现具体的分页逻辑
 */
- (void)forwardPaginationAction;

/**
 3.请求结束后,通过该方法传递分页器与本次请求获得的数据进行逻辑处理
 
 @param paginator 分页器
 @param datas 本次请求获得的数据
 @param completion 数据拼接完成后的回调
 */
- (void)setupWithPagination:(CatPaginator *)paginator
                    lastest:(NSArray *)datas
                 completion:(CatComPaginationCompletion)completion;

/**
 是否已到最后一页
 
 @return 是否是最后一页
 */
- (BOOL)stopFetchWhenNoMoreData;

/**
 重置分页器对象
 */
- (void)resetPaginator;


- (void)paginationFetchAction CC_DEPRECATED("Using forwardPaginationAction");


@end

NS_ASSUME_NONNULL_END
