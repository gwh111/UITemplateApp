//
//  testPersonModel.h
//  UITemplateLib
//
//  Created by ml on 2019/5/28.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CatPersonSelectVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface testPersonModel : NSObject <CatPersonSelectDatesource>

@property (nonatomic,copy) NSString *pid;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *showName;
@property (nonatomic,copy) NSString *icon;
/** 类型判定的字段: A-Z */
@property (nonatomic,copy) NSString *initial;

@end

NS_ASSUME_NONNULL_END
