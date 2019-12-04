//
//  CatPagerSegment.m
//  UITemplateLib
//
//  Created by 路飞 on 2019/4/25.
//  Copyright © 2019 gwh. All rights reserved.
//

#define kCatPagerCollectionViewCell @"CatPagerCollectionViewCell"

#import "CatPagerSegment.h"

@implementation CatPagerCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    self.label = [[UILabel alloc]initWithFrame:CGRectZero];
    _label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_label];
    
    self.tagLb = [[UILabel alloc]initWithFrame:CGRectZero];
    _tagLb.textColor = [UIColor whiteColor];
    _tagLb.font = RF(12.0f);
    _tagLb.textAlignment = NSTextAlignmentCenter;
    _tagLb.backgroundColor = RGBA(255, 91, 5, 1);
    [self addSubview:_tagLb];
    
    self.bottomLineView = [[UIView alloc]initWithFrame:CGRectZero];
    [self addSubview:_bottomLineView];
    
}

-(void)setModel:(CatPagerModel *)model{
    _model = model;
    
    CGRect rect = _label.frame;
    rect.size = model.itemSize;
    _label.frame = rect;
    
    _tagLb.frame = [CatPagerTool caculateTagFrameWithModel:model];
    _tagLb.text = model.tagContent;
    if (model.tagType == CatPagerCellTagTypePoint) {
        //绘制圆角
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_tagLb.bounds cornerRadius:RH(4.0f)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.frame = _tagLb.bounds;
        maskLayer.path = maskPath.CGPath;
        _tagLb.layer.mask = maskLayer;
    }else if (model.tagType == CatPagerCellTagTypeContent) {
        //绘制圆角
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_tagLb.bounds cornerRadius:RH(10.0f)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.frame = _tagLb.bounds;
        maskLayer.path = maskPath.CGPath;
        _tagLb.layer.mask = maskLayer;
    }
    
    _label.text = model.itemTitle;
    _label.font = model.itemFont;
    _bottomLineView.backgroundColor = model.bottomLineColor;
    _bottomLineView.hidden = model.isBottomLineHidden;
    
    if (model.isSelected) {
        _label.textColor = model.selectedTextColor;
        _label.backgroundColor = model.selectedBackColor;
        if (model.theme == CatPagerThemeLineZoom) {
            _label.font = model.itemZoomFont;
        }else{
            _label.font = model.itemFont;
        }
        //设置下划线
        if (model.theme == CatPagerThemeLine) {
//            _bottomLineView.hidden = model.isBottomLineHidden;
            _bottomLineView.frame = CGRectMake(0, model.itemSize.height-RH(2.0f), model.itemSize.width, RH(2.0f));
        }else if (model.theme == CatPagerThemeLineZoom) {
//            _bottomLineView.hidden = model.isBottomLineHidden;
            _bottomLineView.frame = CGRectMake((model.itemSize.width-model.bottomLineSize.width)/2.0, model.itemSize.height-RH(2.0f)-RH(10.0f), model.bottomLineSize.width, model.bottomLineSize.height);
            _bottomLineView.layer.cornerRadius = model.bottomLineSize.height/2.0;
            _bottomLineView.layer.masksToBounds = YES;
        }else if (model.theme == CatPagerThemeLineEqual) {
//            _bottomLineView.hidden = model.isBottomLineHidden;
            _bottomLineView.frame = CGRectMake((model.itemSize.width-model.itemWordsWidth)/2.0, model.itemSize.height-RH(2.0f)-RH(10.0f), model.itemWordsWidth, RH(2.0f));
        }else if (model.theme == CatPagerThemeRoundCorner){
//            _bottomLineView.hidden = model.isBottomLineHidden;
            _bottomLineView.frame = CGRectMake((model.itemSize.width-model.bottomLineSize.width)/2.0, model.itemSize.height-model.bottomLineSize.height, model.bottomLineSize.width, model.bottomLineSize.height);
        }else{
            
        }
    }else{
        _label.textColor = model.textColor;
        _label.backgroundColor = model.backColor;
        _label.font = model.itemFont;
        _bottomLineView.hidden = YES;
    }
    
    //针对CatPagerThemeLine 设置label背景透明，不然会有遮挡
    if (model.theme == CatPagerThemeLine || model.theme == CatPagerThemeLineZoom) {
        _label.backgroundColor = [UIColor clearColor];
    }
    [self updateCellShape:model];
}

