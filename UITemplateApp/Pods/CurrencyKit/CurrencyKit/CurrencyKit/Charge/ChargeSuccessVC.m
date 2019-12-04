//
//  ChargeSuccessViewController.m
//  CurrencyKit
//
//  Created by gwh on 2019/11/13.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "ChargeSuccessVC.h"

@interface ChargeSuccessVC ()

@end

@implementation ChargeSuccessVC

- (void)cc_viewWillLoad {
   
    self.cc_navigationBarHidden = YES;
    
    ccs.ImageView
    .cc_frame(WIDTH()/2 - RH(50), HEIGHT()/2 - RH(250), RH(100), RH(100))
    .cc_imageNamed(@"charge_success")
    .cc_addToView(self.cc_displayView);
    
    ccs.Label
    .cc_frame(WIDTH()/2 - RH(50), HEIGHT()/2 - RH(150), RH(100), RH(50))
    .cc_textColor(HEX(#666666))
    .cc_font(RF(17))
    .cc_textAlignment(NSTextAlignmentCenter)
    .cc_text(@"支付成功")
    .cc_addToView(self);
    
    CC_Button *button = ccs.Button
    .cc_frame(WIDTH()/2 - RH(100), HEIGHT() - RH(200), RH(200), RH(40))
    .cc_setTitleColorForState(HEX(#999999), UIControlStateNormal)
    .cc_font(RF(15))
    .cc_cornerRadius(RH(20))
    .cc_borderColor(HEX(#999999))
    .cc_borderWidth(1)
    .cc_setTitleForState(@"完成", UIControlStateNormal)
    .cc_addToView(self.cc_displayView);
    [button cc_addTappedOnceDelay:.1 withBlock:^(CC_Button *btn) {
        [ccs popViewController];
    }];
}

- (void)cc_viewDidLoad {
	 // Do any additional setup after loading the view.
}

@end
