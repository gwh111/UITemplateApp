//
//  UICollectionView+CCCover.m
//  CoverDemo
//
//  Created by Shepherd on 2019/10/27.
//  Copyright © 2019 Shepherd. All rights reserved.
//

#import "UICollectionView+CCCover.h"
#import "NSArray+CCCover.h"

@implementation UICollectionView (CCCover)

- (UIBezierPath *)cc_defaultCoverablePath {
    UIBezierPath *coverablePath = self.visibleCells.cc_coverablePath;
    CGPoint point = CGPointApplyAffineTransform(self.contentOffset, self.transform);
    CGAffineTransformMakeScale(point.x, CGPointApplyAffineTransform(self.contentOffset, self.transform).y);
     
    return coverablePath;
}


@end
