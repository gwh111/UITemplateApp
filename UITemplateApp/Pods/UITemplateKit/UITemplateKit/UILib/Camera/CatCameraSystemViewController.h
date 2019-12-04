//
//  CatCameraSystemViewController.h
//  UITemplateKit
//
//  Created by ml on 2019/11/1.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CatCameraSystemViewController : UIViewController {
@public
    void (^_completion)(id data);
    __weak UIViewController *_controller;
}

+ (instancetype)controllerWithCompletion:(void (^ __nullable)(UIImage *data))completion;

- (void)presentCameraPageFromRootViewController:(UIViewController *)rootViewController;

@end

NS_ASSUME_NONNULL_END
