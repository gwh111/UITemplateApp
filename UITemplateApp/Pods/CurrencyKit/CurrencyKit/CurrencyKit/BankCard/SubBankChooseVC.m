//
//  BankChooseViewController.m
//  CurrencyKit
//
//  Created by gwh on 2019/11/13.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "SubBankChooseVC.h"
#import "CurrencyConfig.h"
#import "SubBankChooseTableViewCell.h"

@interface SubBankChooseVC ()

@property (nonatomic, retain) CC_TableView *tableView;
@property (nonatomic, retain) CC_TextField *searchTextField;
@property (nonatomic, retain) NSArray *bankSubbranchSimples;
@property (nonatomic, assign) int currentIndex;
@property (nonatomic, retain) NSMutableArray *bankList;

@end

@implementation SubBankChooseVC

- (void)updateBankList {
    
    [ccs.financeLib_bank bankSubbranchQueryWithBankId:@"8" cityId:@"127" districtId:@"1485" provinceId:@"5" success:^(HttpModel * _Nonnull result) {
        
        self.bankSubbranchSimples = result.resultDic[@"bankSubbranchSimples"];
        self.bankList = self.bankSubbranchSimples.mutableCopy;
        [self.tableView reloadData];
        float height = self.bankSubbranchSimples.count * RH(50);
        if (height > self.cc_displayView.height - RH(100)) {
            height = self.cc_displayView.height - RH(100);
        }
        self.tableView.height = height;
        
    } fail:^(NSString * _Nonnull errorMsg, HttpModel * _Nonnull result) {
        
        [ccs showNotice:errorMsg];
    }];
}

- (void)cc_viewWillLoad {
    
    self.view.backgroundColor = HEX(#F5F5F5);
   
    CC_View *searchView = ccs.View
    .cc_frame(RH(30), RH(50), RH(280), RH(35))
    .cc_backgroundColor(HEX(#F2F2F2))
    .cc_cornerRadius(RH(17))
    .cc_addToView(self.cc_navigationBar);
    searchView.bottom = self.cc_navigationBar.height - RH(5);
    
    _searchTextField = ccs.TextField
    .cc_frame(RH(20), 0, searchView.width, RH(35))
    .cc_placeholder(@"请输入支行关键词")
    .cc_font(RF(13))
    .cc_addToView(searchView);
    _searchTextField.delegate = self;
    [_searchTextField addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventEditingChanged];
    
    CC_Button *button = ccs.Button
    .cc_frame(0, 0, RH(60), RH(35))
    .cc_setTitleColorForState(HEX(#333333), UIControlStateNormal)
    .cc_font(RF(16))
    .cc_setTitleForState(@"搜索", UIControlStateNormal)
    .cc_addToView(self.cc_navigationBar);
    button.right = self.cc_navigationBar.width - RH(5);
    button.bottom = self.cc_navigationBar.height - RH(5);
    [button cc_addTappedOnceDelay:.1 withBlock:^(CC_Button *btn) {
        
        [self filter];
    }];
    
    _tableView = ccs.TableView
    .cc_frame(0, 0, WIDTH(), self.cc_displayView.height)
    .cc_delegate(self)
    .cc_dataSource(self)
    .cc_backgroundColor(UIColor.whiteColor)
    .cc_addToView(self.cc_displayView);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIColor *buttonColor = CurrencyConfig.shared.doneButtonColor;
    UIColor *buttonTitleColor = CurrencyConfig.shared.doneButtonTextColor;
    float buttonRadius = CurrencyConfig.shared.doneButtonRadius;
    
    CC_Button *doneButton = ccs.Button
    .cc_frame(RH(20), self.cc_displayView.height - RH(80), WIDTH() - RH(40), RH(40))
    .cc_cornerRadius(buttonRadius)
    .cc_backgroundColor(buttonColor)
    .cc_setTitleColorForState(buttonTitleColor, UIControlStateNormal)
    .cc_setTitleForState(@"确认", UIControlStateNormal)
    .cc_addToView(self);
    [doneButton cc_addTappedOnceDelay:.1 withBlock:^(CC_Button *btn) {

        [ccs popViewControllerFrom:self userInfo:self.bankList[self.currentIndex]];
    }];
}

- (void)cc_viewDidLoad {
	 // Do any additional setup after loading the view.
    
    [self.cc_displayView cc_tappedInterval:.1 withBlock:^(id  _Nonnull view) {
        [self.searchTextField resignFirstResponder];
    }];
    
    [self updateBankList];
}

- (void)changedTextField:(CC_TextField *)textField {
    
    NSString *text = textField.text;
    if (text.length <= 0) {
        _bankList = self.bankSubbranchSimples.mutableCopy;
        [_tableView reloadData];
        return;
    }
}

- (void)filter {
    
    [_searchTextField resignFirstResponder];
    NSString *text = _searchTextField.text;
    if (text.length <= 0) {
        _bankList = self.bankSubbranchSimples.mutableCopy;
        [_tableView reloadData];
        return;
    }
    _bankList = ccs.mutArray;
    for (int i = 0; i < self.bankSubbranchSimples.count; i++) {
        
        NSDictionary *bankDic = self.bankSubbranchSimples[i];
        NSString *name = bankDic[@"bankSubbranchName"];
        if ([name containsString:text]) {
            [_bankList addObject:bankDic];
        }
    }
    [_tableView reloadData];
}

//tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bankList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return RH(50);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    SubBankChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SubBankChooseTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier: CellIdentifier];
    } else {
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    NSDictionary *bankDic = self.bankList[indexPath.row];
    cell.bankNameLabel.text = bankDic[@"bankSubbranchName"];
    
    if (_currentIndex == indexPath.row) {
        cell.selectButton.selected = YES;
    } else {
        cell.selectButton.selected = NO;
    }
    
    [cell.tapButton cc_addTappedOnceDelay:.1 withBlock:^(CC_Button *btn) {
       
        self.currentIndex = (int)indexPath.row;
        [tableView reloadData];
    }];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
}

@end
