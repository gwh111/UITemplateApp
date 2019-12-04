//
//  BankChooseController.h
//  CurrencyKit
//
//  Created by gwh on 2019/11/15.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CurrencyShare.h"
#import "CC_Controller.h"

NS_ASSUME_NONNULL_BEGIN

@class BankChooseC;
@protocol BankChooseControllerDelegate <NSObject>

- (void)controller:(BankChooseC *)controller tappedWithBankDic:(NSDictionary *)bankDic;

@end

@interface BankChooseC : CC_Controller
<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) CC_View *displayView;

- (void)showBankChooseOn:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
