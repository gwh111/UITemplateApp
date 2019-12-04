//
//  BankCardManageController.h
//  CurrencyKit
//
//  Created by gwh on 2019/11/14.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CurrencyShare.h"
#import "CC_Controller.h"

NS_ASSUME_NONNULL_BEGIN

@class BankCardManageC;
@protocol BankCardManageControllerDelegate <NSObject>

- (void)controller:(BankCardManageC *)controller tappedWithCardId:(NSString *)cardId;

@end

@interface BankCardManageC : CC_Controller
<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) CC_View *displayView;

- (void)updateBankList;

@end

NS_ASSUME_NONNULL_END
