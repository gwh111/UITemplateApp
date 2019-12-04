//
//  CatImagePreviewVC.m
//  CatImagePicker
//
//  Created by david on 2018/12/18.
//  Copyright © 2018 david. All rights reserved.
//

#import "CatImagePreviewVC.h"
//view
//#import "CatCheckmarkView.h"
#import "CatImagePreviewCollectionCell.h"
#import "CC_WebImageManager.h"
//tool
//#import "CatIP_Header.h"
#import "ccs.h"

#define CC_HOME_INDICATOR_HEIGHT (IPHONE_X ? 34.f : 0.f)

static NSString *const cellId = @"CatImagePreviewCollectionCell";

#pragma mark - CatImagePreviewVC
@interface CatImagePreviewVC () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic,weak) UICollectionView *collectionView;
@property (nonatomic,copy) NSArray <UIImage *>*imageArr;
/** 选中图片的个数 */
@property (nonatomic,assign) NSInteger selectCount;
/** 当前图片的index */
@property (nonatomic,assign) NSInteger currentIndex;
/** 索引显示label */
@property (nonatomic, strong) UIPageControl *pageControl;
//@property (nonatomic,strong) UILabel *indexLabel;


@property (nonatomic,copy) NSArray *imageURLs;

@end

@implementation CatImagePreviewVC

#pragma mark  - getter/setter
#pragma mark  lazy load
-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, HEIGHT()-CC_HOME_INDICATOR_HEIGHT-16, WIDTH(), 5)];
        _pageControl.numberOfPages = 1;
        _pageControl.currentPage = 0;
        _pageControl.userInteractionEnabled = NO;
    }
    return _pageControl;
}

#pragma mark  setter
- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    
    //1.改变index
    NSInteger totalCount = self.imageArr.count;
    if (self.imageURLs.count > 0) {
        totalCount = self.imageURLs.count;
    }
    _pageControl.numberOfPages = totalCount;
    _pageControl.currentPage = self.currentIndex;
}

#pragma mark  - life circle
-(instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
    //如果是查看图片,滚动currentIndex对应的cell
    if (self.imageArr.count > 0 || self.imageURLs.count > 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.currentIndex inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }else{
        self.currentIndex = 0;
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark  - statusBar
-(BOOL)shouldAutorotate {
    return NO;
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark  - UI
-(void)setupUI {
    [self setupCollectionView];
    [self setupTopView];
}

/** 设置CollectionView */
-(void)setupCollectionView {
    //1.flowLayout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));

    //2.创建collectionView
    UICollectionView *collectionV = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    self.collectionView = collectionV;
    [self.view addSubview:collectionV];
    
    //2.1 设置
    collectionV.backgroundColor = UIColor.whiteColor;
    collectionV.pagingEnabled = YES;
    collectionV.showsHorizontalScrollIndicator = NO;
    collectionV.bounces = NO;
    collectionV.delegate = self;
    collectionV.dataSource = self;
    [collectionV registerClass:[CatImagePreviewCollectionCell class] forCellWithReuseIdentifier:cellId];
}

/** 设置TopView */
- (void)setupTopView {
    [self.view addSubview:self.pageControl];
}

/** 设置BottomView */
- (void)setupBottomView {
    //1.创建bottomV
    CGFloat bottomViewH = 44 + CC_HOME_INDICATOR_HEIGHT;
    CGFloat bottomViewY = self.view.frame.size.height - bottomViewH;
    UIView *bottomV = [[UIView alloc] initWithFrame:CGRectMake(0, bottomViewY, WIDTH(), bottomViewH)];
    [self.view addSubview:bottomV];
    bottomV.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    bottomV.userInteractionEnabled = YES;
    
}

#pragma mark  - interaction
/** 点击返回按钮 */
- (void)clickBackButton:(UIButton *)sender {
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark  - delegate
#pragma mark  collectionView delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.imageArr.count > 0) {
        return self.imageArr.count;
    }
    
    return self.imageURLs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.item;
    
    //1.获取cell
    CatImagePreviewCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor blackColor];
    if (self.imageArr.count > 0) {
        cell.img = self.imageArr[row];
    }else if (self.imageURLs.count > 0 && self.currentIndex == row){
        cell.imageURL = self.imageURLs[row];
    }
    cell.closeBlock = ^{
        [self clickBackButton:nil];
    };
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CatImagePreviewCollectionCell *curCell = (CatImagePreviewCollectionCell *)cell;
    if (self.imageURLs.count > 0){
        curCell.imageURL = self.imageURLs[indexPath.item];
    }
    [curCell.imageScrollView setZoomScale:1.0 animated:NO];
    [curCell.imageScrollView setNeedsLayout];
    [curCell.imageScrollView layoutIfNeeded];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark  scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = (scrollView.contentOffset.x + scrollView.bounds.size.width * 0.5) / scrollView.bounds.size.width;
    if (index < 0) return;

    self.currentIndex = index;

}


#pragma mark - 仅预览图片
-(void)setPreviewImages:(NSArray<UIImage *> *)imageArr defaultIndex:(NSUInteger)defaultIndex{
    self.imageArr = imageArr;
    self.currentIndex = imageArr.count > defaultIndex ? defaultIndex : 0;
}

- (void)setPreviewImageURLs:(NSArray<NSString *> *)imageURLArr defaultIndex:(NSUInteger)defaultIndex {
    self.imageURLs = imageURLArr;
    self.currentIndex = imageURLArr.count > defaultIndex ? defaultIndex : 0;
    
}

@end
