//
//  CurrenyConfigure.m
//  CurrencyKit
//
//  Created by gwh on 2019/11/12.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CurrencyConfig.h"

@implementation CurrencyConfig

+ (instancetype)shared {
    return [ccs registerSharedInstance:self block:^{
        [CurrencyConfig.shared start];
    }];
}

- (void)start {
    _doneButtonColor = HEX(#F8492F);
    _doneButtonTextColor = UIColor.whiteColor;
    _doneButtonRadius = 4;
    
    _chooseButtonColor = UIColor.whiteColor;
    _chooseButtonTextColor = HEX(#F8492F);
    _chooseButtonBorderColor = HEX(#F8492F);
    
}

@end
