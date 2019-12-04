//
//  SearchWithDateController.h
//  CurrencyKit
//
//  Created by gwh on 2019/11/12.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CurrencyShare.h"
#import "CC_Controller.h"

NS_ASSUME_NONNULL_BEGIN

@class SearchWithDateC;

@protocol SearchWithDateControllerDelegate <NSObject>

- (void)controller:(CC_Controller *)controller searchFromDate:(NSString *)fromDate toDate:(NSString *)toDate;

@end

@interface SearchWithDateC : CC_Controller

@property (nonatomic, retain) CC_View *displayView;
@property (nonatomic, retain) CC_Button *fromButton;
@property (nonatomic, retain) CC_Button *toButton;

@end

NS_ASSUME_NONNULL_END
