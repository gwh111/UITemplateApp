//
//  CatLoginSmsTextField.h
//  UITemplateKit
//
//  Created by ml on 2019/6/12.
//  Copyright © 2019 路飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CatLoginCountButton.h"

NS_ASSUME_NONNULL_BEGIN

@class CatLoginSmsTextField;

@protocol CatLoginSmsTextFieldDeleagte <UITextFieldDelegate>

- (void)smsTextField:(CatLoginSmsTextField *)textField withSender:(CatLoginCountButton *)countButton;

@end

@interface CatLoginSmsTextField : UITextField

@property (nonatomic,weak) CatLoginCountButton *countButton;
@property (nonatomic,weak) id<CatLoginSmsTextFieldDeleagte> smsDelegate;

@end

NS_ASSUME_NONNULL_END
