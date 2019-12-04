//
//  ChargeTableViewCell.m
//  CurrencyKit
//
//  Created by gwh on 2019/11/12.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "ChargeTableViewCell.h"

@interface ChargeTableViewCell ()

@property (nonatomic, retain) CC_ImageView *iconImageView;
@property (nonatomic, retain) CC_Label *chargeNameLabel;
@property (nonatomic, retain) CC_Label *chargeSummaryLabel;
@property (nonatomic, retain) CC_Label *limitLabel;

@end

@implementation ChargeTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        
        self.backgroundColor = UIColor.clearColor;
        
        [self initUI];
    }
    return self;
}

- (void)initUI {
    _selectButton = ccs.Button
    .cc_frame(RH(15), RH(15), RH(20), RH(20))
    .cc_setImageForState(IMAGE(@"bankChoose_unSelected"), UIControlStateNormal)
    .cc_setImageForState(IMAGE(@"bankChoose_selected"), UIControlStateSelected)
    .cc_addToView(self);
    
    _iconImageView = ccs.ImageView
    .cc_backgroundColor(UIColor.clearColor)
    .cc_frame(_selectButton.right + RH(10), RH(5), RH(40), RH(40))
    .cc_addToView(self);
    
    _chargeNameLabel = ccs.Label
    .cc_frame(_iconImageView.right + RH(10), RH(8), RH(200), RH(22))
    .cc_textColor(HEX(#333333))
    .cc_font(RF(16))
    .cc_text(@"微信扫码支付")
    .cc_addToView(self);
    
    _chargeSummaryLabel = ccs.Label
    .cc_frame(_iconImageView.right + RH(10), _chargeNameLabel.bottom, RH(200), RH(15))
    .cc_textColor(HEX(#999999))
    .cc_font(RF(11))
    .cc_text(@"文案补充")
    .cc_addToView(self);
    
    _limitLabel = ccs.Label
    .cc_frame(WIDTH() - RH(100), _chargeNameLabel.bottom, RH(90), RH(15))
    .cc_textColor(HEX(#BFBFBF))
    .cc_font(RF(11))
    .cc_text(@"限额（0-10000）")
    .cc_addToView(self);
    
    _tapButton = ccs.Button;
    _tapButton.frame = self.frame;
    [self cc_addSubview:_tapButton];
    
}

- (void)update:(NSDictionary *)updateData {
    
    _chargeNameLabel.text = updateData[@"channelBankName"];
    _chargeSummaryLabel.text = updateData[@"userInstruction"];
    _limitLabel.text = [ccs string:@"限额（%@-%@）", updateData[@"minAllowAmount"], updateData[@"maxAllowAmount"]];
    [_iconImageView cc_setImageWithURL:[NSURL URLWithString:updateData[@"channelLogoUrl"]]];
}

@end
