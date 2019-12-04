//
//  PTSplitLayout.m
//  Patient
//
//  Created by ml on 2019/7/17.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "PTSplitLayout.h"
#import "CatSimpleView.h"
#import "ccs.h"
#import "Masonry.h"

@implementation PTSplitLayout

- (void)layoutSimpleView:(CatSimpleView *)simpleView {
    [simpleView.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(simpleView);
        if (simpleView.titleLabel.width > 60) {
            make.width.mas_equalTo(RH(60));
        }
        make.height.mas_equalTo(RH(40));
    }];
    
    [simpleView.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(simpleView.titleLabel.mas_right).mas_offset(6);
        make.centerY.mas_equalTo(simpleView);
    }];
    
    [simpleView.oneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(-1);
        make.top.mas_equalTo(RH(6));
        make.bottom.mas_equalTo(RH(-6));
        make.width.mas_equalTo(1);
    }];
}

@end
