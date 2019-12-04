//
//  ChargePayMethodController.h
//  CurrencyKit
//
//  Created by gwh on 2019/11/12.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CurrencyShare.h"
#import "CC_Controller.h"

NS_ASSUME_NONNULL_BEGIN

@class ChargeMethodC;
@protocol ChargeMethodControllerDelegate <NSObject>

- (void)finishUpdateController:(ChargeMethodC *)controller;

@end

@interface ChargeMethodC : CC_Controller <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) CC_View *displayView;

- (void)updatePay:(CC_Money *)payMoney;

@end

NS_ASSUME_NONNULL_END
