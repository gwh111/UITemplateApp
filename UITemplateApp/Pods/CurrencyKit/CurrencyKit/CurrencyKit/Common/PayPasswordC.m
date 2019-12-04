//
//  PayPasswordController.m
//  CurrencyKit
//
//  Created by gwh on 2019/11/13.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "PayPasswordC.h"

@interface PayPasswordC ()

@property (nonatomic, retain) CC_View *popView;

@end

@implementation PayPasswordC

- (void)showPayPasswordOn:(UIView *)view {
    
    _displayView = ccs.View
    .cc_backgroundColor(HEXA(#000000, 0.5))
    .cc_addToView(view);
    _displayView.frame = view.frame;
    
    _popView = ccs.View
    .cc_frame(0, HEIGHT(), WIDTH(), RH(300))
    .cc_backgroundColor(HEX(#F5F5F5))
    .cc_cornerRadius(10)
    .cc_addToView(_displayView);
    
    CC_Button *closeButton = ccs.Button;
    closeButton
    .cc_frame(_popView.width - RH(45), RH(20), RH(30), RH(30))
    .cc_setTitleColorForState(HEX(#B8B8B8), UIControlStateNormal)
    .cc_font(BRF(15))
    .cc_setTitleForState(@"X", UIControlStateNormal)
    .cc_addToView(_popView);
    [closeButton cc_addTappedOnceDelay:.1 withBlock:^(CC_Button *btn) {
        
        [UIView animateWithDuration:.2 animations:^{
            
            self.popView.top = HEIGHT();
            self.displayView.alpha = 0;
        } completion:^(BOOL finished) {

            [self.displayView removeFromSuperview];
        }];
    }];
    
    CC_Label *label = ccs.Label;
    label
    .cc_frame(_popView.width/2 - RH(100), RH(15), RH(200), RH(35))
    .cc_textColor(HEX(#333333))
    .cc_font(BRF(17))
    .cc_textAlignment(NSTextAlignmentCenter)
    .cc_text(@"请输入支付密码")
    .cc_addToView(_popView);
    
    ccs.View
    .cc_frame(_popView.width/2 - RH(150), label.bottom + RH(20), RH(300), RH(45))
    .cc_borderWidth(1)
    .cc_borderColor(HEX(#B8B8B8))
    .cc_cornerRadius(4)
    .cc_addToView(_popView);
    
    for (int i = 0; i < 5; i++) {
        ccs.View
        .cc_frame(_popView.width/2 - RH(100) + RH(50) * i, label.bottom + RH(20), 1, RH(45))
        .cc_backgroundColor(HEX(#B8B8B8))
        .cc_addToView(_popView);
    }
    
    for (int i = 0; i < 6; i++) {
        ccs.View
        .cc_name([ccs string:@"point%d", i])
        .cc_frame(_popView.width/2 - RH(125) + RH(50) * i, label.bottom + RH(40), RH(6), RH(6))
        .cc_cornerRadius(RH(3))
        .cc_backgroundColor(UIColor.blackColor)
        .cc_addToView(_popView)
        .cc_hidden(YES);
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillShowNotification object:nil];
    
    CC_TextField *textField = ccs.TextField
    .cc_delegate(self)
    .cc_addToView(_popView);
    textField.keyboardType = UIKeyboardTypeNumberPad;
    [textField becomeFirstResponder];
    
    CC_Button *forgetButton = ccs.Button;
    forgetButton
    .cc_frame(WIDTH() - RH(90), RH(120), RH(60), RH(35))
    .cc_setTitleColorForState(HEX(#4DA0FF), UIControlStateNormal)
    .cc_font(RF(13))
    .cc_setTitleForState(@"忘记密码", UIControlStateNormal)
    .cc_addToView(_popView);
    
}

- (void)keyboardAction:(NSNotification *)sender {
    NSDictionary *useInfo = [sender userInfo];
    NSValue *value = [useInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    float height = [value CGRectValue].size.height;
    CCLOG(@"%f", height);
    
    [UIView animateWithDuration:.3 animations:^{
        self->_popView.top = HEIGHT() - height - RH(200);
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField.text.length >= 5) {
        [self passwordInputDone];
    }
    
    if (textField.text.length >= 6) {
        if (string.length > 0) {
            return NO;
        }
    }
    
    NSUInteger tag = textField.text.length;
    CC_View *view = [_popView cc_viewWithName:[ccs string:@"point%d", tag]];
    if (string.length > 0) {
        view.hidden = NO;
    } else {
        view = [_popView cc_viewWithName:[ccs string:@"point%d", tag - 1]];
        view.hidden = YES;
    }
    
    return YES;
}

- (void)passwordInputDone {
    CCLOG(@"passwordInputDone");
}

@end
