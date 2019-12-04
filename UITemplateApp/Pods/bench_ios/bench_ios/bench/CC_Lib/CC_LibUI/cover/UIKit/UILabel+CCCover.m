//
//  UILabel+CCCover.m
//  CoverDemo
//
//  Created by Shepherd on 2019/10/27.
//  Copyright © 2019 Shepherd. All rights reserved.
//

#import "UILabel+CCCover.h"
#import "UIBezierPath+CCCover.h"
#import <objc/message.h>

@implementation UILabel (CCCover)

- (void)setLinespacing:(CGFloat)linespacing {
    objc_setAssociatedObject(self, @selector(lineSpacing), @(linespacing), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)linespacing {
    return [objc_getAssociatedObject(self, @selector(linespacing)) doubleValue];
}

- (NSInteger)numberOfVisibleLines {
    if (self.font) {
        return MAX(1, self.bounds.size.height / self.font.lineHeight);
    }
    return 1;
}

- (UIBezierPath *)cc_defaultCoverablePath {
    return [UIBezierPath multiLinePath:self.numberOfLines spacing:self.linespacing bounds:self.bounds];
}

@end
