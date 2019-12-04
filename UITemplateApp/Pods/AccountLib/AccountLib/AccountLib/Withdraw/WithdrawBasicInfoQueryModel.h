//
//  WithdrawBasicInfoQueryModel.h
//  AccountLib
//
//  Created by gwh on 2019/11/19.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface WithdrawBasicInfoQueryModel : CC_Model

@property (nonatomic, retain) CC_Money *withdrawAmount;
@property (nonatomic, retain) CC_Money *allowWithdrawAmount;
@property (nonatomic, retain) NSString *withdrawChargeFeeCalculateType;
@property (nonatomic, retain) CC_Money *maxWithdrawAmount;
@property (nonatomic, retain) CC_Money *minWithdrawAmount;
@property (nonatomic, assign) BOOL showWithdrawDetail;
@property (nonatomic, assign) BOOL showWithdrawExplain;
@property (nonatomic, retain) NSString *withdrawExplain;

@end

NS_ASSUME_NONNULL_END
