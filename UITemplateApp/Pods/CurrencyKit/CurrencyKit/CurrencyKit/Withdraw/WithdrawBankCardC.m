//
//  WithdrawBankCardController.m
//  CurrencyKit
//
//  Created by gwh on 2019/11/13.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "WithdrawBankCardC.h"
#import "WithdrawBankCardTableViewCell.h"
#import "CurrencyConfig.h"

@interface WithdrawBankCardC ()

@property (nonatomic, retain) CC_View *popView;
@property (nonatomic, assign) NSUInteger currentSelected;
@property (nonatomic, retain) CC_TableView *tableView;
@property (nonatomic, retain) NSArray *accountWithdrawBankSimples;

@end

@implementation WithdrawBankCardC

- (void)updateBankList {
    
    [ccs.accountLib_withdraw accountWithdrawBankQuerySuccess:^(HttpModel * _Nonnull result) {
        
        self.accountWithdrawBankSimples = result.resultDic[@"accountWithdrawBankSimples"];
        [self.tableView reloadData];
    } fail:^(NSString * _Nonnull errorMsg, HttpModel * _Nonnull result) {
        
    }];
}

- (void)showBankCardOn:(UIView *)view {
    
    _displayView = ccs.View
    .cc_backgroundColor(HEXA(#000000, 0.5))
    .cc_addToView(view);
    _displayView.frame = view.frame;
    
    _popView = ccs.View
    .cc_frame(RH(40), HEIGHT()/2 - RH(150), WIDTH() - RH(80), RH(300))
    .cc_backgroundColor(UIColor.whiteColor)
    .cc_cornerRadius(10)
    .cc_addToView(_displayView);
    
    ccs.Label
    .cc_frame(RH(20), RH(10), RH(100), RH(40))
    .cc_text(@"选择银行卡")
    .cc_font(BRF(17))
    .cc_textColor(HEX(#333333))
    .cc_addToView(_popView);
    
    CC_Button *addCardButton = ccs.Button
    .cc_frame(_popView.width - RH(80), RH(10), RH(70), RH(30))
    .cc_font(RF(12))
    .cc_setTitleColorForState(HEX(#F8492F), UIControlStateNormal)
    .cc_setTitleForState(@"+添加银行卡", UIControlStateNormal)
    .cc_addToView(_popView);
    [addCardButton cc_addTappedOnceDelay:.1 withBlock:^(CC_Button *btn) {
        [self.cc_delegate cc_performSelector:@selector(gotoAddBankCardViewController) params:nil];
    }];
    
    ccs.View
    .cc_frame(0, _popView.height - RH(50), _popView.width, 1)
    .cc_backgroundColor(HEX(#F5F5F5))
    .cc_addToView(_popView);
    
    ccs.View
    .cc_frame(_popView.width/2, _popView.height - RH(50), 1, RH(40))
    .cc_backgroundColor(HEX(#F5F5F5))
    .cc_addToView(_popView);
    
    CC_Button *cancelButton = ccs.Button
    .cc_frame(0, _popView.height - RH(50), _popView.width/2, RH(50))
    .cc_font(RF(16))
    .cc_setTitleColorForState(HEX(#333333), UIControlStateNormal)
    .cc_setTitleForState(@"取消", UIControlStateNormal)
    .cc_addToView(_popView);
    [cancelButton cc_addTappedOnceDelay:.1 withBlock:^(CC_Button *btn) {
        
        [self->_displayView removeFromSuperview];
    }];
    
    UIColor *buttonColor = CurrencyConfig.shared.chooseButtonTextColor;
    
    CC_Button *doneButton = ccs.Button
    .cc_frame(_popView.width/2, _popView.height - RH(50), _popView.width/2, RH(50))
    .cc_font(RF(16))
    .cc_setTitleColorForState(buttonColor, UIControlStateNormal)
    .cc_setTitleForState(@"确定", UIControlStateNormal)
    .cc_addToView(_popView);
    [doneButton cc_addTappedOnceDelay:.1 withBlock:^(CC_Button *btn) {
        
        [self.cc_delegate cc_performSelector:@selector(controller:bankSelected:) params:self, self.accountWithdrawBankSimples[self.currentSelected]];
        [self.displayView removeFromSuperview];
    }];
    
    [self addCard];
    [self updateBankList];
}

- (void)addCard {
    
    _tableView = ccs.TableView
    .cc_frame(0, RH(50), _popView.width, RH(200))
    .cc_delegate(self)
    .cc_dataSource(self)
    .cc_backgroundColor(UIColor.whiteColor)
    .cc_addToView(_popView);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

//tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.accountWithdrawBankSimples.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return RH(70);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    WithdrawBankCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[WithdrawBankCardTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier: CellIdentifier];
    } else {
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    if (indexPath.row == _currentSelected) {
        cell.selectButton.selected = YES;
    } else {
        cell.selectButton.selected = NO;
    }
    
    [cell.tapButton cc_addTappedOnceDelay:.1 withBlock:^(CC_Button *btn) {
        
        self.currentSelected = indexPath.row;
        [tableView reloadData];
    }];
    [cell update:self.accountWithdrawBankSimples[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
}

@end
