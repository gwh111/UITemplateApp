//
//  NSMutableArray+Unique.m
//  Patient
//
//  Created by ml on 2019/7/16.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "NSMutableArray+CCUnique.h"

@implementation NSMutableArray (CCUnique)

- (void)addModel:(NSObject<CCUnique> *)model {
    BOOL isExisted = NO;
    NSString *identifier = model.cc_unique;
    for (NSObject<CCUnique> *p in self) {
        if ([[p valueForKey:identifier] isEqualToString:[model valueForKey:identifier]]) {
            isExisted = YES;
        }
    }
    
    if (isExisted == NO) {
        [self addObject:model];
    }
}

- (void)updateModelWithModel:(NSObject<CCUnique> *)model {
    NSString *identifier = model.cc_unique;
    NSInteger index = NSNotFound;
    for (int i = 0; i < self.count; ++i) {
        NSObject<CCUnique> *p = self[i];
        if ([[p valueForKey:identifier] isEqualToString:[model valueForKey:identifier]]) {
            index = i;
            break;
        }
    }
    
    if (index != NSNotFound) {
        [self replaceObjectAtIndex:index withObject:model];
    }
}

- (void)addModelsFromArray:(NSArray <id<CCUnique>> *)models {
    for (id<CCUnique> model in models) {
        [self addModel:model];
    }
}

- (void)removeModelWithUniqueID:(NSString *)ID {
    id<CCUnique> model = [self findModelWithUniqueID:ID];
    if (model) {
        [self removeObject:model];
    }
}

- (id<CCUnique>)findModelWithUniqueID:(NSString *)ID {
    for (NSObject<CCUnique> *model in self) {
        NSString *identifier = model.cc_unique;
        if ([[model valueForKey:identifier] isEqualToString:ID]) {
            return model;
        }
    }
    return nil;
}

@end
