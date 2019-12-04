//
//  PTMedicalModel.m
//  Patient
//
//  Created by ml on 2019/7/12.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "PTMedicineInfoModel.h"

@implementation PTMedicineInfoModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"medicalID":@"id",@"icon":@"imageUrl"};
}

- (NSString *)cc_unique {
    return @"medicalID";
}

@end
