//
//  WithdrawMethodController.h
//  CurrencyKit
//
//  Created by gwh on 2019/11/12.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CurrencyShare.h"
#import "CC_Controller.h"

NS_ASSUME_NONNULL_BEGIN

@protocol WithdrawMethodControllerDelegate <NSObject>

- (void)popBankCardView;
- (void)gotoWithdrawDetailViewController;

@end

@interface WithdrawMethodC : CC_Controller

@property (nonatomic, retain) CC_View *displayView;

@property (nonatomic, retain) CC_Button *withdrawAskButton;

- (void)update:(NSDictionary *)accountWithdrawBankSimple;

@end

NS_ASSUME_NONNULL_END