-(void)updateCellShape:(CatPagerModel*)model{
    switch (model.theme) {
            //矩形
        case CatPagerThemeRect:
            break;
            //圆
        case CatPagerThemeRound:
            self.layer.cornerRadius = model.itemSize.height/2.0;
            self.layer.masksToBounds = YES;
            break;
            //小圆角
        case CatPagerThemeRoundCorner:
            self.layer.cornerRadius = RH(4.0f);
            self.layer.masksToBounds = YES;
            break;
            //整体加圆角
        case CatPagerThemeSegmentRound:
            self.layer.cornerRadius = model.itemSize.height/2.0;
            self.layer.masksToBounds = YES;
            break;
            //下划线+和选中项字体等长
        case CatPagerThemeLine:
            break;
            //下划线+各项下划线等长
        case CatPagerThemeLineEqual:
            break;
            //下划线+选中项字体放大
        case CatPagerThemeLineZoom:
            break;
        default:
            break;
    }
}
@end

@interface CatPagerSegment ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

//背景滑动块---目前无用
@property (nonatomic, strong) UIView* backSlideView;
//底部滑动条---目前无用
@property (nonatomic, strong) UIView* bottomSlideView;
@property (nonatomic, strong) UICollectionView* collectionView;
//字体大小
@property (nonatomic, strong) UIFont* textFont;
//处理过后的item数组
@property (nonatomic, strong) NSArray<CatPagerModel*>* cpModelArr;
@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation CatPagerSegment

-(instancetype)initWithTheme:(CatPagerTheme)theme itemArr:(nonnull NSArray *)itemArr selectedIndex:(NSUInteger)selectedIndex{
    if (self = [super init]) {
        self.theme = theme;
        self.itemArr = itemArr;
        self.selectedIndex = selectedIndex;
        [CatPagerTool caculateCatPagerSegmentMargins:self];
        [CatPagerTool caculateCatPagerSegmentDefaultConfig:self];
        [self setupConfig];
        [self setupViews:selectedIndex];
    }
    return self;
}
//基础配置
-(void)setupConfig{
    self.cpModelArr = [CatPagerTool tranformArrayWithArray:_itemArr theme:_theme selectedIndex:_selectedIndex segment:self];
}
-(void)setupViews:(NSUInteger)selectedIndex{
    self.backgroundColor = RGBA(255, 255, 255, 1);
    if (_cpModelArr.count <= 0) return;
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
    [_collectionView registerClass:[CatPagerCollectionViewCell class] forCellWithReuseIdentifier:kCatPagerCollectionViewCell];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_collectionView];
}

-(void)updateItemArr:(NSArray *)itemArr{
    self.itemArr = itemArr;
    [self setupConfig];
    [self.collectionView reloadData];
}

-(void)updateWidth:(float)width{
//    if (_theme != CatPagerThemeLine) return;//除了CatPagerThemeLine 不作处理
    CGRect rect = self.frame;
    rect.size.width = width;
    rect.origin.x = (WIDTH()-width)/2.0;
    self.frame = rect;
    self.collectionView.frame = self.bounds;
    
    //下面两种情况 item等宽，得重新计算
    if (_theme == CatPagerThemeLine || _theme == CatPagerThemeSegmentRound) {
        //改变布局 左右缩进 然后刷新
        for (CatPagerModel* model in _cpModelArr) {
            CGSize size = model.itemSize;
            model.itemSize = CGSizeMake(self.width/_cpModelArr.count, size.height);
        }
    }
    [self.collectionView reloadData];
}

-(void)updateHeight:(float)height{
//    if (_theme != CatPagerThemeLine) return;//除了CatPagerThemeLine 不作处理
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
    self.collectionView.frame = self.bounds;
    
        for (CatPagerModel* model in _cpModelArr) {
            CGSize tmpSize = model.itemSize;
            if (_theme == CatPagerThemeLine) {
                model.itemSize = CGSizeMake(self.width/_cpModelArr.count, height);
            }else{
                if (_theme == CatPagerThemeRound) {
                    model.itemSize = CGSizeMake(tmpSize.width, height-RH(20));
                }else if (_theme == CatPagerThemeRoundCorner){
                    model.itemSize = CGSizeMake(tmpSize.width, height-RH(24));
                }else if (_theme == CatPagerThemeSegmentRound){
                    model.itemSize = CGSizeMake(tmpSize.width, height-model.padding*2);
                }else{
                    model.itemSize = CGSizeMake(tmpSize.width, height);
                }
            }
        }
    [self.collectionView reloadData];
    if (_theme == CatPagerThemeSegmentRound) {
        self.layer.cornerRadius = height/2.0;
        self.layer.masksToBounds = YES;
    }
}
-(void)updatePadding:(float)padding{
    if (_theme != CatPagerThemeSegmentRound) return;
    for (CatPagerModel* model in _cpModelArr) {
        model.itemSize = CGSizeMake(self.width/_cpModelArr.count-padding*2, model.itemSize.height-padding*2);
    }
    self.padding = padding;
    [self.collectionView reloadData];
}

