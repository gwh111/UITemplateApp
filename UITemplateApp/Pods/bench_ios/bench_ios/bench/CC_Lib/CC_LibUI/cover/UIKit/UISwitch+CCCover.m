//
//  UISwitch+CCCover.m
//  CoverDemo
//
//  Created by Shepherd on 2019/10/27.
//  Copyright © 2019 Shepherd. All rights reserved.
//

#import "UISwitch+CCCover.h"

@implementation UISwitch (CCCover)

- (UIBezierPath *)cc_defaultCoverablePath {
    return [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.bounds.size.height / 2];
}

@end
