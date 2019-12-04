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

@interface CatImagePreviewController () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) PHFetchResult<PHAsset *> *assets;
@property (nonatomic,copy) NSArray *photos;

@end

@implementation CatImagePreviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.flowLayout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));

    // 2.创建collectionView
    CGRect frame = CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, WIDTH(), HEIGHT() - STATUS_AND_NAV_BAR_HEIGHT - TABBAR_BAR_HEIGHT);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame
                                                          collectionViewLayout:flowLayout];
    [self.view addSubview:collectionView];
    
    // 2.1 设置
    collectionView.backgroundColor = UIColor.whiteColor;
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.bounces = NO;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [collectionView registerClass:CatImagePreviewCollectionCell.class forCellWithReuseIdentifier:NSStringFromClass(self.class)];
}


- (void)browsePhotoWithAssets:(PHFetchResult<PHAsset *> *)assets {
    
}

- (void)browseSelectedPhotoWithImages:(NSArray *)images {
    
}

// MARK: - UICollectionView -
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CatImagePreviewCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(self.class) forIndexPath:indexPath];
    
    return cell;
}

@end
