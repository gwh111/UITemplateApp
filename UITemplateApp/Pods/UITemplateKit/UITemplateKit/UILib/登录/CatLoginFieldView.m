//
//  CatLoginFieldView.m
//  UITemplateKit
//
//  Created by ml on 2019/6/12.
//  Copyright © 2019 路飞. All rights reserved.
//

#import "CatLoginFieldView.h"
#import "ccs.h"

@implementation CatLoginFieldView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    [self addSubview:_floatLabel = UILabel.new];
    _lineView = UIView.new;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (_floatLabel.text.length > 0) {
        _floatLabel.font = RF(17);
        _floatLabel.left = RH(25);
        [_floatLabel sizeToFit];
    }
    
    if (_textField.placeholder.length > 0) {
        _textField.top = CGRectGetMaxY(_floatLabel.frame);
        _textField.left = RH(25);
        _textField.width = WIDTH() - RH(25) * 2;
        _textField.height = self.height - 1 - _floatLabel.height;
    }
    
    if (_lineView) {
        _lineView.left = RH(25);
        _lineView.top = self.height - 1;
        _lineView.width = WIDTH() - RH(25) * 2;
        _lineView.height = 1;
        _lineView.backgroundColor = UIColor.groupTableViewBackgroundColor;
        [self addSubview:_lineView];
    }
}


@end
