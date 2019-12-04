//
//  FreezeLogTableViewCell.h
//  CurrencyKit
//
//  Created by gwh on 2019/11/15.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CurrencyShare.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FreezeLogTableViewCell : UITableViewCell

@property (nonatomic, retain) CC_Label *timeLabel;
@property (nonatomic, retain) CC_Label *freezeLabel;
@property (nonatomic, retain) CC_Label *unFreezeLabel;
@property (nonatomic, retain) CC_Label *leftFreezeLabel;
@property (nonatomic, retain) CC_Label *memoLabel;

- (void)update;

@end

NS_ASSUME_NONNULL_END
