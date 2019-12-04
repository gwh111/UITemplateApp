//
//  ChargeTableViewCell.h
//  CurrencyKit
//
//  Created by gwh on 2019/11/12.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CurrencyShare.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChargeTableViewCell : UITableViewCell

@property (nonatomic, retain) CC_Button *tapButton;
@property (nonatomic, retain) CC_Button *selectButton;

- (void)update:(NSDictionary *)updateData;

@end

NS_ASSUME_NONNULL_END
