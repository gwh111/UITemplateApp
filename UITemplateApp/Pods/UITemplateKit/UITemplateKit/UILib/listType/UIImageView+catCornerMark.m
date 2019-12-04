//
//  UIImageView+cornerMark.m
//  UITemplateLib
//
//  Created by yichen on 2019/6/3.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "UIImageView+catCornerMark.h"
#import "Masonry.h"
#import <objc/runtime.h>

@implementation UIImageView (cornerMark)

-(void)setCornerMarkIcon:(UIImageView *)cornerMarkIcon {
    objc_setAssociatedObject(self, @selector(cornerMarkIcon), cornerMarkIcon, OBJC_ASSOCIATION_RETAIN);
}

-(UIImageView *)cornerMarkIcon {
    return objc_getAssociatedObject(self, @selector(cornerMarkIcon));
}

-(void)setIsCornerShowed:(BOOL)isCornerShowed {
    objc_setAssociatedObject(self, @selector(isCornerShowed), [NSNumber numberWithBool:isCornerShowed], OBJC_ASSOCIATION_ASSIGN);
    if (!self.cornerMarkIcon) {
        self.cornerMarkIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"safari"]];
        [self.superview addSubview:self.cornerMarkIcon];
        [self.cornerMarkIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(1);
            make.bottom.equalTo(self).offset(1);
            make.height.width.mas_equalTo(self.frame.size.width/2);
        }];
    }
    if (isCornerShowed) {
        self.cornerMarkIcon.hidden = NO;
    }else{
        self.cornerMarkIcon.hidden = YES;
    }
}

-(BOOL)isCornerShowed {
    return [objc_getAssociatedObject(self, @selector(isCornerShowed)) boolValue];
}

-(void)addImageWithCornerImage:(UIImage *)image {
    self.cornerMarkIcon.image = image;
}

@end
