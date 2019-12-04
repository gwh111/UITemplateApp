//
//  NSArray+CCFetch.m
//  Patient
//
//  Created by ml on 2019/8/7.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "NSArray+CCFetch.h"

@implementation NSArray (CCFetch)

+ (NSArray *)fetchAll:(NSArray<NSObject<CCFetch> *> *)models {
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:models.count];
    for (NSObject<CCFetch> *model in models) {
        NSString *identifier = model.cc_fetchKey;
        if(identifier) {
            id obj = [model valueForKey:identifier];
            [arrM addObject:obj];
        }
    }
    return arrM.copy;
}

@end
