//
//  CatComPagination.m
//  Patient
//
//  Created by ml on 2019/8/8.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatComPagination.h"

@implementation CatPaginator

@end

@interface CatComPagination ()

@property(nonatomic,weak) id<CatComPaginationDelegate> delegate;
@property (nonatomic,strong) CatPaginator *paginator;

@end

@implementation CatComPagination

- (void)setupWithPagination:(CatPaginator *)paginator
                    lastest:(NSArray *)datas
                 completion:(CatComPaginationCompletion)completion {

    self.paginator = paginator;
    /// 空数据
    if (paginator.pages == 0) {
        self.dataSourceProvider = @[];
        if ([self.delegate respondsToSelector:@selector(paginationEmptyAction:)]) {
            [self.delegate paginationEmptyAction:self];
        }
    }else if (paginator.page == 1) {
        self.dataSourceProvider = datas;
    }else {
        NSMutableArray *datasM = [NSMutableArray arrayWithArray:self.dataSourceProvider];
        [datasM addObjectsFromArray:datas];
        self.dataSourceProvider = datasM.copy;
    }
    
    !completion ? : completion();
}

- (instancetype)initWithDelegate:(id<CatComPaginationDelegate>)delegate
                      scrollView:(UIScrollView *)scrollView {
    
    if (self = [super init]) {
        _delegate = delegate;
        _scrollView = scrollView;
    }
    return self;
}

- (BOOL)stopFetchWhenNoMoreData {
    if (!self.paginator) {
        return NO;
    }else if (self.paginator.page == self.paginator.pages ||
              self.paginator.page == 0) {
        return YES;
    }
    return NO;
}

- (void)resetPaginator {
    _paginator = nil;
}

- (void)paginationFetchAction {
    if (_scrollView.contentOffset.y > 0) {
        _direction = NO;
    }else {
        _direction = YES;
    }
    if ([self.delegate respondsToSelector:@selector(paginationFetchAction:)]) {
        [self.delegate paginationFetchAction:self];
    }
}

- (void)forwardPaginationAction {
    if (_scrollView.contentOffset.y > 0) {
        _direction = NO;
    }else {
        _direction = YES;
    }
    if ([self.delegate respondsToSelector:@selector(paginationFetchAction:)]) {
        [self.delegate paginationFetchAction:self];
    }
}

@end
