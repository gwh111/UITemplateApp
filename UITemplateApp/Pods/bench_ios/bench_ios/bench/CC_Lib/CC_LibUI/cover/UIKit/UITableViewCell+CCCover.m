//
//  UITableViewCell+CCCover.m
//  CoverDemo
//
//  Created by Shepherd on 2019/10/27.
//  Copyright © 2019 Shepherd. All rights reserved.
//

#import "UITableViewCell+CCCover.h"

@implementation UITableViewCell (CCCover)

- (UIBezierPath *)cc_defaultCoverablePath {
    return [self cc_subviewsCoverablePath];
}

@end
