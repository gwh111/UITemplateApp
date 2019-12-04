//
//  PTMultiLineLayout.m
//  Patient
//
//  Created by ml on 2019/7/15.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "PTMultiLineLayout.h"
#import "Masonry.h"
#import "CatSimpleView.h"
#import "ccs.h"
#import "CatMultiLineView.h"

@implementation PTMultiLineLayout

- (void)layoutSimpleView:(CatSimpleView *)simpleView {
    CatMultiLineView *sview = (CatMultiLineView *)simpleView;
    [simpleView.multiLineField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(RH(16));
        make.top.mas_equalTo(simpleView.titleLabel.mas_bottom).mas_offset(RH(4));
        make.right.mas_equalTo(RH(-16));
        make.bottom.mas_equalTo(simpleView).mas_offset(-2);
    }];
    
    [sview.inputPlaceholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(RH(16));
        make.top.mas_equalTo(simpleView.multiLineField).mas_offset(10);
        make.right.mas_equalTo(RH(-16));
    }];
    
    [sview.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(simpleView.titleLabel.mas_left).mas_offset(-2);
        make.top.mas_equalTo(simpleView.titleLabel).mas_offset(-2);
    }];
    
    [simpleView.separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(RH(16));
        make.right.mas_equalTo(RH(-16));
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(-1);
    }];
}

@end
