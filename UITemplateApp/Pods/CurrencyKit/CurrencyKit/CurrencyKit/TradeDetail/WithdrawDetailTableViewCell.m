//
//  WithdrawDetailTableViewCell.m
//  CurrencyKit
//
//  Created by gwh on 2019/11/13.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "WithdrawDetailTableViewCell.h"

@interface WithdrawDetailTableViewCell ()

@property (nonatomic, retain) CC_Label *moneyLabel;
@property (nonatomic, retain) CC_Label *memoLabel;
@property (nonatomic, retain) CC_Label *cardLabel;
@property (nonatomic, retain) CC_Label *dateLabel;

@end

@implementation WithdrawDetailTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        
        self.backgroundColor = UIColor.clearColor;
        
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    _moneyLabel = ccs.Label
    .cc_frame(RH(10), RH(10), RH(200), RH(25))
    .cc_textColor(HEX(#333333))
    .cc_font(RF(19))
    .cc_text(@"0.02")
    .cc_addToView(self);
    
    _memoLabel = ccs.Label
    .cc_frame(RH(10), _moneyLabel.bottom, RH(200), RH(20))
    .cc_textColor(HEX(#999999))
    .cc_font(RF(11))
    .cc_text(@"提现成功")
    .cc_addToView(self);
    
    _cardLabel = ccs.Label
    .cc_frame(WIDTH() - RH(220), RH(15), RH(200), RH(20))
    .cc_textColor(HEX(#666666))
    .cc_font(RF(11))
    .cc_textAlignment(NSTextAlignmentRight)
    .cc_text(@"农业银行尾号8411")
    .cc_addToView(self);
    
    _dateLabel = ccs.Label
    .cc_frame(WIDTH() - RH(220), _memoLabel.top, RH(200), RH(20))
    .cc_textColor(HEX(#999999))
    .cc_font(RF(11))
    .cc_textAlignment(NSTextAlignmentRight)
    .cc_text(@"2019/09/10 10:13:41")
    .cc_addToView(self);
}

- (void)update:(NSDictionary *)updateData {
    
    _moneyLabel.text = [ccs string:@"%@", updateData[@"amount"]];
    
    NSString *status = updateData[@"status"][@"message"];
    _memoLabel.text = [ccs string:@"%@ 手续费%@元", status, updateData[@"chargeFee"]];
    _cardLabel.text = updateData[@"bankNoMemo"];
    _dateLabel.text = updateData[@"gmtCreate"];
}

@end
