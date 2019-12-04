//
//  AccountDetailTableViewCell.m
//  CurrencyKit
//
//  Created by gwh on 2019/11/14.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "AccountDetailTableViewCell.h"

@interface AccountDetailTableViewCell ()

@property (nonatomic, retain) CC_Label *moneyLabel;
@property (nonatomic, retain) CC_Label *dateLabel;
@property (nonatomic, retain) CC_Label *leftMoneyLabel;
@property (nonatomic, retain) CC_Label *memoLabel;

@end

@implementation AccountDetailTableViewCell

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
    .cc_text(@"-1支出")
    .cc_addToView(self);
    
    _dateLabel = ccs.Label
    .cc_frame(RH(10), _moneyLabel.bottom, RH(200), RH(20))
    .cc_textColor(HEX(#999999))
    .cc_font(RF(11))
    .cc_text(@"2019/09/10 10:13:41")
    .cc_addToView(self);
    
    _leftMoneyLabel = ccs.Label
    .cc_frame(WIDTH() - RH(220), RH(15), RH(200), RH(20))
    .cc_textColor(HEX(#666666))
    .cc_font(BRF(12))
    .cc_textAlignment(NSTextAlignmentRight)
    .cc_text(@"余额1.06")
    .cc_addToView(self);
    
    _memoLabel = ccs.Label
    .cc_frame(WIDTH() - RH(220), _dateLabel.top, RH(200), RH(20))
    .cc_textColor(HEX(#999999))
    .cc_font(RF(11))
    .cc_textAlignment(NSTextAlignmentRight)
    .cc_text(@"陪玩打赏")
    .cc_addToView(self);
}

- (void)update:(NSDictionary *)updateData {
    
    NSString *transDirection = updateData[@"transDirection"][@"message"];
    if ([transDirection isEqualToString:@"收入"]) {

        _moneyLabel.text = [ccs string:@"+%@ 收入", updateData[@"transAmount"]];
    } else {

        _moneyLabel.text = [ccs string:@"-%@ 支出", updateData[@"transAmount"]];
    }
    
    _dateLabel.text = updateData[@"gmtCreate"];
    _leftMoneyLabel.text = [ccs string:@"%@", updateData[@"balanceAfter"]];
    _memoLabel.text = [ccs string:@"%@", updateData[@"memo"]];
}

@end
