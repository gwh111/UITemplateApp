//
//  WithdrawInfoController.h
//  CurrencyKit
//
//  Created by gwh on 2019/11/18.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CurrencyShare.h"
#import "CC_Controller.h"

NS_ASSUME_NONNULL_BEGIN

@interface WithdrawInfoC : CC_Controller

@property (nonatomic, retain) CC_View *displayView;

- (void)showWithdrawInfoOn:(UIView *)view text:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
