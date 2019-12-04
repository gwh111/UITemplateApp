//
//  CatPickerPhotoController.m
//  Patient
//
//  Created by ml on 2019/6/14.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatPickerPhotoController.h"
#import "ccs.h"
#import "CatPhotoManager.h"
#import "CatPickerPhotoCell.h"
#import "CatTakePhotoCell.h"
#import "CatImagePreviewVC.h"
#import "CatSideView.h"
#import "CatCameraSystemViewController.h"
#import "CatImagePreviewController.h"
#import "CatPhotoAssetModel.h"

#define CC_HOME_INDICATOR_HEIGHT (IPHONE_X ? 34.f : 0.f)

NSString *const CatPickerPhotoCellString = @"CatPickerPhotoCellString";
NSString *const CatTakePhotoCellString = @"CatTakePhotoCellString";

@interface CatPickerPhotoController () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,assign) BOOL isUseFullImage;

@property (nonatomic,strong) CatPhotoManager *photoManager;

@property (nonatomic,strong) CatCameraSystemViewController *cameraSystemVC;

/// 兼容问题: 若是从预览回来则不要移除原来选择的数据
/// 需要移除有些使用将CatPickerPhotoController作为属性持有
@property (nonatomic,assign) int compatibleValue;

@property (nonatomic,strong) NSMutableArray *selectedPhotoAssets;

@end

@implementation CatPickerPhotoController

// MARK: - Public -

+ (instancetype)controllerWithMode:(CatPickerPhotoMode)mode
                          delegate:(id<CatPickerPhotoControllerDelegate>)delegate {
    
    CatPickerPhotoController *c = [[CatPickerPhotoController alloc] init];
    c.mode = mode;
    c.delegate = delegate;
    c.cornerRadius = 17;
    
    c.selectedPhotoAssets = [NSMutableArray array];
    [c createUI];
    
    return c;
}

- (void)presentFromRootViewController:(UIViewController *)rootViewController {
    if(self.navigationController) {
        self.navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
        [rootViewController presentViewController:self.navigationController animated:YES completion:nil];
    }else {
        UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:self];
        navC.modalPresentationStyle = UIModalPresentationFullScreen;
        [rootViewController presentViewController:navC animated:YES completion:nil];
    }
}

- (void)createUI {
    CGFloat y = HEIGHT() - RH(52) - CC_HOME_INDICATOR_HEIGHT;
    CatPreviewToolView *toolView = [[CatPreviewToolView alloc] initWithFrame:CGRectMake(0, y, WIDTH(), RH(52))];
    toolView.selectOriginImageButton
    .cc_setNormalImage(imageFromBundle(@"CatPickerPhoto", @"common_uncheck"))
    .cc_setSelectedImage(imageFromBundle(@"CatPickerPhoto", @"common_check"))
    .cc_sizeToFit()
    .cc_centerYSuper();
    
    WS(weakSelf)
    [[toolView cc_previewWithBlock:^(CC_Label * label) {
        SS(strongSelf)
        /// 预览照片
        [strongSelf previewWithAction:label];
    }] cc_selectOriginImageWithBlock:^(CC_Button * btn) {
        SS(strongSelf)
        /// 选择原图
        [strongSelf fetchOriginAssetsAction:btn];
    }];
    
    CatFakeNavView *navView = [[CatFakeNavView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(), STATUS_AND_NAV_BAR_HEIGHT)];
        
    [navView.backButton cc_addTappedOnceDelay:1.0 withBlock:^(CC_Button *btn) {
        SS(strongSelf)
        [strongSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [navView.titleButton cc_addTappedOnceDelay:0.1 withBlock:^(CC_Button *btn) {
        SS(strongSelf)
        btn.selected = !btn.selected;
        if (btn.selected) {
            CatSideView *sview = strongSelf.photoManager.tableView.cc_sideView;
            sview.option = CatSideViewBehaviorOptionForceDismiss;
            sview.deltaOffset = CGPointMake(0, STATUS_AND_NAV_BAR_HEIGHT);
            sview.animated = NO;
            sview.radius = self.cornerRadius;
            sview.coverView.top = STATUS_AND_NAV_BAR_HEIGHT;
            sview.coverView.height = HEIGHT() - STATUS_AND_NAV_BAR_HEIGHT;
            sview.parentView = strongSelf.view;
            [sview showWithDirection:CatSideViewDirectionTop];
        }else {
            CatSideView *sview = strongSelf.photoManager.tableView.cc_sideView;
            [sview dismissViewAnimated:NO];
        }
    }];
    
    if (self.mode == CatPickerPhotoModeMultiple) {
        navView.doneButton.hidden = NO;
        [navView.doneButton cc_addTappedOnceDelay:1.0 withBlock:^(CC_Button *btn) {
            SS(strongSelf)
            if (strongSelf.isUseFullImage) {
                NSMutableArray *assetsM = [NSMutableArray arrayWithArray:self.selectedPhotoAssets];
                [self.selectedPhotoAssets removeAllObjects];
                
                CatPhotoKitImp *imp = [[CatPhotoKitImp alloc] init];
                imp.assetSize = PHImageManagerMaximumSize;

                __block int successCount = 0;
                for (int i = 0; i < assetsM.count; ++i) {
                    [[CC_Mask shared] startAtView:UIApplication.sharedApplication.keyWindow];
                    CatPhotoAssetModel *model = assetsM[i];
                    PHAsset *asset = model.asset;
                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
                        [imp requestImageForAsset:asset resultHandler:^(UIImage * _Nonnull result, NSDictionary * _Nonnull info) {
                            [[CC_Mask shared] stop];
                            if (result) {
                                CatPhotoAssetModel *model = [CatPhotoAssetModel modelWithAsset:asset icon:result];
                                [strongSelf.selectedPhotoAssets addObject:model];
                                
                                successCount = successCount + 1;
                                if (successCount == assetsM.count) {
                                    [strongSelf doneAction];
                                }
                            }
                        }];
                    });
                }
            }else {
                [strongSelf doneAction];
            }
        }];
    }else {
        navView.doneButton.hidden = YES;
    }
    
    _senderView = toolView;
    _navView = navView;
    _backButton = navView.backButton;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dismissAction:)
                                                 name:CatSideDisappearNotification
                                               object:nil];
}

