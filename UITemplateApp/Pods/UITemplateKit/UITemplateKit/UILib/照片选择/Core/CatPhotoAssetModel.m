//
//  CatPhotoAssetModel.m
//  UITemplateKit
//
//  Created by Shepherd on 2019/11/6.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatPhotoAssetModel.h"

@implementation CatPhotoAssetModel

+ (instancetype)modelWithAsset:(PHAsset *)asset                    
                          icon:(UIImage *)icon {
    CatPhotoAssetModel *model = [CatPhotoAssetModel new];
    model.asset = asset;
    model.localIdentifier = asset.localIdentifier;
    model.icon = icon;
    return model;
}

@end
