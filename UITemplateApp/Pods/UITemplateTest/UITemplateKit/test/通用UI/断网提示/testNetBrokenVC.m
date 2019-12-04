//
//  testNetBrokenVC.m
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/10.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "testNetBrokenVC.h"
#import "CatNetBrokenView.h"
#import "ccs.h"

@interface testNetBrokenVC ()

@property (nonatomic, strong) CatNetBrokenView* nbView;

@end

@implementation testNetBrokenVC

#pragma mark - lifeCycle
- (void)cc_viewDidLoad {
    
    CatNetBrokenView *nbView = [[CatNetBrokenView alloc]initWithFrame:CGRectMake((WIDTH()-kCatNetBrokenViewWidth)/2.0, RH(120.0f), kCatNetBrokenViewWidth, kCatNetBrokenViewHeight) emptyImage:IMAGE(@"net_broken_placeholder") reloadBlock:^{
//        [strongSelf.nbView dismissCatBrokenView];
//        strongSelf.nbView = nil;
        
        [ccs showNotice:@"连接失败"];
    }];
    [self.view addSubview:nbView];
}

#pragma mark - public

#pragma mark - notification

#pragma mark - delegate

#pragma mark - property


@end
