//
//  CatComEnumModel.h
//  Patient
//
//  Created by ml on 2019/8/8.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 枚举类型模型
@interface CatComEnumModel : NSObject

/// 展示
@property (nonatomic,copy) NSString *message;
/// 参数
@property (nonatomic,copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
