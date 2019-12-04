//
//  CatBaseVC.m
//  UITemplateKit
//
//  Created by 路飞 on 2019/6/4.
//  Copyright © 2019 路飞. All rights reserved.
//

#import "CatBaseVC.h"
#import "UINavigationController+CatFDFullscreenPopGesture.h"

@interface CatBaseVC ()

@end

@implementation CatBaseVC

-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [[UIApplication sharedApplication] setStatusBarStyle:[self getStatusBarStyle]];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fd_interactivePopMaxAllowedInitialDistanceToLeftEdge = 50;
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = RGBA(244, 244, 244, 1);
    self.navigationController.navigationBar.hidden = YES;
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    if (self.cat_navigationBarView) {
        CatNavBarType barType = [self getCatNavBarType];
        switch (barType) {
            case CatNavBarTypeRed:
                return UIStatusBarStyleLightContent;
                break;
            case CatNavBarTypeWhite:
                if (@available(iOS 13.0, *)) {
                    return  UIStatusBarStyleDarkContent;
                } else {
                    return UIStatusBarStyleDefault;
                }
                break;
            case CatNavBarTypeGray:
                if (@available(iOS 13.0, *)) {
                    return  UIStatusBarStyleDarkContent;
                } else {
                    return UIStatusBarStyleDefault;
                }
                break;
            case CatNavBarTypeClear:
                return UIStatusBarStyleLightContent;
                break;
            default:
                return UIStatusBarStyleDefault;
                break;
        }
    }
    return UIStatusBarStyleDefault;
}
-(UIStatusBarStyle)getStatusBarStyle {
    if (self.cat_navigationBarView) {
        CatNavBarType barType = [self getCatNavBarType];
        switch (barType) {
            case CatNavBarTypeRed:
                return UIStatusBarStyleLightContent;
                break;
            case CatNavBarTypeWhite:
                return  UIStatusBarStyleDefault;
                break;
            case CatNavBarTypeGray:
                return  UIStatusBarStyleDefault;
                break;
            case CatNavBarTypeClear:
                return UIStatusBarStyleLightContent;
                //                return  UIStatusBarStyleDefault;
                break;
            default:
                return UIStatusBarStyleLightContent;
                break;
        }
        
    }
    return UIStatusBarStyleLightContent;
}

-(void)pressBackButton{
    if(self.navigationController.viewControllers.count>1){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
