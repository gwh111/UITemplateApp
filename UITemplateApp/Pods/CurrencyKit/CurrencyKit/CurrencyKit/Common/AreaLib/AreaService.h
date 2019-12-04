//
//  AreaController.h
//  CurrencyKit
//
//  Created by gwh on 2019/11/19.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ccs.h"

NS_ASSUME_NONNULL_BEGIN

@interface AreaService : CC_Service

@property (nonatomic, retain) NSString *mainURL;
@property (nonatomic, retain) NSArray *mainURLs;

+ (instancetype)shared;

@end

NS_ASSUME_NONNULL_END
