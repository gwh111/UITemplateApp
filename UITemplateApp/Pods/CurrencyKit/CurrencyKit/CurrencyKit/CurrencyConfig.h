//
//  CurrenyConfigure.h
//  CurrencyKit
//
//  Created by gwh on 2019/11/12.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CurrencyShare.h"

NS_ASSUME_NONNULL_BEGIN

@interface CurrencyConfig : NSObject

@property (nonatomic, retain) UIColor *doneButtonColor;
@property (nonatomic, retain) UIColor *doneButtonTextColor;
@property (nonatomic, assign) float doneButtonRadius;

@property (nonatomic, retain) UIColor *chooseButtonColor;
@property (nonatomic, retain) UIColor *chooseButtonTextColor;
@property (nonatomic, retain) UIColor *chooseButtonBorderColor;

+ (instancetype)shared;

@end

NS_ASSUME_NONNULL_END
