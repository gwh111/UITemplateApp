//
//  WithdrawInfoController.m
//  CurrencyKit
//
//  Created by gwh on 2019/11/18.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "WithdrawInfoC.h"

@interface WithdrawInfoC ()

@property (nonatomic, retain) CC_View *popView;

@end

@implementation WithdrawInfoC

- (void)showWithdrawInfoOn:(UIView *)view text:(NSString *)text {
    
    _displayView = ccs.View
    .cc_backgroundColor(HEXA(#000000, 0.5))
    .cc_addToView(view);
    _displayView.frame = view.frame;
    
    _popView = ccs.View
    .cc_frame(RH(20), HEIGHT()/2 - RH(200), WIDTH() - RH(40), RH(350))
    .cc_backgroundColor(HEX(#FFFFFF))
    .cc_cornerRadius(10)
    .cc_addToView(_displayView);
    
    ccs.Label
    .cc_frame(0, RH(15), _popView.width, RH(35))
    .cc_textColor(HEX(#333333))
    .cc_textAlignment(NSTextAlignmentCenter)
    .cc_font(BRF(17))
    .cc_text(@"提现说明")
    .cc_addToView(_popView);
    
    ccs.TextView
    .cc_frame(RH(10), RH(50), _popView.width - RH(20), _popView.height - RH(60))
    .cc_textColor(HEX(#666666))
    .cc_backgroundColor(UIColor.clearColor)
    .cc_font(RF(12))
    .cc_editable(NO)
    .cc_text(text)
    .cc_addToView(_popView);
    
    CC_Button *closeButton = ccs.Button
    .cc_frame(_displayView.width/2 - RH(25), _displayView.height/2 + RH(200), RH(50), RH(50))
    .cc_setImageForState(IMAGE(@"withdrawInfo_close"), UIControlStateNormal)
    .cc_addToView(_displayView);
    [closeButton cc_addTappedOnceDelay:.1 withBlock:^(CC_Button *btn) {
        
        [UIView animateWithDuration:.2 animations:^{
            
            self.displayView.alpha = 0;
        } completion:^(BOOL finished) {

            [self.displayView removeFromSuperview];
        }];
    }];
    
}

@end
