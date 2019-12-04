//
//  CatFakeNavView.h
//  UITemplateKit
//
//  Created by ml on 2019/11/4.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CC_Button,CC_View,CC_Label;

@interface CatFakeNavView : UIView

/// 返回按钮
@property (nonatomic,weak) CC_Button *backButton;

/// 标题
@property (nonatomic,weak) CC_Button *titleButton;

@property (nonatomic,weak) CC_Label *arrowLabel;

/// 完成按钮
@property (nonatomic,weak) CC_Button *doneButton;

@end

NS_ASSUME_NONNULL_END
