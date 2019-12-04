//
//  PTSingleLineLayout.m
//  Patient
//
//  Created by ml on 2019/7/15.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "PTSingleLineLayout.h"
#import "CatSingleLineView.h"
#import "CatMultiLineView.h"
#import "Masonry.h"
#import "CatSimpleView.h"
#import "ccs.h"

@implementation PTSingleLineLayout

- (void)layoutSimpleView:(CatSimpleView *)simpleView {
    CatSingleLineView *sview = (CatSingleLineView *)simpleView;
    
    if ([sview.identifier isEqualToString:@"canChange"]) {
        [sview.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(RH(23));
            make.top.mas_equalTo(RH(10));
        }];
    }else {
        [sview.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(RH(23));
            make.centerY.mas_equalTo(sview);
        }];
    }
    
    [sview.singleLineField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(RH(-32));
        make.centerY.mas_equalTo(sview);
        make.width.mas_equalTo(RH(220));
        make.height.mas_equalTo(RH(36));
    }];
    
    [sview.accessoryIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(RH(-16));
        make.centerY.mas_equalTo(sview);
        make.width.mas_equalTo(RH(6));
        make.height.mas_equalTo(RH(11));
    }];
    
    [sview.separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(RH(16));
        make.right.mas_equalTo(RH(-16));
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(-1);
    }];
    
    [sview.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(sview.titleLabel.mas_left).mas_offset(-2);
        make.top.mas_equalTo(sview.titleLabel).mas_offset(-2);
    }];
}

@end
