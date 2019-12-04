//
//  FreezeLogViewController.m
//  CurrencyKit
//
//  Created by gwh on 2019/11/15.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "FreezeLogVC.h"
#import "FreezeLogTableViewCell.h"

@interface FreezeLogVC ()

@property (nonatomic, retain) CC_TableView *tableView;
@property (nonatomic, assign) int currentPage;
@property (nonatomic, retain) NSMutableArray *freezeLogSimples;

@end

@implementation FreezeLogVC

- (void)updateFreezeLogList {
    
    [ccs.accountLib_freeze freezeLogQueryWithCurrentPage:self.currentPage freezeId:@"" pageSize:20 success:^(HttpModel * _Nonnull result) {
        
        [self.freezeLogSimples addObjectsFromArray:result.resultDic[@"freezeLogSimples"]];
        [self.tableView reloadData];
        
    } fail:^(NSString * _Nonnull errorMsg, HttpModel * _Nonnull result) {
        
        [ccs showNotice:errorMsg];
    }];
    
    
}

- (void)cc_viewWillLoad {
    
    self.cc_title = @"冻结日志";

    self.view.backgroundColor = HEX(#F5F5F5);
   
    _tableView = ccs.TableView
    .cc_frame(0, 0, WIDTH(), self.cc_displayView.height)
    .cc_delegate(self)
    .cc_dataSource(self)
    .cc_backgroundColor(UIColor.clearColor)
    .cc_addToView(self.cc_displayView);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)cc_viewDidLoad {
	 // Do any additional setup after loading the view.
    
    _freezeLogSimples = ccs.mutArray;
    
    [self updateFreezeLogList];
}

//tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.freezeLogSimples.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return RH(50);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    FreezeLogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[FreezeLogTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier: CellIdentifier];
    } else {
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    
    if (indexPath.row > 0) {

        NSDictionary *freezeLog = self.freezeLogSimples[indexPath.row - 1];
        cell.timeLabel.text = [ccs string:@"%@", freezeLog[@"gmtCreate"]];
        cell.freezeLabel.text = [ccs string:@"%@", freezeLog[@"freezeAmount"]];
        cell.unFreezeLabel.text = [ccs string:@"%@", freezeLog[@"unfreezeAmount"]];
        cell.leftFreezeLabel.text = [ccs string:@"%@", freezeLog[@"remainFreezeAmount"]];
        cell.memoLabel.text = [ccs string:@"%@", freezeLog[@"memo"]];
    } else {
        
        [cell update];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
}

@end
