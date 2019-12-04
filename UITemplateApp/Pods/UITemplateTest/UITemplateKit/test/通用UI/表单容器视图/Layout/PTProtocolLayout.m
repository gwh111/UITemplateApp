//
//  PTProtocolLayout.m
//  UITemplateKit
//
//  Created by Shepherd on 2019/7/18.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "PTProtocolLayout.h"
#import "CatSimpleView.h"
#import "Masonry.h"
#import "ccs.h"

@implementation PTProtocolLayout

- (void)layoutSimpleView:(CatSimpleView *)simpleView {
    [[simpleView viewWithTag:99] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(RH(9));
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(RH(6));
        make.width.mas_equalTo(RH(116));
    }];
    
    [simpleView.oneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo([simpleView viewWithTag:99].mas_right);
        make.centerY.mas_equalTo([simpleView viewWithTag:99]);
    }];
    
    [simpleView.separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.left.right.mas_equalTo(0);
    }];
}

@end
