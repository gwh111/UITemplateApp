//
//  CatPreviewToolView.m
//  UITemplateKit
//
//  Created by ml on 2019/11/4.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatPreviewToolView.h"
#import "ccs.h"

@implementation CatPreviewToolView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.whiteColor;
        
        _previewLabel = ccs.Label
        .cc_addToView(self)
        .cc_text(@"预览")
        .cc_textColor(HEX(0x999999))
        .cc_font(RF(16))
        .cc_backgroundColor(HEX(0xffffff))
        .cc_left(RH(15))
        .cc_sizeToFit()
        .cc_centerYSuper();
        
        _selectOriginImageButton = ccs.Button
        .cc_addToView(self)
        .cc_setTitleForState(@"  原图",UIControlStateNormal)
        .cc_setTitleColorForState(HEX(333333),UIControlStateNormal)        
        .cc_left(RH(60))
        .cc_sizeToFit()
        .cc_font(RF(12))
        .cc_centerYSuper();
    }
    return self;
}

- (CatPreviewToolView *)cc_previewWithBlock:(void (^)(CC_Label *))block {
    [self.previewLabel cc_tappedInterval:0.1 withBlock:block];
    return self;
}

- (CatPreviewToolView *)cc_selectOriginImageWithBlock:(void (^)(CC_Button * _Nonnull))block {
    [self.selectOriginImageButton cc_addTappedOnceDelay:0.1 withBlock:block];
    return self;
}

@end
