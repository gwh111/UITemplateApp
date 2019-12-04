//
//  CatSortSiftView.m
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/16.
//  Copy © 2019 gwh. All s reserved.
//

#define kCatSortSiftHeadCVCell @"CatSortSiftHeadCVCell"
#define kCatSortSiftCVCell @"CatSortSiftCVCell"
#define kCatSortSiftHeadHorizontalCVCell @"CatSortSiftHeadHorizontalCVCell"
#define kCatSortSiftHorizontalCVCell @"CatSortSiftHorizontalCVCell"

#import "CatSortSiftView.h"
#import "UIView+CCWebImage.h"

#pragma mark - TableViewCell
@interface CatSortSiftLeftTVCell : UITableViewCell

+(instancetype)createCatSortSiftLeftTVCellWithTableView:(UITableView*)tableView;
@property (nonatomic, strong) CatSortSiftOutModel* model;

@property (nonatomic, strong) UILabel* titleLb;
@property (nonatomic, strong) UIView* bottomLine;
@end

@implementation CatSortSiftLeftTVCell

+(instancetype)createCatSortSiftLeftTVCellWithTableView:(UITableView *)tableView{
    CatSortSiftLeftTVCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CatSortSiftLeftTVCell"];
    if (!cell) {
        cell = [[CatSortSiftLeftTVCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CatSortSiftLeftTVCell"];
        [cell setupViews];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(void)setupViews{
    self.titleLb = [[UILabel alloc]initWithFrame:CGRectMake(RH(4.0f), 0, RH(92.0f), RH(80.0f))];
    _titleLb.textColor = RGBA(6, 18, 30, 1);
    _titleLb.font = RF(16.0f);
    _titleLb.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLb];
    self.bottomLine = [[UIView alloc]initWithFrame:CGRectMake(RH(36.0f), RH(56.0f), RH(32.0f), RH(2.0f))];
    _bottomLine.backgroundColor = RGBA(6, 18, 30, 1);
    [self addSubview:_bottomLine];
    _bottomLine.hidden = YES;
}

-(void)setModel:(CatSortSiftOutModel *)model{
    _model = model;
    _titleLb.text = model.headTitle;
    if (model.isSelect) {
        _bottomLine.hidden = NO;
    }else{
        _bottomLine.hidden = YES;
    }
}

@end

#pragma mark - CollectionViewCell
@interface CatSortSiftHeadCVCell : UICollectionViewCell

@property (nonatomic, strong) CatSortSiftInModel* model;

@property (nonatomic, strong) UIImageView* imageV;
@property (nonatomic, strong) UIView* leftLine;
@property (nonatomic, strong) UIView* rightLine;
@property (nonatomic, strong) UILabel* titleLb;
@end

@implementation CatSortSiftHeadCVCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, RH(120.0f))];
    [self addSubview:_imageV];
    self.titleLb = [[UILabel alloc]init];
    _titleLb.font = RF(14.0f);
    _titleLb.textColor = RGBA(60, 67, 77, 1);
    [self addSubview:_titleLb];
    self.leftLine = [[UIView alloc]init];
    _leftLine.backgroundColor = RGBA(189, 196, 206, 1);
    [self addSubview:_leftLine];
    self.rightLine = [[UIView alloc]init];
    _rightLine.backgroundColor = RGBA(189, 196, 206, 1);
    [self addSubview:_rightLine];
}

-(void)setModel:(CatSortSiftInModel *)model{
    _model = model;
    _titleLb.text = model.title;
    [_imageV cc_setImageWithURL:[NSURL URLWithString:model.imgUrl]];
    
    CGFloat width = [model.title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:RF(14.0f)} context:nil].size.width;
    if (width >= (self.width-RH(72.0f))) {
        width = self.width-RH(72.0f);
    }
    self.titleLb.frame = CGRectMake(self.width/2.0-width/2.0, _imageV.bottom+RH(20.0f), width, RH(20.0f));
    self.leftLine.frame = CGRectMake(_titleLb.left-RH(36.0f), _imageV.bottom+RH(29.5f), RH(16.0f), RH(1.0f));
    self.rightLine.frame = CGRectMake(_titleLb.right+RH(20.0f), _imageV.bottom+RH(29.5f), RH(16.0f), RH(1.0f));
}
@end

