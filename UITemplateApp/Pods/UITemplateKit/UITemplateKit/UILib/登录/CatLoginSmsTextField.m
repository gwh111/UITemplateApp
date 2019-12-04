//
//  CatLoginSmsTextField.m
//  UITemplateKit
//
//  Created by ml on 2019/6/12.
//  Copyright © 2019 路飞. All rights reserved.
//

#import "CatLoginSmsTextField.h"
#import "ccs.h"

@implementation CatLoginSmsTextField

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    WS(weakSelf)
    CatLoginCountButton *b = [CatLoginCountButton buttonWithSeconds:60 handler:^(CatLoginCountButton *btn) {
        SS(strongSelf)
        if([strongSelf.smsDelegate respondsToSelector:@selector(smsTextField:withSender:)]) {
            [strongSelf.smsDelegate smsTextField:strongSelf withSender:btn];
        }
    }];
    UIView *contentView = [[UIView alloc] initWithFrame:b.bounds];
    [contentView addSubview:b];
    self.rightView = contentView;
    self.rightViewMode = UITextFieldViewModeAlways;
    self.countButton = b;
}

@end
