//
//  CatPhotoAssetModel.h
//  UITemplateKit
//
//  Created by Shepherd on 2019/11/6.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface CatPhotoAssetModel : NSObject

/// 资源
@property (nonatomic,strong) PHAsset *asset;

/// 资源唯一标志符
@property (nonatomic,copy) NSString *localIdentifier;

/// 图片资源
@property (nonatomic,strong) UIImage *icon;

+ (instancetype)modelWithAsset:(PHAsset *)asset                    
                          icon:(UIImage *)icon;

@end

NS_ASSUME_NONNULL_END
