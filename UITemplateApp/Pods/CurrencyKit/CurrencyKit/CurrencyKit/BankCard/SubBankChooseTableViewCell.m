//
//  BankChooseTableViewCell.m
//  CurrencyKit
//
//  Created by gwh on 2019/11/15.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "SubBankChooseTableViewCell.h"

@interface SubBankChooseTableViewCell ()

@end

@implementation SubBankChooseTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        
        self.backgroundColor = UIColor.clearColor;
        
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    _selectButton = ccs.Button
    .cc_frame(RH(20), RH(15), RH(20), RH(20))
    .cc_setImageForState(IMAGE(@"bankChoose_unSelected"), UIControlStateNormal)
    .cc_setImageForState(IMAGE(@"bankChoose_selected"), UIControlStateSelected)
    .cc_addToView(self);
    
    _bankNameLabel = ccs.Label
    .cc_frame(RH(50), 0, RH(300), RH(50))
    .cc_textColor(HEX(#333333))
    .cc_font(RF(15))
    .cc_text(@"海南省分行营业部")
    .cc_addToView(self);
    
    _tapButton = ccs.Button
    .cc_frame(0, 0, self.width, RH(50))
    .cc_addToView(self);
}

@end
