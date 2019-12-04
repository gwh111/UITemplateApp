//
//  BankCardManageTableViewCell.m
//  CurrencyKit
//
//  Created by gwh on 2019/11/14.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "BankCardManageTableViewCell.h"

@interface BankCardManageTableViewCell ()

@property (nonatomic, retain) CC_View *cardView;
@property (nonatomic, retain) CC_ImageView *iconImageView;
@property (nonatomic, retain) CC_Label *bankNameLabel;
@property (nonatomic, retain) CC_Label *cardTypeLabel;
@property (nonatomic, retain) CC_Label *bankSubNameLabel;
@property (nonatomic, retain) CC_Label *bankCardNumberLabel;

@end

@implementation BankCardManageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        
        self.backgroundColor = UIColor.clearColor;
        
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    _cardView = ccs.View
    .cc_frame(RH(20), 0, WIDTH() - RH(40), RH(130))
    .cc_cornerRadius(10)
    .cc_backgroundColor(COLOR_LIGHT_RED)
    .cc_addToView(self);
    [_cardView cc_setShadow:UIColor.grayColor];
    
    _iconImageView = ccs.ImageView
    .cc_frame(RH(20), RH(30), RH(30), RH(30))
    .cc_backgroundColor(UIColor.whiteColor)
    .cc_addToView(_cardView);
    
    _bankNameLabel = ccs.Label
    .cc_frame(_iconImageView.right + RH(10), RH(25), RH(200), RH(20))
    .cc_textColor(HEX(#ffffff))
    .cc_font(RF(17))
    .cc_text(@"中国工商银行")
    .cc_addToView(_cardView);
    
    _setDefaultButton = ccs.Button
    .cc_frame(_cardView.width - RH(60), _bankNameLabel.top, RH(50), RH(20))
    .cc_setTitleColorForState(HEX(#ffffff), UIControlStateNormal)
    .cc_font(RF(12))
    .cc_setTitleForState(@"默认账户", UIControlStateNormal)
    .cc_addToView(_cardView);
    
    _cardTypeLabel = ccs.Label
    .cc_frame(_iconImageView.right + RH(10), _bankNameLabel.bottom + RH(5), RH(200), RH(15))
    .cc_textColor(HEX(#ffffff))
    .cc_font(RF(12))
    .cc_text(@"储蓄卡")
    .cc_addToView(_cardView);
    
    _bankSubNameLabel = ccs.Label
    .cc_frame(_iconImageView.right + RH(10), _cardTypeLabel.bottom, RH(200), RH(20))
    .cc_textColor(HEX(#ffffff))
    .cc_font(RF(11))
    .cc_text(@"杭州文三路支行")
    .cc_addToView(_cardView);
    
    _bankCardNumberLabel = ccs.Label
    .cc_frame(_iconImageView.right + RH(10), _bankSubNameLabel.bottom, _cardView.width, RH(30))
    .cc_textColor(HEX(#ffffff))
    .cc_font(RF(20))
    .cc_text(@"****     ****     ****     6878")
    .cc_addToView(_cardView);
    
}

- (void)update:(NSDictionary *)bankDic {
    
    _bankNameLabel.text = bankDic[@"bankName"];
    _bankCardNumberLabel.text = bankDic[@"cardNo"];
    _bankSubNameLabel.text = bankDic[@"bankSubBranchName"];
    _cardTypeLabel.text = bankDic[@"cardType"][@"message"];
    
    WS(weakSelf)
    [_iconImageView cc_setImageWithURL:[NSURL URLWithString:bankDic[@"logoUrl"]] placeholderImage:nil processBlock:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, BOOL finished) {

        NSData *data = UIImageJPEGRepresentation(image, 1);
        UIImage *jpg = [UIImage imageWithData:data];
        UIColor *color = [CC_Color cc_colorOfImage:jpg];
        weakSelf.cardView.backgroundColor = color;
    }];
    
    
    if ([bankDic[@"defaultSelect"]intValue] == 1) {
        _setDefaultButton.cc_setTitleForState(@"默认账户", UIControlStateNormal);
    } else {
        _setDefaultButton.cc_setTitleForState(@"设为默认", UIControlStateNormal);
    }
    
}

@end
