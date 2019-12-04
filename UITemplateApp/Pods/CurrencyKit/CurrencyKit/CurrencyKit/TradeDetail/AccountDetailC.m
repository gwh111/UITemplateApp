//
//  AccountDetailController.m
//  CurrencyKit
//
//  Created by gwh on 2019/11/14.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "AccountDetailC.h"
#import "AccountDetailTableViewCell.h"
#import "MJRefresh.h"

@interface AccountDetailC ()

@property (nonatomic, retain) CC_TableView *tableView;
@property (nonatomic, assign) int currentPage;
@property (nonatomic, retain) NSString *startDate;
@property (nonatomic, retain) NSString *endDate;
@property (nonatomic, retain) NSMutableArray *accountList;

@end

@implementation AccountDetailC

- (void)updateAccountDetail {
    
    _tableView
    .cc_frame(0, 0, WIDTH(), _displayView.height);
    
    if (_currentPage <= 1) {

        _accountList = ccs.mutArray;
    }
    
    [ccs.accountLib_account accountLogPageQueryWithCurrentPage:_currentPage endDate:_endDate pageSize:20 startDate:_startDate success:^(HttpModel * _Nonnull result) {
        
        [self.accountList addObjectsFromArray:result.resultDic[@"accountLogSimples"]];
        [self.tableView reloadData];
        
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{

            if ([result.resultDic[@"paginator"][@"pages"]intValue] > [result.resultDic[@"paginator"][@"page"]intValue]) {

                self.currentPage++;
                [self updateAccountDetail];
            } else {

                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }];
        [self.tableView.mj_footer endRefreshing];
        
    } fail:^(NSString * _Nonnull errorMsg, HttpModel * _Nonnull result) {
        
        [ccs showNotice:errorMsg];
    }];
}

- (void)searchFromDate:(NSString *)fromDate toDate:(NSString *)toDate {
    
    _currentPage = 1;
    _startDate = fromDate;
    _endDate = toDate;
    [self updateAccountDetail];
    
}

- (void)cc_willInit {

    _displayView = ccs.View;

    _displayView
    .cc_frame(0, 0, WIDTH(), RH(60))
    .cc_backgroundColor(UIColor.whiteColor)
    .cc_addToView(self.cc_displayView);

    _tableView = ccs.TableView
    .cc_frame(0, 0, WIDTH(), RH(60))
    .cc_delegate(self)
    .cc_dataSource(self)
    .cc_backgroundColor(UIColor.whiteColor)
    .cc_addToView(_displayView);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    _currentPage = 1;
}

//tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _accountList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return RH(60);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    AccountDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AccountDetailTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier: CellIdentifier];
    } else {
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    
    [cell update:_accountList[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
}

@end
