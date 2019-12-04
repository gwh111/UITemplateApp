//
//  UIStepper+CCCover.m
//  CoverDemo
//
//  Created by Shepherd on 2019/10/27.
//  Copyright © 2019 Shepherd. All rights reserved.
//

#import "UIStepper+CCCover.h"

@implementation UIStepper (CCCover)

- (UIBezierPath *)cc_defaultCoverablePath {
    return [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:4];
}

@end
