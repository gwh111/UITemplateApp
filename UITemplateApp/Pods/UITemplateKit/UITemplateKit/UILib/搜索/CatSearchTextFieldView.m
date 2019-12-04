//
//  CatSearchTextFieldView.m
//  UITemplateKit
//
//  Created by ml on 2019/7/12.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatSearchTextFieldView.h"

@implementation CatSearchTextFieldView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _commonInit];
    }
    return self;
}

- (void)_commonInit {
    self.LYIcon.LYSepartor.LYSingleLineField.LYSelf.n2BackgroundColor([UIColor whiteColor]);
}

@end
