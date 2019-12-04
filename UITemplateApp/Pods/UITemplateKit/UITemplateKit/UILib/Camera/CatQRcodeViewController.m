//
//  CatQRcodeViewController.m
//  UITemplateKit
//
//  Created by ml on 2019/10/30.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatQRcodeViewController.h"
#import "CatQRcodeView.h"
#import "ccs.h"

@interface CatQRcodeViewController () {
@private
    void (^_completion)(id data);
    CatQRcodeView *_qrcodeView;
}

@end

@implementation CatQRcodeViewController

+ (instancetype)controllerWithCompletion:(void (^)(id data))completion {
    CatQRcodeViewController *vc = [CatQRcodeViewController new];
    vc->_completion = completion;
    return vc;
}

- (void)presentCameraPageFromRootViewController:(UIViewController *)rootViewController {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    CGRect effectiveArea = CGRectMake(RH(89), 204, WIDTH() - RH(89) * 2, RH(198));
    
    self->_imp = [CatCameraImp cameraWithContentView:self.view option:CatCameraOptionScanner];
    self->_imp.effectiveArea = effectiveArea;
    
    /// 扫码回调
    [self->_imp scanWithCompletion:^(NSString * _Nonnull result) {
        NSLog(@"%@",result);
    }];
    
    _qrcodeView = [[CatQRcodeView alloc] initWithFrame:self.view.bounds
                                         effectiveArea:effectiveArea];
    
    [self.view addSubview:self.qrcodeView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self->_imp startRunning];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self->_imp stopRunning];
}

@end