// MARK: - Life cycle -

- (instancetype)init {
    if (self = [super init]) {
        self.mode = CatPickerPhotoModeMultiple;
        self.maxCount = 9;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HEX(FFFFFF);
    
    self.photoManager = [CatPhotoManager manager];
    WS(weakSelf)
    self.photoManager.didSelectHandler = ^(NSIndexPath * _Nonnull indexPath, NSString * _Nonnull albumName) {
        SS(strongSelf)
        ((CatFakeNavView *)strongSelf.navView).titleButton.cc_setTitleForState(albumName,UIControlStateNormal);
        [strongSelf.collectionView reloadData];
        [strongSelf.photoManager.tableView.cc_sideView dismissViewAnimated:NO];
    };
    
    self.thumbnailSize  = CGSizeMake(WIDTH() / 4, WIDTH() / 4);
    self.previewSize    = CGSizeMake(WIDTH(), HEIGHT());
    
    [self.view addSubview:_navView];
    if (self.mode == CatPickerPhotoModeMultiple) {
        [self.view addSubview:_senderView];
    }else {
        self.maxCount = 1;
    }
    
    CGFloat height = HEIGHT() - STATUS_AND_NAV_BAR_HEIGHT - RH(52) - CC_HOME_INDICATOR_HEIGHT;
    if (self.mode == CatPickerPhotoModeSingle) {
        height = HEIGHT() - STATUS_AND_NAV_BAR_HEIGHT - CC_HOME_INDICATOR_HEIGHT;
    }
    
    self.photoManager->_imp.assetSize = self.thumbnailSize;
    [CatPhotoKitImp canUserPhotoWithCompletionHandler:^(BOOL granted) {
        if (granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.photoManager defaultAlbumConfigure];
                [self.collectionView reloadData];
            });
        }else {

        }
    }];
    
    CC_CollectionView *c = ccs.CollectionView
    .cc_addToView(self.view)
    .cc_frame(0, STATUS_AND_NAV_BAR_HEIGHT, WIDTH(),height)
    .cc_backgroundColor(UIColor.whiteColor)
    .cc_dataSource(self)
    .cc_delegate(self);
    
    c.cc_flowLayout.itemSize = self.thumbnailSize;
    c.cc_flowLayout.minimumLineSpacing = 0;
    c.cc_flowLayout.minimumInteritemSpacing = 0;
    
    [c registerClass:[CatPickerPhotoCell class] forCellWithReuseIdentifier:CatPickerPhotoCellString];
    [c registerClass:[CatTakePhotoCell class] forCellWithReuseIdentifier:CatTakePhotoCellString];
    
    _collectionView = c;
    
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    /// 不建议的使用方式,用属性持有
    /// 若已经选择了图片 remove && reloadData
    if (self.selectedPhotoAssets.count > 0 && self.compatibleValue == 0) {
        [self.selectedPhotoAssets removeAllObjects];
        [self.collectionView reloadData];
    }
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// MARK: - UICollectionView -
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photoManager.currentPhotos.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 0) {
        CatTakePhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CatTakePhotoCellString forIndexPath:indexPath];
        [cell.takePhotoButton setBackgroundImage:self.takePhotoImage ? : imageFromBundle(@"CatPickerPhoto", @"subsequent_take_photo")
                                        forState:UIControlStateNormal];
        return cell;
    }
    
    PHAsset *asset = self.photoManager.currentPhotos[indexPath.item - 1];
    
    /** if (asset.mediaSubtypes & PHAssetMediaSubtypePhotoLive) {} */
    
    CatPickerPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CatPickerPhotoCellString forIndexPath:indexPath];
    
    [cell.checkButton setImage:self.uncheckImage ? : imageFromBundle(@"CatPickerPhoto", @"common_uncheck")
                      forState:UIControlStateNormal];
    
    [cell.checkButton setImage:self.checkImage ? : imageFromBundle(@"CatPickerPhoto", @"common_check")
                      forState:UIControlStateSelected];
    
    cell.backgroundColor = UIColor.groupTableViewBackgroundColor;
    
    cell.checkButton.tag = indexPath.item;
    if (self.mode == CatPickerPhotoModeMultiple) {
        [cell.checkButton addTarget:self
                             action:@selector(selectedPhotoAction:)
                   forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (self.mode == CatPickerPhotoModeSingle) {
        cell.checkButton.hidden = YES;
    }else {
        cell.checkButton.hidden = NO;
    }
    cell.representedAssetIdentifier = asset.localIdentifier;
    
    if([self.defalutPickerIds containsObject:asset.localIdentifier]) {
        WS(weakSelf)
        [self.photoManager->_imp requestImageForAsset:asset resultHandler:^(UIImage * _Nonnull result, NSDictionary * _Nonnull info) {
            SS(strongSelf)
            if (result) {
                CatPhotoAssetModel *model = [CatPhotoAssetModel modelWithAsset:asset icon:result];
                [strongSelf.selectedPhotoAssets addObject:model];
                
                cell.checkButton.selected = YES;
            }
        }];
    }else {
        if ([self.selectedPhotoAssets indexOfObject:asset] != NSNotFound) {
            cell.checkButton.selected = YES;
        }else {
            cell.checkButton.selected = NO;
        }
        
        [self.photoManager->_imp requestImageForAsset:asset resultHandler:^(UIImage * _Nonnull result, NSDictionary * _Nonnull info) {
            if (result) {
                cell.icon.image = result;
            }
        }];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item > 0) {
        if (self.mode == CatPickerPhotoModeSingle) {
            [self.selectedPhotoAssets removeAllObjects];
            CatPickerPhotoCell *cell = (CatPickerPhotoCell *)[collectionView cellForItemAtIndexPath:indexPath];
            [self selectedPhotoWithCell:cell indexPath:indexPath completion:^{
                [self _previewActionWithIndexPath:indexPath limit:NO];
            }];
        }else {
            [self _previewActionWithIndexPath:indexPath limit:NO];
        }
    }else {
        /// 拍照
        self.cameraSystemVC = [CatCameraSystemViewController controllerWithCompletion:^(UIImage * _Nonnull data) {
            [self dismissViewControllerAnimated:NO completion:nil];
            if ([self.delegate respondsToSelector:@selector(catPickerPhotoController:didFinishPickingWithItems:)]) {
                [self.delegate catPickerPhotoController:self didFinishPickingWithItems:@[data]];
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    
        [self.cameraSystemVC presentCameraPageFromRootViewController:self];
    }
}

/// 选择图片
- (void)selectedPhotoAction:(UIButton *)sender {
    CatPickerPhotoCell *cell = (CatPickerPhotoCell *)sender.superview.superview;
    if ([cell isKindOfClass:CatPickerPhotoCell.class]) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [self selectedPhotoWithCell:cell indexPath:indexPath completion:nil];
    }
}

- (void)selectedPhotoWithCell:(CatPickerPhotoCell *)cell indexPath:(NSIndexPath *)indexPath completion:(void (^)(void))completion{
    BOOL isCheck = cell.checkButton.isSelected == NO ? YES : NO;
    BOOL isMax = NO;
    if (self.selectedPhotoAssets.count == self.maxCount) {
        isMax = YES;
        /// 取消选中
        if (isCheck == NO) {
            isMax = NO;
        }
    }
    if([self.delegate respondsToSelector:@selector(catPickerPhotoController:didSelectItemAtIndexPath:isMax:)]) {
        [self.delegate catPickerPhotoController:self didSelectItemAtIndexPath:indexPath isMax:isMax];
    }
    
    if (isCheck && isMax) { return; }
    
    PHAsset *asset = self.photoManager.currentPhotos[indexPath.item - 1];
    
    if (cell.checkButton.isSelected == NO) {
        /// 加载预览图
        CatPhotoKitImp *imp = [CatPhotoKitImp new];
        imp.assetSize = self.previewSize;
        
        [[CC_Mask shared] startAtView:UIApplication.sharedApplication.keyWindow];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [imp requestImageForAsset:asset resultHandler:^(UIImage * _Nonnull result, NSDictionary * _Nonnull info) {
                [ccs maskStop];
                
                if (result) {
                    cell.checkButton.selected = YES;
                    CatPhotoAssetModel *model = [CatPhotoAssetModel modelWithAsset:asset icon:result];
                    [self.selectedPhotoAssets addObject:model];
                    
                    if (self.selectedPhotoAssets.count > 0) {
                        self.senderView.previewLabel.textColor = HEX(333333);
                    }
                    
                    !completion ? : completion();
                }
            }];
        });
    }else {
        NSUInteger index = NSNotFound;
        for (int i = 0; i < self.selectedPhotoAssets.count; ++i) {
            CatPhotoAssetModel *model = self.selectedPhotoAssets[i];
            if ([model.localIdentifier isEqualToString:asset.localIdentifier]) {
                index = i;
            }
        }
        
        if (index != NSNotFound) {
            [self.selectedPhotoAssets removeObjectAtIndex:index];
        }
        
        cell.checkButton.selected = NO;
        
        if (self.selectedPhotoAssets.count == 0) {
            self.senderView.previewLabel.textColor = HEX(999999);
        }
    }
}

// MARK: - Actios -
- (void)previewWithAction:(UILabel *)sender {
    [self _previewActionWithIndexPath:nil limit:YES];
}

- (void)dismissAction:(NSNotification *)sender {
    CatFakeNavView *view = (CatFakeNavView *)self.navView;
    view.titleButton.selected = NO;
}

- (void)fetchOriginAssetsAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.isUseFullImage = sender.selected;
}

