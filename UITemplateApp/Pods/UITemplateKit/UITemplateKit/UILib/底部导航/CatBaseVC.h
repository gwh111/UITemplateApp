//
//  CatBaseVC.h
//  UITemplateKit
//
//  Created by 路飞 on 2019/6/4.
//  Copyright © 2019 路飞. All rights reserved.
//

#import "CC_UIKit.h"
#import "UIViewController+CatBase.h"
#import "CatNavBarView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CatBaseVC : CC_ViewController

@property (nonatomic,strong) NSString *fromStr;

@property (nonatomic,strong) NSString *toStr;

- (UIStatusBarStyle)preferredStatusBarStyle;

-(UIStatusBarStyle)getStatusBarStyle;

-(void)pressBackButton;

@end

NS_ASSUME_NONNULL_END
