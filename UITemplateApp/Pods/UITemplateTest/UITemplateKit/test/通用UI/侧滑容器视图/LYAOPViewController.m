//
//  LYAOPViewController.m
//  UITemplateKit
//
//  Created by ml on 2019/7/4.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "LYAOPViewController.h"
#import "ccs.h"

@interface LYAOPViewController ()

@end

@implementation LYAOPViewController

- (void)cc_viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat width = 200;
    for (int i = 0; i < self.itemTitles.count; ++i) {
        UIButton *b = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH() - width) * 0.5, 100 + i * 66, width, 40)];
        [b setTitle:self.itemTitles[i] forState:UIControlStateNormal];
        [b setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        b.backgroundColor = [ccs appStandard:MASTER_COLOR];
        b.tag = i;
        [b addTarget:self action:@selector(targetAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:b];
    }
}

- (void)targetAction:(UIButton *)sender {
    
}

@end
