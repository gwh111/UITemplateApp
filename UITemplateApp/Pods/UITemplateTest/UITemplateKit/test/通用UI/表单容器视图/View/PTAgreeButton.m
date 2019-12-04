//
//  PTAgreeButton.m
//  Patient
//
//  Created by ml on 2019/6/11.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "PTAgreeButton.h"
#import "ccs.h"

@implementation PTAgreeButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = RH(20);
    CGFloat imageH = 20;
    CGFloat imageX = 0;
    CGFloat imageY = (contentRect.size.height - imageH) * 0.5;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleW = contentRect.size.width - RH(20);
    CGFloat titleH = contentRect.size.height;
    CGFloat titleX = RH(24);
    CGFloat titleY = (contentRect.size.height - titleH) * 0.5;
    return CGRectMake(titleX, titleY, titleW, titleH);
}


@end
