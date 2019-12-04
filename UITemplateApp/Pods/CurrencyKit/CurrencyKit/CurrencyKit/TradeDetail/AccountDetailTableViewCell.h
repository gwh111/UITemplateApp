//
//  AccountDetailTableViewCell.h
//  CurrencyKit
//
//  Created by gwh on 2019/11/14.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CurrencyShare.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AccountDetailTableViewCell : UITableViewCell

- (void)update:(NSDictionary *)updateData;

@end

NS_ASSUME_NONNULL_END
