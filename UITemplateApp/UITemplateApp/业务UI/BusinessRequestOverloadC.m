//
//  BusinessRequestOverloadC.m
//  UITemplateApp
//
//  Created by gwh on 2019/12/3.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "BusinessRequestOverloadC.h"
#import "ccs+FinanceLib.h"
#import "ccs+AccountLib.h"

@implementation BusinessRequestOverloadC

- (void)cc_willInit {

    // overload request example
    // all the request in kit can be overload
    
    // get modular by ccs.'libname_xxx'
    Freeze *freeze = ccs.accountLib_freeze;
    // catch when request triggered
    [freeze configFreezePageQuery:^(HttpModel * _Nonnull httpModel) {
        
        // get request parameters
        CCLOG(@"%@", httpModel.requestParams);
        
        // reset parameters
        httpModel.requestParams = @{@"success":@(1),@"allowedToFreezeLog":@(1)};
        
        // recover request
        [freeze freezePageQueryFinish:httpModel];
        
    }];
}

@end
