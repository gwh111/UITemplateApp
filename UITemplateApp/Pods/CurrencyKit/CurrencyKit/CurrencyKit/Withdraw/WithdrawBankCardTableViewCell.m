//
//  WithdrawBankCardTableViewCell.m
//  CurrencyKit
//
//  Created by gwh on 2019/11/13.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "WithdrawBankCardTableViewCell.h"

@interface WithdrawBankCardTableViewCell ()

@property (nonatomic, retain) CC_ImageView *iconImageView;
@property (nonatomic, retain) CC_Label *bankNameLabel;
@property (nonatomic, retain) CC_Label *bankCardLabel;

@end

@implementation WithdrawBankCardTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        
        self.backgroundColor = UIColor.clearColor;
        
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    _iconImageView = ccs.ImageView
    .cc_frame(RH(20), RH(20), RH(40), RH(40))
    .cc_backgroundColor(UIColor.grayColor)
    .cc_addToView(self);
    
    _bankNameLabel = ccs.Label
    .cc_frame(_iconImageView.right + RH(10), RH(23), RH(200), RH(22))
    .cc_textColor(HEX(#333333))
    .cc_font(BRF(16))
    .cc_text(@"招商银行")
    .cc_addToView(self);
    
    _bankCardLabel = ccs.Label
    .cc_frame(_iconImageView.right + RH(10), _bankNameLabel.bottom, RH(200), RH(22))
    .cc_textColor(HEX(#333333))
    .cc_font(BRF(15))
    .cc_text(@"**** **** **** 4565")
    .cc_addToView(self);
    
    _selectButton = ccs.Button
    .cc_frame(self.width - RH(20), RH(35), RH(15), RH(15))
    .cc_setImageForState(IMAGE(@"withdraw_bankCard_unSelected"), UIControlStateNormal)
    .cc_setImageForState(IMAGE(@"withdraw_bankCard_selected"), UIControlStateSelected)
    .cc_addToView(self);
    
    ccs.View
    .cc_frame(RH(10), RH(70), self.width - RH(20), 1)
    .cc_backgroundColor(HEX(#F5F5F5))
    .cc_addToView(self);
    
    _tapButton = ccs.Button
    .cc_frame(0, 0, self.width, RH(70))
    .cc_addToView(self);
}

- (void)update:(NSDictionary *)bankSimple {
    
    _bankNameLabel.text = bankSimple[@"bankName"];
    _bankCardLabel.text = bankSimple[@"cardNo"];
}

@end
