//
//  CatTakePhotoCell.m
//  Patient
//
//  Created by ml on 2019/6/14.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatTakePhotoCell.h"

@implementation CatTakePhotoCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _takePhotoButton = [UIButton new];
    _takePhotoButton.frame = self.contentView.bounds;
    _takePhotoButton.userInteractionEnabled = NO;
    _takePhotoButton.imageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:_takePhotoButton];
}

@end