@interface CatSortSiftCVCell : UICollectionViewCell

@property (nonatomic, strong) CatSortSiftInModel* model;

@property (nonatomic, strong) UIImageView* imageV;
@property (nonatomic, strong) UILabel* titleLb;
@end

@implementation CatSortSiftCVCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, RH(60.0f))];
    [self addSubview:_imageV];
    self.titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, _imageV.bottom+RH(10.0f), self.width, RH(30.0f))];
    _titleLb.font = RF(14.0f);
    _titleLb.textAlignment = NSTextAlignmentCenter;
    _titleLb.textColor = RGBA(60, 67, 77, 1);
    [self addSubview:_titleLb];
    //绘制圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_imageV.bounds cornerRadius:RH(2.0f)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = _imageV.bounds;
    maskLayer.path = maskPath.CGPath;
    _imageV.layer.mask = maskLayer;
}

-(void)setModel:(CatSortSiftInModel *)model{
    _model = model;
    _titleLb.text = model.title;
    [_imageV cc_setImageWithURL:[NSURL URLWithString:model.imgUrl]];
}
@end

@interface CatSortSiftHeadHorizontalCVCell : UICollectionViewCell

@property (nonatomic, strong) CatSortSiftOutModel* model;

@property (nonatomic, strong) UILabel* titleLb;
@property (nonatomic, strong) UIView* bottomLine;
@end

@implementation CatSortSiftHeadHorizontalCVCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    self.titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    _titleLb.textColor = RGBA(140, 145, 152, 1);
    _titleLb.font = RF(17.0f);
    _titleLb.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLb];
    self.bottomLine = [[UIView alloc]initWithFrame:CGRectMake(self.width/2.0-RH(6.0f), self.height/2.0+RH(14.0f), RH(12.0f), RH(2.0f))];
    _bottomLine.backgroundColor = RGBA(61, 68, 77, 1);
    [self addSubview:_bottomLine];
    _bottomLine.hidden = YES;
}

-(void)setModel:(CatSortSiftOutModel *)model{
    _model = model;
    _titleLb.text = model.headTitle;
    if (model.isSelect) {
        _bottomLine.hidden = NO;
        _titleLb.textColor = RGBA(6, 18, 30, 1);
    }else{
        _bottomLine.hidden = YES;
        _titleLb.textColor = RGBA(140, 145, 152, 1);
    }
}
@end

@interface CatSortSiftHorizontalCVCell : UICollectionViewCell

@property (nonatomic, strong) CatSortSiftInModel* model;

@property (nonatomic, strong) UIImageView* imageV;
@end

@implementation CatSortSiftHorizontalCVCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}


-(void)setupViews{
    self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [self addSubview:_imageV];
    //绘制圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_imageV.bounds cornerRadius:RH(4.0f)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = _imageV.bounds;
    maskLayer.path = maskPath.CGPath;
    _imageV.layer.mask = maskLayer;
}

-(void)setModel:(CatSortSiftInModel *)model{
    _model = model;
    [_imageV cc_setImageWithURL:[NSURL URLWithString:model.imgUrl]];
}
@end

#pragma mark - SiftView
@interface CatSortSiftView ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSArray* dataArr;
@property (nonatomic, assign) CatSortSiftTheme theme;
@property (nonatomic, assign) NSInteger selectIndex;//当前选中的索引

@property (nonatomic, strong) UILabel* titleLb;
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) UICollectionView* headCollectionView;
@property (nonatomic, strong) UICollectionView* collectionView;
@end

@implementation CatSortSiftView

