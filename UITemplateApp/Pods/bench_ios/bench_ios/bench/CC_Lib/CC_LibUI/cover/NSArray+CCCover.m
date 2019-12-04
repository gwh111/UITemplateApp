//
//  NSArray+CCCover.m
//  CoverDemo
//
//  Created by Shepherd on 2019/10/27.
//  Copyright © 2019 Shepherd. All rights reserved.
//

#import "NSArray+CCCover.h"
#import "UIView+CCCover.h"

@implementation NSArray (CCCover)

- (UIBezierPath *)cc_coverablePath {
    UIBezierPath *totalPath = UIBezierPath.new;
    for (UIView *view in self) {
        if ([view isKindOfClass:UIView.class]) {
            [view cc_addCoverablePath:totalPath superview:nil];
        }
    }
    
    return totalPath;
}

@end
