//
//  FreezeLogTableViewCell.m
//  CurrencyKit
//
//  Created by gwh on 2019/11/15.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "FreezeLogTableViewCell.h"

@implementation FreezeLogTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        
        self.backgroundColor = UIColor.clearColor;
        
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    float height = RH(50);
    
    _timeLabel = ccs.Label
    .cc_frame(0, 0, RH(80), RH(50))
    .cc_textAlignment(NSTextAlignmentCenter)
    .cc_textColor(HEX(#666666))
    .cc_font(RF(11))
    .cc_text(@"时间")
    .cc_addToView(self)
    .cc_numberOfLines(0);
    
    ccs.View
    .cc_frame(_timeLabel.right, 0, 1, RH(50))
    .cc_backgroundColor(HEX(#E6E6E6))
    .cc_addToView(self);
    
    ccs.View
    .cc_frame(_timeLabel.left, height, _timeLabel.width, 1)
    .cc_backgroundColor(HEX(#E6E6E6))
    .cc_addToView(self);
    
    _freezeLabel = ccs.Label
    .cc_frame(_timeLabel.right, 0, RH(60), RH(50))
    .cc_textAlignment(NSTextAlignmentCenter)
    .cc_textColor(HEX(#666666))
    .cc_font(RF(11))
    .cc_text(@"冻结/KB")
    .cc_addToView(self);
    
    ccs.View
    .cc_frame(_freezeLabel.right, 0, 1, RH(50))
    .cc_backgroundColor(HEX(#E6E6E6))
    .cc_addToView(self);
    
    ccs.View
    .cc_frame(_freezeLabel.left, height, _freezeLabel.width, 1)
    .cc_backgroundColor(HEX(#E6E6E6))
    .cc_addToView(self);
    
    _unFreezeLabel = ccs.Label
    .cc_frame(_freezeLabel.right, 0, RH(60), RH(50))
    .cc_textAlignment(NSTextAlignmentCenter)
    .cc_textColor(HEX(#666666))
    .cc_font(RF(11))
    .cc_text(@"已解冻/KB")
    .cc_addToView(self);
    
    ccs.View
    .cc_frame(_unFreezeLabel.right, 0, 1, RH(50))
    .cc_backgroundColor(HEX(#E6E6E6))
    .cc_addToView(self);
    
    ccs.View
    .cc_frame(_unFreezeLabel.left, height, _unFreezeLabel.width, 1)
    .cc_backgroundColor(HEX(#E6E6E6))
    .cc_addToView(self);
    
    _leftFreezeLabel = ccs.Label
    .cc_frame(_unFreezeLabel.right, 0, RH(100), RH(50))
    .cc_textAlignment(NSTextAlignmentCenter)
    .cc_textColor(HEX(#666666))
    .cc_font(RF(11))
    .cc_text(@"剩余冻结金额/KB")
    .cc_addToView(self);
    
    ccs.View
    .cc_frame(_leftFreezeLabel.right, 0, 1, RH(50))
    .cc_backgroundColor(HEX(#E6E6E6))
    .cc_addToView(self);
    
    ccs.View
    .cc_frame(_leftFreezeLabel.left, height, _leftFreezeLabel.width, 1)
    .cc_backgroundColor(HEX(#E6E6E6))
    .cc_addToView(self);
    
    _memoLabel = ccs.Label
    .cc_frame(_leftFreezeLabel.right, 0, RH(80), RH(50))
    .cc_textAlignment(NSTextAlignmentCenter)
    .cc_textColor(HEX(#666666))
    .cc_font(RF(11))
    .cc_text(@"备注")
    .cc_addToView(self)
    .cc_numberOfLines(0);
    
    ccs.View
    .cc_frame(_memoLabel.left, height, _memoLabel.width, 1)
    .cc_backgroundColor(HEX(#E6E6E6))
    .cc_addToView(self);
    
}

- (void)update {
    
    _timeLabel
    .cc_text(@"时间");
    _freezeLabel
    .cc_text(@"冻结/KB");
    _unFreezeLabel
    .cc_text(@"已解冻/KB");
    _leftFreezeLabel
    .cc_text(@"剩余冻结金额/KB");
    _memoLabel
    .cc_text(@"备注");
}

@end