- (instancetype)initWithFrame:(CGRect)frame title:(nullable NSString *)title dataArr:(NSArray<CatSortSiftOutModel *> *)dataArr theme:(CatSortSiftTheme)theme{
    if (self = [super initWithFrame:frame]) {
        self.title = title;
        self.dataArr = dataArr;
        self.theme = theme;
        self.selectIndex = 0;
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    if (_theme == CatSortSiftThemeVerticality) {
        self.titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, RH(60.0f))];
        _titleLb.backgroundColor = RGBA(255, 255, 255, 1);
        _titleLb.textColor = RGBA(51, 51, 51, 1);
        _titleLb.font = RF(17.0f);
        _titleLb.textAlignment = NSTextAlignmentCenter;
        _titleLb.text = _title;
        [self addSubview:_titleLb];
        //左边的列表
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, RH(60.0f), RH(100.0f), self.height-RH(60.0f)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = RGBA(255, 255, 255, 1);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_tableView];
        //右边的列表
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(_tableView.right, RH(60.0f), self.width-_tableView.width, _tableView.height) collectionViewLayout:layout];
        [_collectionView registerClass:[CatSortSiftHeadCVCell class] forCellWithReuseIdentifier:kCatSortSiftHeadCVCell];
        [_collectionView registerClass:[CatSortSiftCVCell class] forCellWithReuseIdentifier:kCatSortSiftCVCell];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = RGBA(249, 249, 249, 1);
        [self addSubview:_collectionView];
        
        UIView* seperateLine = [[UIView alloc]initWithFrame:CGRectMake(0, _titleLb.bottom, self.width, RH(1.0f))];
        seperateLine.backgroundColor = RGBA(238, 238, 238, 1);
        [self addSubview:seperateLine];
        UIView* seperateLine2 = [[UIView alloc]initWithFrame:CGRectMake(_tableView.right, _tableView.top, RH(1.0f), _tableView.height)];
        seperateLine2.backgroundColor = RGBA(238, 238, 238, 1);
        [self addSubview:seperateLine2];
    }
    else if (_theme == CatSortSiftThemeHorizontal) {
        //头部列表
        UICollectionViewFlowLayout* headLayout = [[UICollectionViewFlowLayout alloc]init];
        headLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.headCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.width, RH(48.0f)) collectionViewLayout:headLayout];
        [_headCollectionView registerClass:[CatSortSiftHeadHorizontalCVCell class] forCellWithReuseIdentifier:kCatSortSiftHeadHorizontalCVCell];
        _headCollectionView.dataSource = self;
        _headCollectionView.delegate = self;
        _headCollectionView.backgroundColor = RGBA(255, 255, 255, 1);
        [self addSubview:_headCollectionView];
        //内容列表
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, _headCollectionView.bottom, self.width, self.height-_headCollectionView.height) collectionViewLayout:layout];
        [_collectionView registerClass:[CatSortSiftHorizontalCVCell class] forCellWithReuseIdentifier:kCatSortSiftHorizontalCVCell];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = RGBA(250, 250, 250, 1);
        [self addSubview:_collectionView];
        
    }
}
-(void)recaculateDataArr:(NSInteger)index{
    for (NSInteger i = 0; i < _dataArr.count; i++) {
        CatSortSiftOutModel* outModel = _dataArr[i];
        if (i == index) {
            outModel.select = YES;
        }else{
            outModel.select = NO;
        }
    }
    
    if (_theme == CatSortSiftThemeVerticality) {
        [_tableView reloadData];
    }else if (_theme == CatSortSiftThemeHorizontal) {
        self.selectIndex = index;
        [_headCollectionView reloadData];
        [_collectionView reloadData];
    }
}
#pragma mark - public
-(void)updateDataArr:(NSArray<CatSortSiftOutModel *> *)dataArr{
    self.dataArr = dataArr;
    [_tableView reloadData];
    [_collectionView reloadData];
}
#pragma mark - delegates
#pragma mark - tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CatSortSiftLeftTVCell* cell = [CatSortSiftLeftTVCell createCatSortSiftLeftTVCellWithTableView:tableView];
    cell.model = _dataArr[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return RH(80.0f);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self recaculateDataArr:indexPath.row];
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
}
#pragma mark - collectionview
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (_theme == CatSortSiftThemeVerticality) {
        return _dataArr.count;
    } else if (_theme == CatSortSiftThemeHorizontal) {
        if (collectionView == _headCollectionView) {
            return _dataArr.count>0?1:0;
        } else {
            return _dataArr.count>0?1:0;
        }
    }
    return 0;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_theme == CatSortSiftThemeVerticality) {
        return [_dataArr[section] inDataArr].count;
    } else if (_theme == CatSortSiftThemeHorizontal) {
        if (collectionView == _headCollectionView) {
            return _dataArr.count;
        } else {
            return [_dataArr[_selectIndex] inDataArr].count;
        }
    }
    return 0;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_theme == CatSortSiftThemeVerticality) {
        if (indexPath.row == 0) {
            return CGSizeMake(collectionView.width-RH(40.0f), RH(160.0f));
        } else {
            return CGSizeMake((collectionView.width-RH(60.0f))/2.0, RH(90.0f));
        }
    }else if (_theme == CatSortSiftThemeHorizontal) {
        if (collectionView == _headCollectionView) {
            return CGSizeMake([_dataArr[indexPath.section] modelWidth], RH(48.0f));
        }else{
            return CGSizeMake((self.width-RH(45.0f))/2.0, RH(172.0f));
        }
    }
    return CGSizeZero;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (_theme == CatSortSiftThemeVerticality) {
        return RH(20.0f);
    }else if (_theme == CatSortSiftThemeHorizontal) {
        if (collectionView == _headCollectionView) {
            return RH(0.0f);
        }else{
            return RH(15.0f);
        }
    }
    return 0.0f;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (_theme == CatSortSiftThemeVerticality) {
        return RH(50.0f);
    }else if (_theme == CatSortSiftThemeHorizontal) {
        if (collectionView == _headCollectionView) {
            return RH(0.0f);
        }else{
            return RH(15.0f);
        }
    }
    return 0.0f;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (_theme == CatSortSiftThemeVerticality) {
        return UIEdgeInsetsMake(RH(32.0f), RH(20.0f), RH(32.0f), RH(20.0f));
    }else if (_theme == CatSortSiftThemeHorizontal) {
        if (collectionView == _headCollectionView) {
            return UIEdgeInsetsMake(0, RH(15.0f), 0, RH(15.0f));
        }else{
            return UIEdgeInsetsMake(RH(20.0f), RH(15.0f), RH(20.0f), RH(15.0f));
        }
    }
    return UIEdgeInsetsZero;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_theme == CatSortSiftThemeVerticality) {
        if (indexPath.row == 0) {
            CatSortSiftHeadCVCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCatSortSiftHeadCVCell forIndexPath:indexPath];
            cell.model = [_dataArr[indexPath.section] inDataArr][indexPath.row];
            return cell;
        }else{
            CatSortSiftCVCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCatSortSiftCVCell forIndexPath:indexPath];
            cell.model = [_dataArr[indexPath.section] inDataArr][indexPath.row];
            return cell;
        }
    }else if (_theme == CatSortSiftThemeHorizontal){
        if (collectionView == _headCollectionView) {
            CatSortSiftHeadHorizontalCVCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCatSortSiftHeadHorizontalCVCell forIndexPath:indexPath];
            cell.model = _dataArr[indexPath.row];
            return cell;
        }else{
            CatSortSiftHorizontalCVCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCatSortSiftHorizontalCVCell forIndexPath:indexPath];
            cell.model = [_dataArr[_selectIndex] inDataArr][indexPath.row] ;
            return cell;
        }
    }
    return nil;
}
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_theme == CatSortSiftThemeVerticality) {
        if (collectionView.isDragging || collectionView.isDecelerating) {
            //若非手动，拒绝联动
            [self recaculateDataArr:indexPath.section];
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.section inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了%ld---%ld", indexPath.section, indexPath.row);
    if (_theme == CatSortSiftThemeVerticality) {
        if (_delegate && [_delegate respondsToSelector:@selector(catSortSiftView:didSelectRowAtSection:index:)]) {
            [_delegate catSortSiftView:self didSelectRowAtSection:indexPath.section index:indexPath.row];
        }
    }else if (_theme == CatSortSiftThemeHorizontal) {
        if (collectionView == _headCollectionView) {
            [self recaculateDataArr:indexPath.row];
            //点击之后进行滚动
            if (indexPath.row == 0) {
                //最左边
                [collectionView setContentOffset:CGPointMake(0, 0) animated:YES];
            }else if (indexPath.row == _dataArr.count-1){
                //最右边
                if (collectionView.contentSize.width>collectionView.width) {
                    [collectionView setContentOffset:CGPointMake(collectionView.contentSize.width - collectionView.width, 0) animated:YES];
                }
            }else{
                NSIndexPath* indexP = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:0];
                [collectionView scrollToItemAtIndexPath:indexP atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
            }
        }else{
            if (_delegate && [_delegate respondsToSelector:@selector(catSortSiftView:didSelectRowAtSection:index:)]) {
                [_delegate catSortSiftView:self didSelectRowAtSection:indexPath.section index:indexPath.row];
            }
        }
    }
}
@end
