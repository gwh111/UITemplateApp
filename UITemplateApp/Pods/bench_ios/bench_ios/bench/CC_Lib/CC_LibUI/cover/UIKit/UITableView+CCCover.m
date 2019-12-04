//
//  UITableView+CCCover.m
//  CoverDemo
//
//  Created by Shepherd on 2019/10/27.
//  Copyright © 2019 Shepherd. All rights reserved.
//

#import "UITableView+CCCover.h"
#import <objc/message.h>
#import "UIBezierPath+CCCover.h"
#import "NSArray+CCCover.h"

@implementation UITableView (CCCover)

- (UIBezierPath *)cc_defaultCoverablePath {
    NSArray *ids = self.coverableCellsIdentifiers;
    if (ids) {
        return [self makeCoverablePath:ids];
    }
    return [self makeCoverablePathFromVisibleCells];
}

- (void)setCoverableCellsIdentifiers:(NSArray *)cellsIdentifiers {
    objc_setAssociatedObject(self, @selector(coverableCellsIdentifiers), cellsIdentifiers, OBJC_ASSOCIATION_COPY);
}

- (NSArray *)coverableCellsIdentifiers {
    return objc_getAssociatedObject(self, @selector(coverableCellsIdentifiers));
}

- (UIBezierPath *)makeCoverablePath:(NSArray *)cellsIdentifiers {
    CGFloat height = 0;
    
    UIBezierPath *totalPath = [UIBezierPath new];
    
    for (int i = 0; i < cellsIdentifiers.count; ++i) {
        NSString *cellID = cellsIdentifiers[i];
        UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:cellID];
        cell.frame = CGRectMake(0, height, self.frame.size.width, cell.frame.size.height);
        UIBezierPath *cellCoverablePath = [cell cc_makeCoverablePath:cell];
        [cellCoverablePath translateToPoint:CGPointMake(0, cell.frame.origin.y)];
        [totalPath appendPath:cellCoverablePath];
        
        height += cell.frame.size.height;
    }
        
    return totalPath;
}

- (UIBezierPath *)makeCoverablePathFromVisibleCells {
    return self.visibleCells.cc_coverablePath;
}

@end
