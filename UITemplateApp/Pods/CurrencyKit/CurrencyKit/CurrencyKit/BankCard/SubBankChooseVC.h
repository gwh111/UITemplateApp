//
//  BankChooseViewController.h
//  CurrencyKit
//
//  Created by gwh on 2019/11/13.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CurrencyShare.h"
#import "CC_ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SubBankChooseVC : CC_ViewController
<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) NSString *bankId;

@end

NS_ASSUME_NONNULL_END
