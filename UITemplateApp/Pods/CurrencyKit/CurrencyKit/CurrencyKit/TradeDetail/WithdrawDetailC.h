//
//  WithdrawDetailController.h
//  CurrencyKit
//
//  Created by gwh on 2019/11/13.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CurrencyShare.h"
#import "CC_Controller.h"

NS_ASSUME_NONNULL_BEGIN

@interface WithdrawDetailC : CC_Controller <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) CC_View *displayView;

- (void)searchFromDate:(NSString *)fromDate toDate:(NSString *)toDate;
- (void)updateWithdrawDetail;

@end

NS_ASSUME_NONNULL_END