-(void)updateSelectedTextColor:(UIColor *)selectedTextColor selectedBackColor:(UIColor *)selectedBackColor textColor:(UIColor *)textColor backColor:(UIColor *)backColor bottomLineColor:(UIColor *)bottomLineColor{
        self.selectedTextColor = selectedTextColor;
        self.selectedBackColor = selectedBackColor;
        self.textColor = textColor;
        self.backColor = backColor;
        self.bottomLineColor = bottomLineColor;
    [self setupConfig];
    [self.collectionView reloadData];
}

-(void)updateItemAtIndex:(NSInteger)index tagType:(CatPagerCellTagType)tagType content:(nullable NSString *)content{
    if (index >= _cpModelArr.count || index < 0) return;
    CatPagerModel* model = _cpModelArr[index];
    model.tagType = tagType;
    model.tagContent = content;
    [self.collectionView reloadData];
}

-(void)updateCatPagerThemeLineZoom:(UIFont *)zoomFont{
    if (_theme != CatPagerThemeLineZoom) return;
        self.itemZoomFont = zoomFont;
    [self setupConfig];
    [self.collectionView reloadData];
}

-(void)updateCatPagerThemeLineSize:(CGSize)lineSize{
    if (_theme != CatPagerThemeLineZoom && _theme != CatPagerThemeRoundCorner) return;
        self.bottomLineSize = lineSize;
    [self setupConfig];
    [self.collectionView reloadData];
}

-(void)updateBottomLine:(BOOL)hidden{
    if (_theme != CatPagerThemeLine && _theme != CatPagerThemeLineEqual && _theme != CatPagerThemeLineZoom && _theme != CatPagerThemeRoundCorner) return;
    self.bottomLineHidden = hidden;
    [self setupConfig];
    [self.collectionView reloadData];
}

-(void)updateCatPagerTitleFont:(UIFont *)font{
    self.itemFont=font;
    [self setupConfig];
    [self.collectionView reloadData];
}

-(void)selectItemAtIndex:(NSInteger)index animated:(BOOL)animated{
    [CatPagerTool changeSegmentArrAfterClickOne:_cpModelArr index:index];
    [_collectionView reloadData];
    //点击之后进行滚动
    if (index == 0) {
        //最左边
        [_collectionView setContentOffset:CGPointMake(0, 0) animated:animated];
    }else if (index == _cpModelArr.count-1){
        //最右边
        if (_collectionView.contentSize.width>_collectionView.width) {
            [_collectionView setContentOffset:CGPointMake(_collectionView.contentSize.width - _collectionView.width, 0) animated:animated];
        }
    }else{
        NSIndexPath* indexP = [NSIndexPath indexPathForRow:index+1 inSection:0];
        [_collectionView scrollToItemAtIndexPath:indexP atScrollPosition:UICollectionViewScrollPositionRight animated:animated];
    }
}

#pragma mark -deleagtes
-(NSInteger)numberOfSections{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _cpModelArr.count;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [_cpModelArr[indexPath.row] itemSize];
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (_theme == CatPagerThemeSegmentRound) {
        return _padding*2;
    }else{
        return _interitemSpace;
    }
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (_theme == CatPagerThemeSegmentRound) {
        return _padding*2;
    }else{
        return _interitemSpace;
    }
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (_theme == CatPagerThemeSegmentRound) {
        return UIEdgeInsetsMake(_edges.top, _edges.left+_padding, _edges.bottom, _edges.right+_padding);
    }else{
        return _edges;
    }
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CatPagerCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCatPagerCollectionViewCell forIndexPath:indexPath];
    cell.model = _cpModelArr[indexPath.row];
    if (self.badgeFont) {
        cell.model.badgeFont = self.badgeFont;
        cell.tagLb.font = cell.model.badgeFont;
    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_delegate && [_delegate respondsToSelector:@selector(catPagerSegment:didSelectRowAtIndex:)]) {
        [_delegate catPagerSegment:self didSelectRowAtIndex:indexPath.row];
    }
    [self selectItemAtIndex:indexPath.row animated:YES];
}

@end
