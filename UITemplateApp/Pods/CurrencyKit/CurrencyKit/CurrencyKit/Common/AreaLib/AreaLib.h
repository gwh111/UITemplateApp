//
//  AreaLib.h
//  CurrencyKit
//
//  Created by gwh on 2019/11/19.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Area.h"

NS_ASSUME_NONNULL_BEGIN

@interface AreaLib : NSObject

@property (nonatomic, retain) Area *area;

+ (instancetype)shared;

@end

NS_ASSUME_NONNULL_END
