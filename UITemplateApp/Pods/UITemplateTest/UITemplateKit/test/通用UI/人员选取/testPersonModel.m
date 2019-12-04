//
//  testPersonModel.m
//  UITemplateLib
//
//  Created by ml on 2019/5/28.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "testPersonModel.h"

@implementation testPersonModel


- (NSString *)cat_diffIdentifier {
    return @"pid";
}

+ (NSDictionary<CatPersonSelectStringKey,id> *)cat_mapper {
    return @{
             CatPersonSelectTitleString:@[@"showName",@"name"],
             CatPersonSelectImageString:@"icon",
             CatPersonSelectCategroyString:@"initial"
             };
}


@end