- (void)doneAction {
    if (self.selectedPhotoAssets.count <= 0) { return; }
    
    self.compatibleValue = 0;
    
    NSMutableArray *imagesM = [NSMutableArray array];
    NSMutableArray *idsM = [NSMutableArray array];
    NSMutableArray *assets = [NSMutableArray array];
    [self.selectedPhotoAssets enumerateObjectsUsingBlock:^(CatPhotoAssetModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [assets addObject:obj.asset];
        [imagesM addObject:obj.icon];
        [idsM addObject:obj.localIdentifier];
    }];
    
    if([self.delegate respondsToSelector:@selector(catPickerPhotoController:didFinishPickingWithItems:assets:isSelectOriginPhoto:ids:)]) {
        [self.delegate catPickerPhotoController:self didFinishPickingWithItems:imagesM.copy assets:assets isSelectOriginPhoto:self.isUseFullImage ids:idsM.copy];
    }else {
        if ([self.delegate respondsToSelector:@selector(catPickerPhotoController:didFinishPickingWithItems:)]) {
            [self.delegate catPickerPhotoController:self didFinishPickingWithItems:imagesM.copy];
        }
        
        if([self.delegate respondsToSelector:@selector(catPickerPhotoController:didFinishPickingWithIds:)]) {
            [self.delegate catPickerPhotoController:self didFinishPickingWithIds:idsM];
        }
    }
    
    [self dismissViewControllerAnimated:YES completion:self.dismissCompletion];
}

// MARK: - Internal -
- (void)_previewActionWithIndexPath:(NSIndexPath *)indexPath limit:(BOOL)limit{
    self.compatibleValue = 1;
    
    CatImagePreviewController *vc = [CatImagePreviewController controllerWithAssets:limit ? nil : self.photoManager.currentPhotos completion:^(UIButton * _Nonnull sender) {
        [self doneAction];
    }];
    
    if (indexPath) {
        vc.currentIndex = indexPath.item;
    }    
        
    vc.single = self.mode == CatPickerPhotoModeSingle ? YES : NO;
    vc.selectedPhotoAssets = self.selectedPhotoAssets;
    [vc presentFromRootViewController:self];
    _previewVC = vc;
}

@end

// NSNotificationName const CatPreviewFailureNotification = @"CatPreviewFailureNotification";
