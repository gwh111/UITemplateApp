//
//  WithdrawBankCardController.h
//  CurrencyKit
//
//  Created by gwh on 2019/11/13.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CurrencyShare.h"
#import "CC_Controller.h"

NS_ASSUME_NONNULL_BEGIN

@class WithdrawBankCardC;
@protocol WithdrawBankCardControllerDelegate <NSObject>

- (void)gotoAddBankCardViewController;
- (void)controller:(WithdrawBankCardC *)controller bankSelected:(NSDictionary *)selectBankDic;

@end

@interface WithdrawBankCardC : CC_Controller <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) CC_View *displayView;

- (void)showBankCardOn:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
