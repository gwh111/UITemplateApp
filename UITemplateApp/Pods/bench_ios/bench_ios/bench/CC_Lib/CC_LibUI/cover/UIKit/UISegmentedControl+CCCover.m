//
//  UISegmentedControl+CCCover.m
//  CoverDemo
//
//  Created by Shepherd on 2019/10/27.
//  Copyright © 2019 Shepherd. All rights reserved.
//

#import "UISegmentedControl+CCCover.h"

@implementation UISegmentedControl (CCCover)

- (UIBezierPath *)cc_defaultCoverablePath {
    return [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:4];
}


@end
