//
//  CatTofuView.m
//  UITemplateKit
//
//  Created by ml on 2019/7/29.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatTofuView.h"
#import "ccs.h"

@implementation CatTofuView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _commonInit];
    }
    return self;
}

- (void)_commonInit {
    self
        .LYBigTitleLabel
        .LYTitleLabel
        .LYAccessoryIcon
        .LYOneView.n2BackgroundColor(HEX(0xffffff)).n2Radius(17)
    ;
}

- (instancetype)createWithBigTitle:(NSString *)bigTitle
                             title:(NSString *)title {
    self
        .LYOneView.n2Left(RH(6)).n2Top(RH(6)).n2W(self.width - RH(6) * 2)
        .LYBigTitleLabel.n2Text(bigTitle).n2TextColor(HEX(0x333333)).n2Font(RF(15)).n2SizeToFit()
        .LYTitleLabel.n2Text(title).n2TextColor(HEX(0x333333)).n2Font(RF(15)).n2SizeToFit()
        .LYAccessoryIcon.n2Text(@"")
    ;
    return self;
}

@end
