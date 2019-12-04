//
//  CatPickerPhotoCell.m
//  Patient
//
//  Created by ml on 2019/6/14.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatPickerPhotoCell.h"
#import "ccs.h"

@implementation CatPickerPhotoCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {    
    _icon = [UIImageView new];
    _icon.contentMode = UIViewContentModeScaleAspectFill;
    _icon.frame = self.bounds;    
    [self.contentView addSubview:_icon];

    _checkButton = [UIButton new];
    // _checkButton.userInteractionEnabled = NO;
    [_checkButton setImage:[UIImage new] forState:UIControlStateNormal];
    [_checkButton setImage:[UIImage new] forState:UIControlStateSelected];
    _checkButton.frame = CGRectMake(self.contentView.width - RH(4) - RH(25), RH(4), RH(25), RH(25));
    [self.contentView addSubview:_checkButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.clipsToBounds = YES;
}

@end
