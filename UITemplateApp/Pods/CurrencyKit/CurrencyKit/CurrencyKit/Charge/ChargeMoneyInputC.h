//
//  ChargeMoneyChooseController.h
//  CurrencyKit
//
//  Created by gwh on 2019/11/12.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CurrencyShare.h"
#import "CC_Controller.h"

NS_ASSUME_NONNULL_BEGIN

@class ChargeMoneyInputC;

@protocol ChargeMoneyInputControllerDelegate <NSObject>

- (void)controller:(ChargeMoneyInputC *)controller moneyChanged:(CC_Money *)money;

@end

@interface ChargeMoneyInputC : CC_Controller <CC_LabelGroupDelegate, UITextFieldDelegate>

@property (nonatomic, retain) CC_View *displayView;
@property (nonatomic, retain) CC_TextField *moneyTextField;

- (void)updateWithMoneyList:(NSArray *)moneyList;

@end

NS_ASSUME_NONNULL_END
