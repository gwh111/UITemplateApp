//
//  testLoginVC.m
//  UITemplateLib
//
//  Created by ml on 2019/5/16.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "testLoginVC.h"
#import "CatLoginController.h"
//#import "UIScrollView+CCCat.h"

@interface testLoginVC () <CatLoginControllerDelegate,CatLoginGuideDelegate>

@end

@implementation testLoginVC

- (void)cc_viewDidLoad {
    
    NSArray *nameList = @[@"默认",@"自如",@"KK",@"医疗",@"自定义"];
    CC_TableView *tabbleView = ccs.TableView
    .cc_frame(0, 0, WIDTH(), self.cc_displayView.height)
    .cc_addToView(self.cc_displayView);
    [tabbleView cc_addTextList:nameList withTappedBlock:^(NSUInteger index) {
        
        [self actionWithIndex:index];
    }];
}

- (void)actionWithIndex:(NSUInteger)index {
    if (index == 0) {
        [self showDefaultLogin];
    }
    if (index == 1) {
        [self showFreelyLogin];
    }
    if (index == 2) {
        [self showKKLogin];
    }
    if (index == 3) {
        [self showDoctor];
    }
    if (index == 4) {
        [self showDoctor];
    }
}

- (void)showDefaultLogin {
    CatLoginController *controller = [CatLoginController controllerWithType:CatLoginTypeDefault];
    controller.delegate = self;
    /// 可选
    controller.guideDelegate = self;
    // controller.thirdPartyImages = @[[UIImage imageNamed:@"qq"],[UIImage imageNamed:@"wechat"]];
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:navC animated:YES completion:nil];
}

- (void)showKKLogin {
    CatLoginController *controller = [CatLoginController controllerWithType:CatLoginTypeKK];
    controller.delegate = self;
    /// 可选
    controller.guideDelegate = self;
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:navC animated:YES completion:nil];
}

- (void)showFreelyLogin {
    CatLoginController *controller = [CatLoginController controllerWithType:CatLoginTypeLikefreely];
    controller.delegate = self;
    controller.guideDelegate = self;
    controller.thirdPartyImages = @[[UIImage imageNamed:@"login_qq"],[UIImage imageNamed:@"login_wechat"],[UIImage imageNamed:@"login_weibo"],[UIImage imageNamed:@"login_session_line"]];
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:navC animated:YES completion:nil];
}

- (void)showDoctor {
    CatLoginController *controller = [CatLoginController controllerWithType:CatLoginTypeDoctor];
    controller.scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    controller.delegate = self;
    controller.guideDelegate = self;
#if DEBUG
    controller.accountField.text = @"17742003209";
    controller.smsField.text = @"224541";
    controller.submitButton.enabled = YES;
    controller.submitButton.backgroundColor = [UIColor blueColor];
#endif
    controller.accountField.placeholder = @"请输入手机号";
    controller.smsField.placeholder = @"请输入验证码";    
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:navC animated:YES completion:nil];
}

#pragma mark - CatLoginControllerDelegate

- (void)catLoginController:(CatLoginController *)controller
                   content:(NSDictionary<CatLoginContentStringKey,NSString *> *)content
          commitWithSender:(UIButton *)sender {
#if DEBUG
    NSLog(@"用户名:%@",[content objectForKey:CatLoginContentAccountString]);
    NSLog(@"密码:%@",[content objectForKey:CatLoginContentPwdString]);
    NSLog(@"验证码:%@",[content objectForKey:CatLoginContentSmsString]);
    
     [[NSNotificationCenter defaultCenter] postNotificationName:CatLoginSuccessNotification object:nil];
#endif
}

- (void)catLoginController:(CatLoginController *)controller didSelectIndex:(NSInteger)index {
    /// 点击第三方平台按钮
    NSLog(@"%s-index=%ld",__func__,index);
}

/// 自定义返回操作
- (void)catLoginControllerDismiss:(CatLoginController *)controller {
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)catLoginController:(CatLoginController *)controller content:(NSDictionary<CatLoginContentStringKey,NSString *> *)content smsWithSender:(CatLoginCountButton *)sender {
    
    if (sender.tag == 0) {
        sender.seconds = 60;
    }else {
        sender.seconds = 10;
    }
    sender.tag += 1;
    
    return NO;
}

#pragma mark - CatLoginGuideDelegate
- (void)catLoginContorllerJump2Register:(CatLoginController *)controller {
    /// 到注册页
    NSLog(@"%s",__func__);
    [self pushViewController:controller WithTitle:@"注册"];
}

- (void)catLoginControllerJump2ForgetPwd:(CatLoginController *)controller {
    /// 到忘记密码页
    NSLog(@"%s",__func__);
    [self pushViewController:controller WithTitle:@"忘记密码"];
}

- (void)catLoginControllerJump2LoginTrouble:(CatLoginController *)controller {
    /// 到登录出现问题页
    NSLog(@"%s",__func__);
    [self pushViewController:controller WithTitle:@"问题反馈"];
}

- (void)pushViewController:(CatLoginController *)controller WithTitle:(NSString *)title {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.title = title;
    [controller.navigationController pushViewController:vc animated:YES];
}

@end
