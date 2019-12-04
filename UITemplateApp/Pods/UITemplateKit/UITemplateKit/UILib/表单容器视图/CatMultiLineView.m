//
//  CatMultiLineView.m
//  UITemplateKit
//
//  Created by Shepherd on 2019/7/7.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatMultiLineView.h"
#import "ccs.h"

@interface CatMultiLineView ()

@property (nonatomic,strong,readonly) UILabel *placeholderLabel;

@end

@implementation CatMultiLineView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _commonInit];
    }
    return self;
}

- (void)setOptional:(BOOL)optional {
    _optional = optional;
    self.descLabel.hidden = optional;
}

- (void)_commonInit {
    self
        .LYTitleLabel.n2Left(RH(16)).n2Top(RH(10))
        .LYIcon
        .LYSepartor
        .LYMultiLineField
        .LYDescLabel
        .LYSelf.n2BackgroundColor([UIColor whiteColor]);
    
    self.maxCount = 100;
}

- (void)setEditable:(BOOL)editable {
    _editable = editable;
    if (_editable == NO) {
        self.multiLineField.userInteractionEnabled = NO;
    }else {
        self.multiLineField.userInteractionEnabled = YES;
    }
}

- (instancetype)createWithTitle:(NSString *)title
                    placeholder:(NSString *)placeholder {
    self
        .LYSelf
        .LYPlaceholderLabel
            .n2Text(placeholder)
            .n2TextColor(HEX(0xdddddd))
            .n2Font(RF(15))
            .n2W(WIDTH() - RH(16) * 2)
        .LYTitleLabel
            .n2Text(title).n2Left(RH(23)).n2TextColor(HEX(0x333333)).n2Font(RF(15)).n2SizeToFit()
        .LYMultiLineField
            .n2Font(RF(15))
        .LYDescLabel
            .n2Text(@"*")
            .n2Font(RF(15))
            .n2TextColor(HEX(0x39A1FD)).n2SizeToFit()
        .LYSepartor
            .n2BackgroundColor(HEX(0xededed))
    ;    
    return self;
}

- (UILabel *)requireLabel {
    return self.LYDescLabel.descLabel;
}

- (UILabel *)itemLabel {
    return self.LYTitleLabel.titleLabel;
}

- (UITextView *)inputTextField {
    return self.LYMultiLineField.multiLineField;
}

- (UILabel *)inputPlaceholderLabel {
    return self.LYPlaceholderLabel.placeholderLabel;
}

@end

@implementation CatMultiLineView (CatForm)

- (instancetype)LYPlaceholderLabel {
    if (!_placeholderLabel) {
        [self addSubview:_placeholderLabel = [UILabel new]];
    }
    self->_ = _placeholderLabel;
    return self;
}

@end
