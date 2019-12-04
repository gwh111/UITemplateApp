//
//  CatCascadePickerHeaderView.m
//  UITemplateKit
//
//  Created by ml on 2019/8/13.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatCascadePickerHeaderView.h"
#import "ccs.h"
#import "CatSideView.h"

@implementation CatCascadePickerHeaderView
// MARK: - LifeCycle -
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _commonInit];
    }
    return self;
}

- (void)_commonInit {
    _titleView = [[CatSimpleView alloc] initWithFrame:CGRectMake(0, 0, self.width, RH(56))];
    _titleView
        .LYSelf.n2BackgroundColor(HEX(0xffffff))
        .LYTitleLabel
        .n2Text(@"配送至").n2Font([UIFont boldSystemFontOfSize:15])
        .n2Left(RH(5))
        .n2TextColor(HEX(0x333333)).n2SizeToFit()
        .n2CenterY(_titleView.centerY)
        .LYOneButton
        .n2BtnImage(UIControlStateNormal,[UIImage imageNamed:@"right_close"])
        .n2H(RH(20)).n2W(RH(20))
        .n2CenterY(_titleView.centerY - 6)
        .n2Right(RH(16))
    ;
    
    _titleView.c2Superview(self);
    
    [_titleView.oneButton addTarget:self
                             action:@selector(dismissAction:)
                   forControlEvents:UIControlEventTouchUpInside];
    
    _sectionView = [[CatStickerView alloc] initWithFrame:CGRectMake(0, RH(56), self.width, RH(32))];
    _sectionView.layout.interitemSpacing = 0;
    _sectionView.layout.marginSectionInset = UIEdgeInsetsZero;
    _sectionView.c2Superview(self);
}

- (void)dealloc {
#if DEBUG
    NSLog(@"%s",__func__);
#endif
}

// MARK: - Actions -
- (void)dismissAction:(UIButton *)sender {
    [self.superview.cc_sideView dismissViewAnimated:YES];
}

@end
