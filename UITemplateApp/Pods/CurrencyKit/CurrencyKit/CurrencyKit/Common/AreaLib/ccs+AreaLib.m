//
//  ccs+AreaLib.m
//  CurrencyKit
//
//  Created by gwh on 2019/11/20.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "ccs+AreaLib.h"

@implementation ccs (AreaLib)

+ (Area *)areaLib_area {
    id c = [cc_message cc_targetClass:@"AreaLib" method:@"shared" params:nil];
    return [cc_message cc_targetInstance:c method:@"area" params:nil];
}

+ (void)areaLib_configureMainURLs:(NSArray *)urls {
    AreaService.shared.mainURL = urls[ccs.getEnvironment];
    AreaService.shared.mainURLs = urls;
}

@end
