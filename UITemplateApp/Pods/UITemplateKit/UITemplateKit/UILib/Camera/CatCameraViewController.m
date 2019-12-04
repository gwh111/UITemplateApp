//
//  CatCameraViewController.m
//  UITemplateKit
//
//  Created by Shepherd on 2019/10/29.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatCameraViewController.h"
#import "ccs.h"

@interface CatCameraViewController ()

@property (nonatomic,strong) UIButton *testBtn;

@end

@implementation CatCameraViewController

+ (instancetype)controllerWithCompletion:(void (^)(UIImage *data))completion {
    CatCameraViewController *vc = [CatCameraViewController new];
    vc->_completion = completion;
    return vc;
}

- (void)presentCameraPageFromRootViewController:(UIViewController *)rootViewController {
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:self];
    navC.modalPresentationStyle = UIModalPresentationFullScreen;
    [rootViewController presentViewController:navC animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self->_imp = [CatCameraImp cameraWithContentView:self.view option:CatCameraOptionMoment];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self->_imp startRunning];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 300, 30)];
    btn.backgroundColor = UIColor.blackColor;
    [btn setTitle:@"拍照" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(takePhotoAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self->_imp stopRunning];
}

- (void)takePhotoAction:(UIButton *)sender {
    WS(weakSelf)
    [self->_imp takeAPhotoWithCompletion:^(UIImage * _Nonnull image) {
        SS(strongSelf)
        !strongSelf->_completion ? : strongSelf->_completion(image);
    }];
}

@end
