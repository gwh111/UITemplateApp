//
//  FreezeDetailTableViewCell.m
//  CurrencyKit
//
//  Created by gwh on 2019/11/15.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "FreezeDetailTableViewCell.h"

@interface FreezeDetailTableViewCell ()

@property (nonatomic, retain) CC_Label *moneyLabel;
@property (nonatomic, retain) CC_Label *dateLabel;
@property (nonatomic, retain) CC_Label *currentFreezeLabel;
@property (nonatomic, retain) CC_Label *alreadyFreezeLabel;

@end

@implementation FreezeDetailTableViewCell

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
    .cc_text(@"231kb")
    .cc_addToView(self);
    
    _dateLabel = ccs.Label
    .cc_frame(RH(10), _moneyLabel.bottom, RH(200), RH(20))
    .cc_textColor(HEX(#999999))
    .cc_font(RF(11))
    .cc_text(@"2019/09/10 10:13:41")
    .cc_addToView(self);
    
    _currentFreezeLabel = ccs.Label
    .cc_frame(WIDTH() - RH(220), RH(15), RH(200), RH(20))
    .cc_textColor(HEX(#666666))
    .cc_font(RF(11))
    .cc_textAlignment(NSTextAlignmentRight)
    .cc_text(@"本次冻结 2 KB")
    .cc_addToView(self);
    
    _alreadyFreezeLabel = ccs.Label
    .cc_frame(WIDTH() - RH(220), _dateLabel.top, RH(200), RH(20))
    .cc_textColor(HEX(#999999))
    .cc_font(RF(11))
    .cc_textAlignment(NSTextAlignmentRight)
    .cc_text(@"已解冻 0 KB")
    .cc_addToView(self);
}

- (void)update:(NSDictionary *)updateData {
    
    _moneyLabel.text = [ccs string:@"%@", updateData[@"initFreezeAmount"]];
    _dateLabel.text = updateData[@"gmtCreate"];
    _currentFreezeLabel.text = [ccs string:@"本次冻结 %@", updateData[@"freezeAmount"]];
    _alreadyFreezeLabel.text = [ccs string:@"已解冻 %@", updateData[@"unfreezeAmount"]];
}

@end
