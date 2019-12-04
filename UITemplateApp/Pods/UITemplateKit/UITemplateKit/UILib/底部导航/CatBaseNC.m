//
//  CatBaseNC.m
//  UITemplateKit
//
//  Created by 路飞 on 2019/6/4.
//  Copyright © 2019 路飞. All rights reserved.
//

#import "CatBaseNC.h"
#import "ccs.h"

@interface CatBaseNC ()

@end

@implementation CatBaseNC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBarHidden=YES;
}

-(BOOL)shouldAutorotate{
    return self.topViewController.shouldAutorotate;
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return self.topViewController.supportedInterfaceOrientations;
}
-(UIViewController *)childViewControllerForStatusBarStyle{
    return self.visibleViewController;
}
-(UIViewController *)childViewControllerForStatusBarHidden{
    return self.visibleViewController;
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    CCLOG(@"%ld",self.viewControllers.count);
    if (self.viewControllers.count != 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}
@end
