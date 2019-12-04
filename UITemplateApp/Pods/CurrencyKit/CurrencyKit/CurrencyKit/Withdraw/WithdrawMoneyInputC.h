//
//  WithdrawMoneyInputController.h
//  CurrencyKit
//
//  Created by gwh on 2019/11/12.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CurrencyShare.h"
#import "CC_Controller.h"

NS_ASSUME_NONNULL_BEGIN

@interface WithdrawMoneyInputC : CC_Controller <UITextFieldDelegate>

@property (nonatomic, retain) CC_View *displayView;
@property (nonatomic, retain) CC_TextField *moneyTextField;

- (void)updateWithdrawAmount:(WithdrawBasicInfoQueryModel *)withdrawBasicInfoQueryModel;

@end

NS_ASSUME_NONNULL_END
