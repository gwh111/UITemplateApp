//
//  BankChooseController.m
//  CurrencyKit
//
//  Created by gwh on 2019/11/15.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "BankChooseC.h"

@interface BankChooseC ()

@property (nonatomic, retain) CC_View *popView;
@property (nonatomic, retain) NSArray *bankSimples;
@property (nonatomic, retain) CC_TableView *tableView;

@end

@implementation BankChooseC

- (void)updateBankList {
    
    [ccs.accountLib_withdraw withdrawSupportBankQuerySuccess:^(HttpModel * _Nonnull result) {
        
        self.bankSimples = result.resultDic[@"bankSimples"];
        [self.tableView reloadData];
    } fail:^(NSString * _Nonnull errorMsg, HttpModel * _Nonnull result) {
        
    }];
}

- (void)dismiss {
    
    [UIView animateWithDuration:.2 animations:^{
        
        self.popView.top = HEIGHT();
        self.displayView.alpha = 0;
    } completion:^(BOOL finished) {

        [self.displayView removeFromSuperview];
    }];
}

- (void)showBankChooseOn:(UIView *)view {
    
    _displayView = ccs.View
    .cc_backgroundColor(HEXA(#000000, 0.5))
    .cc_addToView(view);
    _displayView.frame = view.frame;
    
    _popView = ccs.View
    .cc_frame(0, HEIGHT(), WIDTH(), RH(400))
    .cc_backgroundColor(HEX(#FFFFFF))
    .cc_cornerRadius(10)
    .cc_addToView(_displayView);
    [UIView animateWithDuration:.3 animations:^{
        
        self.popView.bottom = HEIGHT();
    }];
    
    ccs.Label
    .cc_frame(0, RH(10), WIDTH(), RH(40))
    .cc_text(@"选择银行类型")
    .cc_textAlignment(NSTextAlignmentCenter)
    .cc_font(BRF(17))
    .cc_textColor(HEX(#333333))
    .cc_addToView(_popView);
    
    CC_Button *closeButton = ccs.Button;
    closeButton
    .cc_frame(_popView.width - RH(45), RH(15), RH(30), RH(30))
    .cc_setTitleColorForState(HEX(#B8B8B8), UIControlStateNormal)
    .cc_font(BRF(15))
    .cc_setTitleForState(@"X", UIControlStateNormal)
    .cc_addToView(_popView);
    [closeButton cc_addTappedOnceDelay:.1 withBlock:^(CC_Button *btn) {
        
        [self dismiss];
    }];
    
    _tableView = ccs.TableView
    .cc_frame(RH(20), RH(50), WIDTH() - RH(40), _popView.height - RH(50))
    .cc_delegate(self)
    .cc_dataSource(self)
    .cc_backgroundColor(UIColor.clearColor)
    .cc_addToView(_popView);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self updateBankList];
}

//tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _bankSimples.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return RH(50);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier: CellIdentifier];
    } else {
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    NSDictionary *bankDic = _bankSimples[indexPath.row];
    cell.textLabel.text = bankDic[@"name"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
    [self.cc_delegate cc_performSelector:@selector(controller:tappedWithBankDic:) params:self, _bankSimples[indexPath.row]];

    [self dismiss];
}

@end
