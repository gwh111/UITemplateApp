//
//  CatSingleLineView.m
//  UITemplateKit
//
//  Created by Shepherd on 2019/7/7.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatSingleLineView.h"
#import "ccs.h"

@implementation CatSingleLineView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _commonInit];
    }
    return self;
}

- (void)_commonInit {
    self
        .LYTitleLabel
        .LYIcon
        .LYSepartor
        .LYSingleLineField
        .LYAccessoryIcon
        .LYSelf.n2BackgroundColor(UIColor.whiteColor)
    ;
    
    self.editable = YES;
    self.maxCount = 100;
}

- (void)setOptional:(BOOL)optional {
    _optional = optional;
    self.descLabel.hidden = optional;
}

- (void)setEditable:(BOOL)editable {
    _editable = editable;
    if (_editable == NO) {
        self.singleLineField.userInteractionEnabled = NO;
    }else {
        self.singleLineField.userInteractionEnabled = YES;
    }
}

- (instancetype)createWithTitle:(NSString *)title
                    placeholder:(NSString *)placeholder {
    self        
        .LYDescLabel
            .n2Text(@"*")
            .n2Font(RF(15))
            .n2TextColor(HEX(0x39A1FD))
            .n2SizeToFit()
            .n2Left(RH(16))
            .n2CenterY(self.centerY)
        .LYTitleLabel
            .n2Text(title)
            .n2TextColor(HEX(0x333333))
            .n2Font(RF(15))
            .n2SizeToFit()
            .n2Left(self.descLabel.right + RH(4))
            .n2CenterY(self.centerY)
        .LYSingleLineField
            .n2Placeholder(placeholder)
            .n2TextAlignment(NSTextAlignmentRight)
            .n2Font(RF(15))
            .n2Left(self.titleLabel.right + RH(4))
            .n2W(self.width - self.singleLineField.left - RH(16))
            .n2H(36)
            .n2CenterY(self.centerY)
        .LYSepartor
            .n2Left(RH(16))
            .n2W(self.width - 2 * RH(16))
            .n2Top(self.bottom - 0.5)
            .n2H(0.5)
            .n2BackgroundColor(HEX(0xededed));
    
    return self;
}

- (UILabel *)requireLabel {
    return self.LYDescLabel.descLabel;
}

- (UILabel *)itemLabel {
    return self.LYTitleLabel.titleLabel;
}

- (UITextField *)inputTextField {
    return self.LYSingleLineField.singleLineField;
}

@end
