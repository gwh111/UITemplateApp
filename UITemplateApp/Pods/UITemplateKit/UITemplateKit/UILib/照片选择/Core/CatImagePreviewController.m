//
//  CatImagePreviewController.m
//  UITemplateKit
//
//  Created by ml on 2019/11/6.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatImagePreviewController.h"
#import "CatImagePreviewCollectionCell.h"
#import "ccs.h"
#import "CatPhotoKitImp.h"
#import "CatFakeNavView.h"
#import "CatPhotoManager.h"
#import "CatPhotoAssetModel.h"

@interface CatImagePreviewController () <UICollectionViewDataSource,UICollectionViewDelegate> {
@private
    CatPhotoKitImp *_imp;
}

@property (nonatomic,strong) CatFakeNavView *navView;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) CC_View *contentView;

@property (nonatomic,copy) void (^completion)(UIButton *sender);

@property (nonatomic,strong) PHFetchResult<PHAsset *>* assets;

@end

@implementation CatImagePreviewController

+ (instancetype)controllerWithAssets:(PHFetchResult<PHAsset *>*)assets completion:(void (^)(UIButton *sender))completion {
    CatImagePreviewController *c = [CatImagePreviewController new];
    c.completion = completion;
    c.assets = assets;
    c.currentIndex = 1;
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
    CatFakeNavView *navView = [[CatFakeNavView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(), STATUS_AND_NAV_BAR_HEIGHT)];
    navView.arrowLabel.hidden = YES;
    navView.doneButton.cc_setTitleForState(@"确定",UIControlStateNormal)
    .cc_setTitleColorForState(HEX(FFFFFF),UIControlStateNormal);
    navView.backButton.cc_setImageForState(imageFromBundle(@"CatPickerPhoto", @"preview_nav_back"),UIControlStateNormal);
    navView.titleButton.cc_setTitleColorForState(HEX(FFFFFF),UIControlStateNormal);
    navView.cc_backgroundColor(HEX(333333));
    WS(weakSelf)
    [navView.backButton cc_addTappedOnceDelay:1.0 withBlock:^(CC_Button *btn) {
        SS(strongSelf)
        [strongSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    [navView.doneButton cc_addTappedOnceDelay:0.1 withBlock:^(CC_Button *btn) {
        SS(strongSelf)
        [strongSelf dismissViewControllerAnimated:NO completion:nil];
        !strongSelf.completion ? : strongSelf.completion(navView.doneButton);
    }];
    _navView = navView;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HEX(000000);
    if (CGSizeEqualToSize(CGSizeZero, self.previewSize)) {
        self.previewSize = CGSizeMake(WIDTH(), HEIGHT());
    }
    
    if (self.assets) {
        self->_imp = [CatPhotoKitImp new];
        self->_imp.assetSize = self.previewSize;
    }
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self setupViews];
    
    NSString *title = [NSString stringWithFormat:@"%lu/%lu",self.currentIndex,[self photoCount]];
    _navView.titleButton.cc_setTitleForState(title,UIControlStateNormal);
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:(self.currentIndex - 1) inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

- (void)setupViews {
    self.contentView = ccs.View
    .cc_frame(0,STATUS_AND_NAV_BAR_HEIGHT,WIDTH(),HEIGHT() - STATUS_AND_NAV_BAR_HEIGHT)
    .cc_backgroundColor(UIColor.blackColor)
    .cc_addToView(self.view);
    
    // 1.flowLayout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    // - STATUS_AND_NAV_BAR_HEIGHT - TABBAR_BAR_HEIGHT
    flowLayout.itemSize = CGSizeMake(WIDTH(),HEIGHT() - STATUS_AND_NAV_BAR_HEIGHT - TABBAR_BAR_HEIGHT);

    // 2.创建collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(), HEIGHT() - STATUS_AND_NAV_BAR_HEIGHT - TABBAR_BAR_HEIGHT)
                                                          collectionViewLayout:flowLayout];
    // 2.1 设置
    collectionView.backgroundColor = UIColor.whiteColor;
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.bounces = NO;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [collectionView registerClass:CatImagePreviewCollectionCell.class
       forCellWithReuseIdentifier:NSStringFromClass(self.class)];
    
    if (@available(iOS 11.0, *)) {
        collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.view addSubview:_navView];
    [self.contentView addSubview:_collectionView = collectionView];
}

// MARK: - UICollectionView -
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.assets) {
        return self.assets.count;
    }
    return self.selectedPhotoAssets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CatImagePreviewCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(self.class) forIndexPath:indexPath];
    
    if (self.assets) {
        PHAsset *asset = self.assets[indexPath.item];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self->_imp requestImageForAsset:asset resultHandler:^(UIImage * _Nonnull result, NSDictionary * _Nonnull info) {
                if (result) {
                    cell.img = result;                    
                }
            }];
        });
        
    }else if(self.selectedPhotoAssets){
        CatPhotoAssetModel *model = self.selectedPhotoAssets[indexPath.item];
        cell.img = model.icon;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CatImagePreviewCollectionCell *curCell = (CatImagePreviewCollectionCell *)cell;
    curCell.closeBlock = ^{
        if (self.navView.hidden) {
            [UIView animateWithDuration:.22 animations:^{
                self.navView.alpha = 1.0;
            } completion:^(BOOL finished) {
                self.navView.hidden = NO;
            }];
        }else {
            [UIView animateWithDuration:.22 animations:^{
                self.navView.alpha = 0;
            } completion:^(BOOL finished) {
                self.navView.hidden = YES;
            }];
        }
    };
    [curCell.imageScrollView setZoomScale:1.0 animated:NO];
    [curCell.imageScrollView setNeedsLayout];
    [curCell.imageScrollView layoutIfNeeded];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.currentIndex = (scrollView.contentOffset.x / WIDTH()) + 1;
    NSString *title = [NSString stringWithFormat:@"%lu/%lu",self.currentIndex,[self photoCount]];
    _navView.titleButton.cc_setTitleForState(title,UIControlStateNormal);
    
    if (self.single) {
        PHAsset *asset = self.assets[self.currentIndex - 1];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self->_imp requestImageForAsset:asset resultHandler:^(UIImage * _Nonnull result, NSDictionary * _Nonnull info) {
                if (result) {
                    [self.selectedPhotoAssets removeAllObjects];
                    CatPhotoAssetModel *model = [CatPhotoAssetModel modelWithAsset:asset icon:result];
                    [self.selectedPhotoAssets addObject:model];
                }
            }];
        });
    }
}

- (NSUInteger)photoCount {
    return self.assets ? self.assets.count : self.selectedPhotoAssets.count;
}

@end
