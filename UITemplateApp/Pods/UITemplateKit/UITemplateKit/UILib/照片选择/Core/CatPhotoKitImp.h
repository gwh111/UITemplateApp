//
//  CatPhotoKitImp.h
//  UITemplateKit
//
//  Created by ml on 2019/11/4.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface CatPhotoKitImp : NSObject

@property (nonatomic,strong) PHFetchOptions *options;

@property (nonatomic,strong) PHCachingImageManager *imageManager;

/// 请求照片资源的尺寸
@property (nonatomic,assign) CGSize assetSize;

/// 请求照片资源的模式
@property (nonatomic,assign) PHImageContentMode mode;

/// 当照片库数据资源发生改变时触发该回调
@property (nonatomic,copy) void (^photoLibraryDidChangeHandler)(PHChange *);

///-------------------------------
/// @name Actions
///-------------------------------

/// 请求指定资源并设置完成回调
/// @param asset 资源
/// @param resultHandler 完成回调
- (void)requestImageForAsset:(PHAsset *)asset
               resultHandler:(void (^)(UIImage *result,NSDictionary *info))resultHandler;

/// 获取原始图片数据
/// @param asset 资源
/// @param resultHandler 完成回调
/// @note 很慢,不能用于请求占位图 处理gif时需要NSData
/// 图片类型直接用result.imageFormat判断
- (void)requestDataForAsset:(PHAsset *)asset
              resultHandler:(void (^)(UIImage *result,NSDictionary *info))resultHandler;

/// 获取所有照片Assets
/// 默认option为
/// PHFetchOptions *options = [PHFetchOptions new];
/// options.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"creationDate" ascending:NO]];
/// 以下方法类似
+ (PHFetchResult<PHAsset *> *)fetchAllPhotosWithOption:(nullable PHFetchOptions *)option;

/// 智能相册 - 最近添加 A smart album whose contents update dynamically.
+ (PHFetchResult<PHAsset *> *)fetchRecentAddedPhotosWithOption:(nullable PHFetchOptions *)option;

/// 智能相册 - 喜欢
+ (PHFetchResult<PHAsset *> *)fetchFavoritesPhotosWithOption:(nullable PHFetchOptions *)option;

/// 相册    - 用户自定义
+ (PHFetchResult<PHCollection *> *)fetchUserCollectionsWithOption:(nullable PHFetchOptions *)option;

/// 相册    - 用户自定义 指定的一个
+ (PHFetchResult<PHAsset *> *)fetchUserCollectionsWithOption:(nullable PHFetchOptions *)option atIndex:(NSInteger)index;

///-------------------------------
/// @name utils
///-------------------------------

/// 是否允许使用相册
/// @param handler 授权完成回调,包含是否允许使用的参数
+ (void)canUserPhotoWithCompletionHandler:(void (^)(BOOL granted))handler;

@end

NS_ASSUME_NONNULL_END
