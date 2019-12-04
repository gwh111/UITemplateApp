//
//  CatSimpleTableCell.m
//  LYCommonUI
//
//  Created by Shepherd on 2019/6/29.
//  Copyright © 2019 Shepherd. All rights reserved.
//

#import "CatSimpleTableCell.h"

@implementation CatSimpleTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:({
        _sview = [[CatSimpleView alloc] initWithFrame:self.contentView.bounds];
    })];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!CGRectEqualToRect(self.contentView.bounds, self.sview.bounds)) {
        _sview.frame = self.contentView.bounds;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

NSString *const CatSimpleTableCellString = @"CatSimpleTableCellString";
