//
//  CatImagePreviewCollectionCell.m
//  kk_buluo
//
//  Created by david on 2019/9/24.
//  Copyright © 2019 yaya. All rights reserved.
//

#import "CatImagePreviewCollectionCell.h"

@implementation CatImagePreviewCollectionCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupImageScrollView];
    }
    return self;
}

-(void)setupImageScrollView {
    CatZoomScrollView *imageScrollView = [[CatZoomScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), CGRectGetHeight(self.frame))];
    imageScrollView.closeBlock = ^{
        if (self.closeBlock) self.closeBlock();
    };
    self.imageScrollView = imageScrollView;
    [self.contentView addSubview:imageScrollView];
}

-(void)setImg:(UIImage *)img {
    _img = img;
    
    self.imageScrollView.imageView.image = img;
    CGFloat scale = img.size.height / img.size.width;
    
    CGFloat height = MIN(scale * CGRectGetWidth(self.imageScrollView.bounds), CGRectGetHeight(self.imageScrollView.bounds));
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(self.imageScrollView.bounds), height);
    
    self.imageScrollView.imageView.bounds = frame;
    self.imageScrollView.imageView.center = self.imageScrollView.center;
    self.imageScrollView.contentSize = frame.size;
}

@end
