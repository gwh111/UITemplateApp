//
//  AccountService.h
//  AccountLib
//
//  Created by gwh on 2019/11/11.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Foundation.h"
#import "ccs.h"

#import "AccountC.h"

NS_ASSUME_NONNULL_BEGIN

@interface AccountService : CC_Service

@property (nonatomic, retain) NSString *mainURL;
@property (nonatomic, retain) NSArray *mainURLs;

+ (instancetype)shared;

@end

NS_ASSUME_NONNULL_END
