
//
//  CatPhotoKitImp.m
//  UITemplateKit
//
//  Created by ml on 2019/11/4.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatPhotoKitImp.h"
#import "ccs.h"

@interface CatPhotoKitImp () <PHPhotoLibraryChangeObserver>

@end

@implementation CatPhotoKitImp

- (instancetype)init {
    if (self = [super init]) {
        _mode = PHImageContentModeAspectFill;
        [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];
    }
    return self;
}

- (void)requestImageForAsset:(PHAsset *)asset resultHandler:(void (^)(UIImage * _Nonnull, NSDictionary * _Nonnull))resultHandler {
    if(!self.imageManager) {
        self.imageManager = [PHCachingImageManager new];
    }
    
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.resizeMode = PHImageRequestOptionsResizeModeFast;
    option.networkAccessAllowed = YES;
    option.synchronous = YES;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{        
        [self.imageManager requestImageForAsset:asset
                                     targetSize:self.assetSize
                                    contentMode:self.mode
                                        options:option
                                  resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            dispatch_async(dispatch_get_main_queue(), ^{
                !resultHandler ? : resultHandler(result,info);                
            });
        }];
    });
}

- (void)requestDataForAsset:(PHAsset *)asset resultHandler:(void (^)(UIImage * _Nonnull, NSDictionary * _Nonnull))resultHandler {
    if(!self.imageManager) {
        self.imageManager = [PHCachingImageManager new];
    }
    
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.resizeMode = PHImageRequestOptionsResizeModeFast;
    option.networkAccessAllowed = YES;
    option.synchronous = YES;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.imageManager requestImageDataForAsset:asset options:option resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
            @autoreleasepool {
                UIImage *image = [UIImage imageWithData:imageData];
                CC_WebImageFormat format = [CC_WebImageCoderHelper imageFormatWithData:imageData];
                image.imageFormat = format;
                dispatch_async(dispatch_get_main_queue(), ^{
                    !resultHandler ? : resultHandler(image,info);
                    
                    // (lldb) po [CC_WebImageCoderHelper imageFormatWithData:imageData]
                    // CC_WebImageFormatGIF
                    // NSLog(@"%@",image);
                });
            }
        }];
    });
}


+ (PHFetchResult<PHAsset *> *)fetchAllPhotosWithOption:(nullable PHFetchOptions *)option {
    if (!option) {
        option = [PHFetchOptions new];
        option.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"creationDate" ascending:NO]];
    }
    return [PHAsset fetchAssetsWithOptions:option];
}

+ (PHFetchResult<PHAsset *> *)fetchRecentAddedPhotosWithOption:(nullable PHFetchOptions *)option {
    if (!option) {
        option = [PHFetchOptions new];
        option.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"creationDate" ascending:NO]];
    }
    PHAssetCollectionType type = PHAssetCollectionTypeSmartAlbum;
    PHAssetCollectionSubtype subtype = PHAssetCollectionSubtypeSmartAlbumRecentlyAdded;
    PHFetchResult<PHAssetCollection *> *_ = [PHAssetCollection fetchAssetCollectionsWithType:type
                                                                                     subtype:subtype
                                                                                     options:nil];
    
    __block PHFetchResult<PHAsset *> *photos = nil;
    
    [_ enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        PHFetchResult<PHAsset *> *assetResult = [PHAsset fetchAssetsInAssetCollection:obj options:nil];
        if (idx == 0) {
            photos = assetResult;
        }
    }];
   return photos;
}

+ (PHFetchResult<PHAsset *> *)fetchFavoritesPhotosWithOption:(nullable PHFetchOptions *)option {
    if (!option) {
        option = [PHFetchOptions new];
        option.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"creationDate" ascending:NO]];
    }
    PHAssetCollectionType type = PHAssetCollectionTypeSmartAlbum;
    PHAssetCollectionSubtype subtype = PHAssetCollectionSubtypeSmartAlbumFavorites;
    PHFetchResult<PHAssetCollection *> *_ = [PHAssetCollection fetchAssetCollectionsWithType:type
                                                                                     subtype:subtype
                                                                                     options:nil];
    
    __block PHFetchResult<PHAsset *> *photos = nil;
    
    [_ enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        PHFetchResult<PHAsset *> * assetResult = [PHAsset fetchAssetsInAssetCollection:obj options:nil];
        if (idx == 0) {
            photos = assetResult;
        }
    }];
    
    return photos;
}

+ (PHFetchResult<PHCollection *> *)fetchUserCollectionsWithOption:(nullable PHFetchOptions *)option {
//    if (!option) {
//        option = [PHFetchOptions new];
//        option.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"creationDate" ascending:NO]];
//    }
    
    return [PHCollectionList fetchTopLevelUserCollectionsWithOptions:option];
}

+ (PHFetchResult<PHAsset *> *)fetchUserCollectionsWithOption:(nullable PHFetchOptions *)option atIndex:(NSInteger)index{
    if (!option) {
        option = [PHFetchOptions new];
        option.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"creationDate" ascending:NO]];
    }
    PHFetchResult<PHCollection *> *_ = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:option];
    
    __block PHFetchResult<PHAsset *> *photos = nil;
    
    [_ enumerateObjectsUsingBlock:^(PHCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (index == idx) {
            PHFetchResult<PHAsset *> *assetResult = [PHAsset fetchAssetsInAssetCollection:(PHAssetCollection *)obj options:nil];
            photos = assetResult;
        }
    }];
    
    return photos;
}

- (void)dealloc {
    [[PHPhotoLibrary sharedPhotoLibrary] unregisterChangeObserver:self];
}

// MARK: - photoLibraryDidChange -
- (void)photoLibraryDidChange:(PHChange *)changeInstance {
    dispatch_sync(dispatch_get_main_queue(), ^{
        !self.photoLibraryDidChangeHandler ? : self.photoLibraryDidChangeHandler(changeInstance);
    });
}

+ (void)canUserPhotoWithCompletionHandler:(void (^)(BOOL granted))handler {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        BOOL enabled = NO;

        PHAuthorizationStatus granted = [PHPhotoLibrary authorizationStatus];
        if (granted == PHAuthorizationStatusNotDetermined) {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) {
                    !handler ? : handler(YES);
                }else {
                    !handler ? : handler(NO);
                }
            }];
        }else {
            if (granted == PHAuthorizationStatusAuthorized) {
                enabled = YES;
            }

            !handler ? : handler(enabled);
        }
    });
}

@end
