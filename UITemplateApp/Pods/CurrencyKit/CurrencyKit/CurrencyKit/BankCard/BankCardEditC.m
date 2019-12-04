//
//  BankCardAddController.m
//  CurrencyKit
//
//  Created by gwh on 2019/11/13.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "BankCardEditC.h"
#import "CurrencyConfig.h"

@interface BankCardEditC ()

@property (nonatomic, retain) NSArray *names;
@property (nonatomic, retain) CC_Label *bankTypeLabel;
@property (nonatomic, retain) CC_Label *bankProviceLabel;
@property (nonatomic, retain) CC_Label *subBankTypeLabel;

@end

@implementation BankCardEditC

static NSString *TEXT_BANK_TYPE = @"请选择银行类型";
static NSString *TEXT_BANK_PROVICE = @"请选择开户支行省市";
static NSString *TEXT_SUB_BANK = @"请选择开户支行";

- (void)cc_willInit {
    
    _names = @[@"银行卡号", @"银行类型", @"支行省市", @"开户支行", @"设为默认"];
    
    _displayView = ccs.View;
    
    _displayView
    .cc_frame(0, RH(5), WIDTH(), RH(250))
    .cc_backgroundColor(UIColor.whiteColor)
    .cc_addToView(self.cc_displayView);
    
    CC_TableView *tableView = ccs.TableView
    .cc_frame(0, 0, WIDTH(), RH(250))
    .cc_delegate(self)
    .cc_dataSource(self)
    .cc_backgroundColor(UIColor.whiteColor)
    .cc_addToView(self.cc_displayView);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [tableView cc_tappedInterval:.1 withBlock:^(id  _Nonnull view) {
        [self textFieldResignFirstResponder];
    }];
    
}

- (void)textFieldResignFirstResponder {
    [self.cardNumberTextField resignFirstResponder];
}

//tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _names.count;
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
    NSUInteger row = indexPath.row;
    
    cell.textLabel.text = _names[row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (row == 0) {
        _cardNumberTextField = ccs.TextField
        .cc_frame(WIDTH() - RH(220), 0, RH(200), RH(50))
        .cc_textAlignment(NSTextAlignmentRight)
        .cc_placeholder(@"请输入相应的卡号")
        .cc_delegate(self)
        .cc_font(RF(15))
        .cc_addToView(cell);
        _cardNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    } else if (row == 1) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _bankTypeLabel = ccs.Label
        .cc_frame(WIDTH() - RH(200), RH(10), RH(160), RH(30))
        .cc_textColor(HEX(#999999))
        .cc_font(RF(15))
        .cc_textAlignment(NSTextAlignmentRight)
        .cc_text(TEXT_BANK_TYPE)
        .cc_addToView(cell);
        [_bankTypeLabel cc_tappedInterval:.1 withBlock:^(id  _Nonnull view) {

            [self textFieldResignFirstResponder];
            [self.cc_delegate cc_performSelector:@selector(popBankChooseController) params:nil];
        }];
    } else if (row == 2) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _bankProviceLabel = ccs.Label
        .cc_frame(WIDTH() - RH(200), RH(10), RH(160), RH(30))
        .cc_textColor(HEX(#999999))
        .cc_font(RF(15))
        .cc_textAlignment(NSTextAlignmentRight)
        .cc_text(TEXT_BANK_PROVICE)
        .cc_addToView(cell);
        [_bankProviceLabel cc_tappedInterval:.1 withBlock:^(id  _Nonnull view) {

            [self textFieldResignFirstResponder];
            [self.cc_delegate cc_performSelector:@selector(popAreaChooseViewController) params:nil];
        }];
    } else if (row == 3) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _subBankTypeLabel = ccs.Label
        .cc_frame(WIDTH() - RH(200), RH(10), RH(160), RH(30))
        .cc_textColor(HEX(#999999))
        .cc_font(RF(15))
        .cc_textAlignment(NSTextAlignmentRight)
        .cc_text(TEXT_SUB_BANK)
        .cc_addToView(cell);
        [_subBankTypeLabel cc_tappedInterval:.1 withBlock:^(id  _Nonnull view) {
            
            [self.cc_delegate cc_performSelector:@selector(gotoSubBankChooseViewController) params:nil];
        }];
    } else if (row == 4) {
        _defaultSelectSwitch = [ccs init:UISwitch.class];
        _defaultSelectSwitch.cc_frame(WIDTH() - RH(70), RH(10), RH(40), RH(30))
        .cc_addToView(cell);
        _defaultSelectSwitch.on = YES;
        UIColor *color = CurrencyConfig.shared.doneButtonColor;
        _defaultSelectSwitch.onTintColor = color;
    }
    
    ccs.View
    .cc_frame(RH(25), RH(50) - 1, WIDTH() - RH(50), 1)
    .cc_backgroundColor(HEX(#F5F5F5))
    .cc_addToView(cell);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
}

- (void)updateCardNumber:(NSString *)cardNumberString {
    
    _cardNumberTextField.text = cardNumberString;
}

- (void)updateBank:(NSString *)bankString {
    
    _bankTypeLabel.text = bankString;
    [self update];
}

- (void)updateArea:(NSString *)areaString {
    
    _bankProviceLabel.text = areaString;
}

- (void)updateSubBank:(NSString *)bankString {
    
    _subBankTypeLabel.text = bankString;
    [self update];
}

- (void)update {
    
    if (_cardNumberTextField.text.length > 0 &&
        ![_bankTypeLabel.text isEqualToString:TEXT_BANK_TYPE] &&
        ![_bankProviceLabel.text isEqualToString:TEXT_BANK_PROVICE] &&
        ![_subBankTypeLabel.text isEqualToString:TEXT_SUB_BANK]) {
        
        [self.cc_delegate cc_performSelector:@selector(updateInfoFinish:) params:[CC_Int value:1]];
    } else {
        
        [self.cc_delegate cc_performSelector:@selector(updateInfoFinish:) params:[CC_Int value:0]];
    }
    
}

@end
