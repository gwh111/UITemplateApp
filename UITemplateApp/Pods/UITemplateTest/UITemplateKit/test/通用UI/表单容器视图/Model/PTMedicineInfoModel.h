//
//  PTMedicalModel.h
//  Patient
//
//  Created by ml on 2019/7/12.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSMutableArray+CCUnique.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTMedicineInfoModel : NSObject <CCUnique>

@property (nonatomic,copy) NSString *medicalID;
@property (nonatomic,copy) NSString *icon;
/** 处方类型 */
@property (nonatomic,copy) NSString *otcType;
/** 最大价格 */
@property (nonatomic,copy) NSString *maxPrice;
/** 商品名 */
@property (nonatomic,copy) NSString *tradeName;
/** 处方名 */
@property (nonatomic,copy) NSString *otcName;
/** 生产企业名称 */
@property (nonatomic,copy) NSString *productCompanyName;
/** 规格 */
@property (nonatomic,copy) NSString *spec;

@end

NS_ASSUME_NONNULL_END
