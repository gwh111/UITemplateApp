//
//  CatFakeNavView.m
//  UITemplateKit
//
//  Created by ml on 2019/11/4.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatFakeNavView.h"
#import "ccs.h"
#import "CatPhotoManager.h"

@implementation CatFakeNavView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.whiteColor;
        
        CC_Button *backButton = ccs.Button
        .cc_addToView(self)
        .cc_frame(15, STATUS_BAR_HEIGHT + 10, 44, 24)
        .cc_setImageForState(imageFromBundle(@"CatPickerPhoto", @"nav_back"),UIControlStateNormal);
        
        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -35, 0, 0);
        
        CC_Button *titleButton = ccs.Button
        .cc_addToView(self)
        .cc_setTitleForState(@"所有照片",UIControlStateNormal)
        .cc_setTitleColorForState(HEX(333333),UIControlStateNormal)
        .cc_sizeToFit()
        .cc_centerX(self.centerX)
        .cc_centerY(backButton.centerY);
        
        CC_Label *arrowLabel = ccs.Label
        .cc_tag(10)
        .cc_addToView(self)
        .cc_text(@"⌄")
        .cc_textColor(HEX(0x333333))
        .cc_font([UIFont systemFontOfSize:26])
        .cc_sizeToFit()
        .cc_centerY(titleButton.centerY - 6)
        .cc_left(titleButton.right + RH(2));
        
        CC_Button *doneButton = ccs.Button
        .cc_addToView(self)
        .cc_setTitleForState(@"完成",UIControlStateNormal)
        .cc_font(RF(13))
        .cc_setTitleColorForState(HEX(4D89FD),UIControlStateNormal)        
        .cc_sizeToFit()
        .cc_right(RH(-11))
        .cc_centerY(titleButton.centerY);
        
        _titleButton = titleButton;
        _backButton = backButton;
        _doneButton = doneButton;
        _arrowLabel = arrowLabel;
    }
    return self;
}

@end
