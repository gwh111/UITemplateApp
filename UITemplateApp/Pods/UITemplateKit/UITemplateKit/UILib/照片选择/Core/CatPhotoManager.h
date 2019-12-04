//
//  CatPhotoManager.h
//  UITemplateKit
//
//  Created by ml on 2019/11/4.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CatPhotoKitImp.h"

NS_ASSUME_NONNULL_BEGIN

@class CatAlbumModel;

@interface CatPhotoManager : NSObject {
@public
    CatPhotoKitImp *_imp;
}

@property (nonatomic,strong) PHFetchResult<PHAsset *> *currentPhotos;
@property (nonatomic,strong) NSMutableArray<CatAlbumModel *> *models;

@property (nonatomic,strong,readonly) UITableView *tableView;
@property (nonatomic,strong,readonly) UICollectionView *collectionView;

/// 点击切换相册的回调
@property (nonatomic,copy) void (^didSelectHandler)(NSIndexPath *indexPath,NSString *albumName);

+ (instancetype)manager;

- (void)defaultAlbumConfigure;

@end

extern UIImage *imageFromBundle(NSString *bundleName, NSString *imageSource);

NS_ASSUME_NONNULL_END
