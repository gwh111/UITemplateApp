//
//  CatPhotoManager.m
//  UITemplateKit
//
//  Created by ml on 2019/11/4.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatPhotoManager.h"
#import "ccs.h"

@interface CatAlbumModel : NSObject

@property (nonatomic,strong) UIImage *thumbnail;
@property (nonatomic,copy) NSString *title;

@end

@implementation CatAlbumModel

@end

@interface CatAlbumCell : UITableViewCell

@property (nonatomic,strong) UIImageView *thumbImageView;
@property (nonatomic,strong) UILabel *nameLabel;

@end

@implementation CatAlbumCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _thumbImageView = [UIImageView new];
    _thumbImageView.frame = CGRectMake(RH(13), (76 - 54) * .5, 54, 54);
    _thumbImageView.contentMode = UIViewContentModeScaleAspectFill;
    _thumbImageView.clipsToBounds = YES;
    [self.contentView addSubview:_thumbImageView];
    
    _nameLabel = UILabel.new;
    _nameLabel.font = RF(14);
    _nameLabel.textColor = HEX(333333);
    _nameLabel.frame = CGRectMake(CGRectGetMaxX(_thumbImageView.frame) + RH(23), 0, 0, 0);
    [self.contentView addSubview:_nameLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.clipsToBounds = YES;
}

@end

@interface CatPhotoManager () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) PHFetchResult<PHAsset *> *photos;

@property (nonatomic,strong) PHFetchResult<PHAsset *> *recentAddedPhotos;
@property (nonatomic,strong) PHFetchResult<PHAsset *> *favoritesPhotos;

@property (nonatomic,strong) NSMutableArray *hasPhotoAblums;
@end

@implementation CatPhotoManager

+ (instancetype)manager {
    return [[self alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        _imp               = [[CatPhotoKitImp alloc] init];
        _imp.assetSize     = CGSizeMake(RH(55), RH(55));
        _models            = [NSMutableArray array];
        
        [self reloadPhotoAssets];
        _currentPhotos = _photos.copy;
    }
    return self;
}

- (void)dealloc {
    NSLog(@"%s",__FUNCTION__);
}

- (void)reloadPhotoAssets {
    _photos            = [CatPhotoKitImp fetchAllPhotosWithOption:nil];
    _recentAddedPhotos = [CatPhotoKitImp fetchRecentAddedPhotosWithOption:nil];
    _favoritesPhotos   = [CatPhotoKitImp fetchFavoritesPhotosWithOption:nil];
}

- (void)defaultAlbumConfigure {
    [self reloadPhotoAssets];
    _currentPhotos = _photos.copy;
    NSMutableArray *assetsM = [NSMutableArray array];
    PHAsset *asset = nil;
    if (self.photos.count > 0) {
        asset = self.photos.firstObject;
        [assetsM addObject:asset];
    }
    
    if (self.recentAddedPhotos.count > 0) {
        asset = self.recentAddedPhotos.firstObject;
        [assetsM addObject:asset];
    }
    
    if (self.favoritesPhotos.count > 0) {
        asset = self.favoritesPhotos.firstObject;
        [assetsM addObject:asset];
    }
    
    _hasPhotoAblums = [NSMutableArray array];
    PHFetchResult<PHCollection *> *userCollections = [CatPhotoKitImp fetchUserCollectionsWithOption:nil];
    
    for (int i = 0; i < userCollections.count; ++i) {
        PHCollection *collection = userCollections[i];
        if ([collection isKindOfClass:PHAssetCollection.class]) {
            PHFetchResult<PHAsset *> *assetResult = [PHAsset fetchAssetsInAssetCollection:(PHAssetCollection *)collection options:nil];
            if (assetResult.count > 0) {
                PHAsset *asset = assetResult.firstObject;
                [assetsM addObject:asset];
                [_hasPhotoAblums addObject:@(i)];
            }
        }
    }
    
    for (int i = 0; i < assetsM.count; ++i) {
        WS(weakSelf)
        [self->_imp requestImageForAsset:assetsM[i] resultHandler:^(UIImage * _Nonnull result, NSDictionary * _Nonnull info) {
            SS(strongSelf)
            CatAlbumModel *model = [CatAlbumModel new];
            model.thumbnail = result;
            if (i == 0) {
                model.title = [NSString stringWithFormat:@"所有照片(%lu)",(unsigned long)self.photos.count];
            }else if (i == 1) {
                model.title = [NSString stringWithFormat:@"最近添加(%lu)",(unsigned long)self.recentAddedPhotos.count];;
            }else if (i == 2) {
                model.title = [NSString stringWithFormat:@"我的收藏(%lu)",(unsigned long)self.favoritesPhotos.count];
            }else {
                int index = [[strongSelf.hasPhotoAblums objectAtIndex:i-3] intValue];
                PHCollection *collection = userCollections[index];
                
                PHFetchResult<PHAsset *> *assetResult =  [PHAsset fetchAssetsInAssetCollection:(PHAssetCollection *)collection options:nil];
                model.title = [NSString stringWithFormat:@"%@(%lu)",collection.localizedTitle,(unsigned long)assetResult.count];
            }
            [strongSelf.models addObject:model];
        }];
    }
    
    self->_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(), 0) style:UITableViewStylePlain];
    self->_tableView.dataSource = self;
    self->_tableView.delegate = self;
    self->_tableView.rowHeight = 76;
    if (assetsM.count > 5) {
        self->_tableView.height = 380;
    }else {
        self->_tableView.height = assetsM.count * 76;
    }
    self->_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self->_tableView registerClass:CatAlbumCell.class forCellReuseIdentifier:NSStringFromClass(CatAlbumCell.class)];
    [self->_tableView reloadData];
}

// MARK: - UITableView -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CatAlbumModel *model = _models[indexPath.row];
    CatAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CatAlbumCell.class)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.thumbImageView.image = model.thumbnail;
    cell.nameLabel.text = model.title;
    [cell.nameLabel sizeToFit];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(CatAlbumCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.nameLabel.centerY = cell.contentView.centerY;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = @"所有照片";
    if (indexPath.row == 0) {
        _currentPhotos = _photos.copy;
    }else if (indexPath.row == 1) {
        _currentPhotos = _recentAddedPhotos.copy;
        title = @"最近添加";
    }else if (indexPath.row == 2) {
        _currentPhotos = _favoritesPhotos.copy;
        title = @"我的收藏";
    }else {
        int index = [self.hasPhotoAblums[indexPath.row - 3] intValue];
        _currentPhotos = [CatPhotoKitImp fetchUserCollectionsWithOption:nil atIndex:index];
        PHFetchResult<PHCollection *> *userCollections = [CatPhotoKitImp fetchUserCollectionsWithOption:nil];
        PHCollection *collection = userCollections[index];
        title = collection.localizedTitle;
    }
    
    !self.didSelectHandler ? : self.didSelectHandler(indexPath,title);
}

@end

UIImage *imageFromBundle(NSString *bundleName, NSString *imageSource) {
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"];
    NSString *imagePath = [resourcePath stringByAppendingPathComponent:imageSource];
    if (UIScreen.mainScreen.scale > 2) {
        imagePath = [[resourcePath stringByAppendingPathComponent:imageSource] stringByAppendingFormat:@"@3x.png"];
    }else if (UIScreen.mainScreen.scale > 1) {
        imagePath = [[resourcePath stringByAppendingPathComponent:imageSource] stringByAppendingFormat:@"@2x.png"];
    }
    
    return [UIImage imageWithContentsOfFile:imagePath];
}
