//
//  BusinessVC.m
//  UITemplateKit
//
//  Created by gwh on 2019/11/26.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "BusinessVC.h"

#import "testLoginVC.h"
#import "ccs+CurrencyKit.h"
#import "BusinessRequestOverloadC.h"

@interface BusinessVC ()

@property (nonatomic, retain) NSArray *testNameList;

@end

@implementation BusinessVC

- (void)cc_viewWillLoad {
   
    self.cc_title = @"业务UI";
    
    [ccs configureEnvironment:CCBUILDTAG];
    
    NSArray *account = @[@"http://xxx", @"http://xxx"];
    [ccs accountLib_configureMainURLs:account];
    NSArray *finance = @[@"http://xxx", @"http://xxx"];
    [ccs financeLib_configureMainURLs:finance];
    NSArray *area = @[@"http://xxx", @"http://xxx"];
    [ccs areaLib_configureMainURLs:area];
    
    CC_HttpConfig *httpConf = ccs.httpTask.configure;
    httpConf.httpRequestType = CCHttpRequestTypeMock;
    httpConf.ignoreMockError = YES;
    [httpConf.httpHeaderFields cc_setKey:@"Web-Exterface-ClientName" value:@"eh-user-android"];
    [httpConf.httpHeaderFields cc_setKey:@"Web-Exterface-ClientVersion" value:@"1.0"];
    [httpConf.httpHeaderFields cc_setKey:@"Web-Exterface-ClientUserAgent" value:@"android"];
    
    CurrencyConfig *currencyConf = ccs.currencyKit_config;
    currencyConf.doneButtonRadius = 4;
    
    [self cc_registerController:[ccs init:BusinessRequestOverloadC.class]];
}

- (void)cc_viewDidLoad {
    _testNameList = @[@"登录", @"充值", @"提现", @"收支明细", @"银行卡管理", @"冻结明细"];
    CC_TableView *tabbleView = ccs.TableView
    .cc_frame(0, 0, WIDTH(), self.cc_displayView.height)
    .cc_addToView(self.cc_displayView);
    [tabbleView cc_addTextList:_testNameList withTappedBlock:^(NSUInteger index) {
        
        [self actionWithIndex:index name:self.testNameList[index]];
    }];
}

- (void)actionWithIndex:(NSUInteger)index name:(NSString *)name{
    if ([name isEqualToString:@"登录"]) {
        testLoginVC *vc = [ccs init:testLoginVC.class];
        vc.cc_title = _testNameList[index];
        [ccs pushViewController:vc];
    }
    if ([name isEqualToString:@"充值"]) {
        [ccs currencyKit_pushChargeViewController];
    }
    if ([name isEqualToString:@"提现"]) {
        [ccs currencyKit_pushWithdrawViewController];
    }
    if ([name isEqualToString:@"收支明细"]) {
        [ccs currencyKit_pushAccountDetailViewController];
    }
    if ([name isEqualToString:@"银行卡管理"]) {
        [ccs currencyKit_pushBankCardManageViewController];
    }
    if ([name isEqualToString:@"冻结明细"]) {
        [ccs currencyKit_pushFreezeDetailViewController];
    }
}

@end
