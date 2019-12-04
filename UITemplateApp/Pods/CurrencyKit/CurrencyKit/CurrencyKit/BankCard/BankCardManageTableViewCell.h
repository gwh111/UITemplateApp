//
//  BankCardManageTableViewCell.h
//  CurrencyKit
//
//  Created by gwh on 2019/11/14.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CurrencyShare.h"
#import "ccs.h"

NS_ASSUME_NONNULL_BEGIN

@interface BankCardManageTableViewCell : UITableViewCell

@property (nonatomic, retain) CC_Button *setDefaultButton;

- (void)update:(NSDictionary *)bankDic;

@end

NS_ASSUME_NONNULL_END
