//
//  BankCardAddController.h
//  CurrencyKit
//
//  Created by gwh on 2019/11/13.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CurrencyShare.h"
#import "CC_Controller.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BankCardEditControllerDelegate <NSObject>

- (void)popBankChooseController;
- (void)gotoSubBankChooseViewController;
- (void)popAreaChooseViewController;
- (void)updateInfoFinish:(BOOL)finish;

@end

@interface BankCardEditC : CC_Controller <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, retain) CC_View *displayView;
@property (nonatomic, retain) CC_TextField *cardNumberTextField;
@property (nonatomic, retain) UISwitch *defaultSelectSwitch;

- (void)updateCardNumber:(NSString *)cardNumberString;
- (void)updateBank:(NSString *)bankString;
- (void)updateArea:(NSString *)areaString;
- (void)updateSubBank:(NSString *)bankString;

@end

NS_ASSUME_NONNULL_END
