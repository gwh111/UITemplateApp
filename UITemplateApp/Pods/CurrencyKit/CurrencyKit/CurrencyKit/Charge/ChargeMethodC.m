//
//  ChargePayMethodController.m
//  CurrencyKit
//
//  Created by gwh on 2019/11/12.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "ChargeMethodC.h"
#import "ChargeTableViewCell.h"

#import "CurrencyConfig.h"
#import "ChargeMethod.h"

@interface ChargeMethodC ()

@property (nonatomic, retain) CC_TableView *tableView;
@property (nonatomic, retain) CC_Button *chargeButton;

@property (nonatomic, retain) CC_Money *payMoney;
@property (nonatomic, retain) CC_Money *chargeMoney;
@property (nonatomic, retain) NSArray *fundChannels;
@property (nonatomic, assign) NSUInteger currentIndex;
@property (nonatomic, retain) NSArray *fundChannelChargeRanges;

@property (nonatomic, retain) ChargeMethod *chargeMethod;

@end

@implementation ChargeMethodC

- (void)updatePay:(CC_Money *)payMoney {
    
    _payMoney = payMoney;
    [self calculateChargeMoney];
}

- (void)calculateChargeMoney {

    _chargeMoney = [ccs accountLib_getChargeMoneyWithPayMoney:_payMoney channelIndex:0];
    
    CCLOG(@"_chargeMoney=%@", _chargeMoney.value);
    NSString *chargeString = [ccs string:@"支付%@元（包含服务费%@元）", _payMoney.value, _chargeMoney.value];
    _chargeButton.cc_setTitleForState(chargeString, UIControlStateNormal);
}

- (void)updateFundChannel {

    [ccs.accountLib_deposit fundChannelQueryWithSuccess:^(HttpModel * _Nonnull result) {
        
        self.fundChannels = result.resultDic[@"fundChannels"];
        [self.tableView reloadData];
        self.tableView.height = RH(50) * self.fundChannels.count;
        self.chargeButton.top = self.tableView.bottom + RH(20);
        self.displayView.height = self.chargeButton.bottom;
        
        [self.cc_delegate cc_performSelector:@selector(finishUpdateController:) params:self];
    } fail:^(NSString * _Nonnull errorMsg, HttpModel * _Nonnull result) {
        
        [ccs showNotice:errorMsg];
    }];
    
}

- (void)actionCharge {
    
    if (self.fundChannels.count <= 0) {
        return;
    }

    static BOOL complete = NO;
    static NSString *depositApplyNo;
    [ccs threadBlockSequence:2 block:^(NSUInteger taskIndex, BOOL finish, id sema) {
       
        if (taskIndex == 0) {
            
            [ccs.accountLib_deposit depositApplyNeedIdentifyWithSuccess:^(HttpModel * _Nonnull result) {
                
                if ([result.resultDic[@"needIdentify"] intValue] == YES) {
                    
                    [ccs showNotice:@"需要实名"];
                }
                [ccs threadBlockFinish:sema];
            } fail:^(NSString * _Nonnull errorMsg, HttpModel * _Nonnull result) {
                
                [ccs showNotice:errorMsg];
                [ccs threadBlockFinish:sema];
            }];
        }
        
        if (taskIndex == 1) {
        
            [ccs.accountLib_deposit depositApplyWithChargeFee:self.chargeMoney depositAmount:self.payMoney fundChannelId:self.fundChannels[self.currentIndex][@"id"] success:^(HttpModel * _Nonnull result) {

                depositApplyNo = result.resultDic[@"depositApplyNo"];
                
                if (!self.chargeMethod) {
                    self.chargeMethod = [ccs init:ChargeMethod.class];
                }
                [self.chargeMethod chargeWithChannel:self.fundChannels[self.currentIndex] response:result.resultDic];
                
                complete = YES;
            } fail:^(NSString * _Nonnull errorMsg, HttpModel * _Nonnull result) {
                
                [ccs showNotice:errorMsg];
            }];
        }
        
        if (finish && complete) {
            
            [ccs.accountLib_deposit depositReturnWithDepositApplyNo:depositApplyNo success:^(HttpModel * _Nonnull result) {
                
            } fail:^(NSString * _Nonnull errorMsg, HttpModel * _Nonnull result) {
                
                [ccs showNotice:errorMsg];
            }];
        }
    }];
}

- (void)cc_willInit {
    
    _displayView = ccs.View;

    _displayView
    .cc_frame(0, 0, WIDTH(), RH(300))
    .cc_addToView(self.cc_displayView);

    CC_Label *payMethodTextLabel = ccs.Label;
    payMethodTextLabel
    .cc_frame(RH(15), RH(10), RH(200), RH(35))
    .cc_textColor(HEX(#999999))
    .cc_font(RF(13))
    .cc_text(@"选择支付方式：")
    .cc_addToView(_displayView);
    
    _tableView = ccs.TableView
    .cc_frame(0, payMethodTextLabel.bottom, WIDTH(), RH(50))
    .cc_delegate(self)
    .cc_dataSource(self)
    .cc_backgroundColor(UIColor.whiteColor)
    .cc_addToView(_displayView);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIColor *buttonColor = CurrencyConfig.shared.doneButtonColor;
    UIColor *buttonTitleColor = CurrencyConfig.shared.doneButtonTextColor;
    float buttonRadius = CurrencyConfig.shared.doneButtonRadius;
    
    _chargeButton = ccs.Button
    .cc_frame(RH(20), _tableView.bottom + RH(30), WIDTH() - RH(40), RH(40))
    .cc_cornerRadius(buttonRadius)
    .cc_backgroundColor(buttonColor)
    .cc_setTitleColorForState(buttonTitleColor, UIControlStateNormal)
    .cc_setTitleForState(@"支付5元（包含服务费0.5元）", UIControlStateNormal)
    .cc_addToView(_displayView);
    [_chargeButton cc_addTappedOnceDelay:.1 withBlock:^(CC_Button *btn) {
       
        [self actionCharge];
    }];
    
    [self updateFundChannel];
}

//tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _fundChannels.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return RH(50);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    ChargeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ChargeTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier: CellIdentifier];
    } else {
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    [cell.tapButton cc_addTappedOnceDelay:.1 withBlock:^(CC_Button *btn) {
       
        self.currentIndex = indexPath.row;
        [tableView reloadData];
    }];
    if (_currentIndex == indexPath.row) {
        
        cell.selectButton.selected = YES;
    } else {
        
        cell.selectButton.selected = NO;
    }
    [cell update:_fundChannels[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
    _currentIndex = indexPath.row;
}

@end
