//
//  CatSimpleCollectionCell.m
//  UITemplateKit
//
//  Created by ml on 2019/7/3.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatSimpleCollectionCell.h"
#import "CatSimpleView.h"

@implementation CatSimpleCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    [self.contentView addSubview:({
        _sview = [[CatSimpleView alloc] initWithFrame:self.contentView.bounds];
    })];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!CGRectEqualToRect(self.contentView.bounds, self.sview.bounds)) {
        _sview.bounds = self.contentView.bounds;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self commonInit];
}

@end

NSString *const CatSimpleCollectionCellString = @"CatSimpleCollectionCellString";
