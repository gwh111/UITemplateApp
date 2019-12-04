//
//  AppDelegate.m
//  UITemplateApp
//
//  Created by gwh on 2019/11/26.
//  Copyright 2019 gwh. All rights reserved.
//

#import "AppDelegate.h"
#import "testTabbarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (void)load {
    [ccs registerAppDelegate:self];
}

- (void)cc_willInit {
    
    [self cc_initTabbarViewController:testTabbarController.class block:^{
        
        
    }];
}

- (BOOL)cc_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    return YES;
}

- (void)cc_applicationWillResignActive:(UIApplication *)application {

}

- (void)cc_applicationDidEnterBackground:(UIApplication *)application {

}

- (void)cc_applicationWillEnterForeground:(UIApplication *)application {

}

- (void)cc_applicationDidBecomeActive:(UIApplication *)application {

}

- (void)cc_applicationWillTerminate:(UIApplication *)application {

}

@end
