//
//  CustomPersonSelectCell.m
//  UITemplateLib
//
//  Created by ml on 2019/5/30.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CustomPersonSelectCell.h"
#import "ccs.h"
//#import "CC_UIViewExt.h"
#import <Masonry/Masonry.h>

@implementation CustomPersonSelectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        /// 复用问题 pass
        if (arc4random() % 10 > 4) {
            _tagLabel = ({
                UILabel *l = [UILabel new];
                l.text = @"紧急";
                l.translatesAutoresizingMaskIntoConstraints = NO;
                l.textColor = [UIColor orangeColor];
                l.font = RF(12);
                [l sizeToFit];
                l;
            });
            [self.contentView addSubview:_tagLabel];
        }
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
//    self.nameLabel.left = 200;
//    self.iconView.right = 10;    
    self.nameLabel.left = 180;
    self.tagLabel.left = self.nameLabel.right + RH(10);
    self.tagLabel.centerY = self.nameLabel.centerY;
    self.iconView.height = 60;
    self.iconView.width = 60;
    self.iconView.layer.masksToBounds = YES;
    self.iconView.layer.cornerRadius = 30;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
