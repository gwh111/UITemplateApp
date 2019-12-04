//
//  FreezeDetailController.h
//  CurrencyKit
//
//  Created by gwh on 2019/11/15.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CurrencyShare.h"
#import "CC_Controller.h"

NS_ASSUME_NONNULL_BEGIN

@interface FreezeDetailC : CC_Controller
<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) CC_View *displayView;

- (void)searchFromDate:(NSString *)fromDate toDate:(NSString *)toDate;
- (void)updateFreezeDetail;

@end

NS_ASSUME_NONNULL_END
