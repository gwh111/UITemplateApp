//
//  BankCardManageController.m
//  CurrencyKit
//
//  Created by gwh on 2019/11/14.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "BankCardManageC.h"
#import "BankCardManageTableViewCell.h"

@interface BankCardManageC ()

@property (nonatomic, retain) NSArray *accountWithdrawBankSimples;
@property (nonatomic, retain) CC_TableView *tableView;

@end

@implementation BankCardManageC

- (void)updateBankList {
    
    [ccs.accountLib_withdraw accountWithdrawBankQuerySuccess:^(HttpModel * _Nonnull result) {
        
        self.accountWithdrawBankSimples = result.resultDic[@"accountWithdrawBankSimples"];
        [self.tableView reloadData];
    } fail:^(NSString * _Nonnull errorMsg, HttpModel * _Nonnull result) {
        
    }];
}

- (void)cc_willInit {

    _displayView = ccs.View;

    _displayView
    .cc_frame(0, 0, WIDTH(), self.cc_displayView.height)
    .cc_addToView(self.cc_displayView);

    _tableView = ccs.TableView
    .cc_frame(0, RH(10), WIDTH(), _displayView.height - RH(20))
    .cc_delegate(self)
    .cc_dataSource(self)
    .cc_backgroundColor(UIColor.clearColor)
    .cc_addToView(self.cc_displayView);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self updateBankList];
}

//tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _accountWithdrawBankSimples.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return RH(140);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    BankCardManageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[BankCardManageTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier: CellIdentifier];
    } else {
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    NSDictionary *bankDic = _accountWithdrawBankSimples[indexPath.row];
    [cell update:bankDic];
    [cell.setDefaultButton cc_addTappedOnceDelay:.1 withBlock:^(CC_Button *btn) {
       
        if ([btn.titleLabel.text isEqualToString:@"设为默认"]) {
            
            [ccs.accountLib_withdraw accountWithdrawBankSetDefaultWithId:[ccs string:@"%@", bankDic[@"id"]] success:^(HttpModel * _Nonnull result) {
                
                [ccs showNotice:@"设置成功"];
            } fail:^(NSString * _Nonnull errorMsg, HttpModel * _Nonnull result) {
                
                [ccs showNotice:errorMsg];
            }];
        }
    }];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
    NSDictionary *bankDic = _accountWithdrawBankSimples[indexPath.row];
    
    [self.cc_delegate cc_performSelector:@selector(controller:tappedWithCardId:) params:self, [ccs string:@"%@", bankDic[@"id"]]];
}

@end
