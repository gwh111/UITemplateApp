//
//  AreaController.h
//  CurrencyKit
//
//  Created by gwh on 2019/11/15.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CurrencyShare.h"
#import "CC_Controller.h"

NS_ASSUME_NONNULL_BEGIN

@class AreaChooseC;
@protocol AreaChooseControllerDelegate <NSObject>

- (void)controller:(AreaChooseC *)controller tappedArea:(NSArray *)areaList;

@end

@interface AreaChooseC : CC_Controller
<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) CC_View *displayView;

@property (nonatomic, assign) int maxCount;

- (void)showAreaChooseOn:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
