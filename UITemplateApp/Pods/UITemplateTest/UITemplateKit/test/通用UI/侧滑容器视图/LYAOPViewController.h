//
//  LYAOPViewController.h
//  UITemplateKit
//
//  Created by ml on 2019/7/4.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CC_UIKit.h"
NS_ASSUME_NONNULL_BEGIN

#define LY_RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define LY_RandomColor LY_RGBA((arc4random() % 256),(arc4random() % 256),(arc4random() % 256),1)

@interface LYAOPViewController : CC_ViewController

@property (nonatomic,copy) NSArray *itemTitles;

- (void)targetAction:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
