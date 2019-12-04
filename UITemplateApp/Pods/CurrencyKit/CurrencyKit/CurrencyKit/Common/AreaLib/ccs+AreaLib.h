//
//  ccs+AreaLib.h
//  CurrencyKit
//
//  Created by gwh on 2019/11/20.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "ccs.h"
#import "AreaLib.h"

NS_ASSUME_NONNULL_BEGIN

@interface ccs (AreaLib)

+ (Area *)areaLib_area;

+ (void)areaLib_configureMainURLs:(NSArray *)urls;

@end

NS_ASSUME_NONNULL_END
