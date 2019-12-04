//
//  testTabbarController.m
//  UITemplateKit
//
//  Created by 路飞 on 2019/6/3.
//  Copyright © 2019 路飞. All rights reserved.
//

#import "testTabbarController.h"
#import "CommonUIVC.h"
#import "BusinessVC.h"
#import "testNetBrokenVC.h"
#import "OtherVC.h"

@interface testTabbarController ()

@end

@implementation testTabbarController

- (void)cc_viewWillLoad {
    
    [self cc_initWithClasses:@[CommonUIVC.class, BusinessVC.class, testNetBrokenVC.class, OtherVC.class]
                titles:@[@"通用", @"业务", @"断网", @"bench_ios"]
                images:@[@"tabbar_home",@"tabbar_play", @"tabbar_message",@"tabbar_data"]
        selectedImages:@[@"tabbar_home",@"tabbar_play", @"tabbar_message",@"tabbar_data"]
            titleColor:UIColor.blackColor
    selectedTitleColor:UIColor.blueColor];
    
    [self cc_updateBadgeNumber:200 atIndex:2];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
}

@end
