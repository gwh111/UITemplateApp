//
//  BankChooseTableViewCell.h
//  CurrencyKit
//
//  Created by gwh on 2019/11/15.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CurrencyShare.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SubBankChooseTableViewCell : UITableViewCell

@property (nonatomic, retain) CC_Label *bankNameLabel;
@property (nonatomic, retain) CC_Button *tapButton;
@property (nonatomic, retain) CC_Button *selectButton;

@end

NS_ASSUME_NONNULL_END
