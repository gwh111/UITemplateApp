//
//  AccountWithdrawBankDefaultQueryModel.h
//  AccountLib
//
//  Created by gwh on 2019/11/19.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Model.h"
#import "CardType.h"

NS_ASSUME_NONNULL_BEGIN

@interface AccountWithdrawBankDefaultQueryModel : CC_Model

@property (nonatomic, retain) NSString *bankCode;
@property (nonatomic, retain) NSString *bankId;
@property (nonatomic, retain) NSString *bankName;
@property (nonatomic, retain) NSString *bankSubBranchId;
@property (nonatomic, retain) NSString *bankSubBranchName;
@property (nonatomic, retain) NSString *cardNo;
@property (nonatomic, retain) CardType *cardType;
@property (nonatomic, assign) BOOL defaultSelect;
@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, retain) NSString *aId;
@property (nonatomic, retain) NSString *logoUrl;

@end

NS_ASSUME_NONNULL_END
