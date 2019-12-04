//
//  CatSortSiftPopView.m
//  Doctor
//
//  Created by 路飞 on 2019/6/13.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CatSortSiftPopView.h"

@interface CatSortSiftPopLeftTVCell : UITableViewCell

@property (nonatomic, strong) UIImageView* selectImgV;
@property (nonatomic, strong) UILabel* titleLb;

@property (nonatomic, assign) BOOL isSelect;

+ (instancetype)createCatSortSiftPopLeftTVCellWithTableView:(UITableView*)tableView;

@end

@implementation CatSortSiftPopLeftTVCell
+ (instancetype)createCatSortSiftPopLeftTVCellWithTableView:(UITableView *)tableView{
    CatSortSiftPopLeftTVCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CatSortSiftPopLeftTVCell"];
    if (!cell) {
        cell = [[CatSortSiftPopLeftTVCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CatSortSiftPopLeftTVCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setupViews];
    }
    return cell;
}
-(void)setupViews{
    self.selectImgV = [[UIImageView alloc]initWithFrame:CGRectMake(RH(10.0f), RH(21.0f), RH(8.0f), RH(12.0f))];
    [self addSubview:_selectImgV];
    _selectImgV.hidden = YES;
    
    self.titleLb = [[UILabel alloc]initWithFrame:CGRectMake(_selectImgV.right+RH(8.0f), 0, RH(100.0f), RH(54.0f))];
    _titleLb.textColor = RGBA(51, 51, 51, 1);
    _titleLb.font = RF(15.0f);
    [self addSubview:_titleLb];
}
-(void)setIsSelect:(BOOL)isSelect{
    _isSelect = isSelect;
    if (isSelect) {
        self.backgroundColor = UIColor.whiteColor;
        self.selectImgV.hidden = NO;
    }else{
        self.backgroundColor = RGBA(245, 245, 245, 1);
        self.selectImgV.hidden = YES;
    }
}
@end

@interface CatSortSiftPopRightTVCell : UITableViewCell

@property (nonatomic, strong) UIImageView* selectImgV;
@property (nonatomic, strong) UILabel* titleLb;

/// 默认选中颜色
@property (nonatomic,strong) UIColor *defaultSelectedTextColor;
/// 默认选中背景色
@property (nonatomic,strong) UIColor *defaultSelectedBackgroundColor;

@property (nonatomic, assign) BOOL isSelect;

+ (instancetype)createCatSortSiftPopRightTVCellWithTableView:(UITableView*)tableView;

@end

@implementation CatSortSiftPopRightTVCell
+ (instancetype)createCatSortSiftPopRightTVCellWithTableView:(UITableView *)tableView{
    CatSortSiftPopRightTVCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CatSortSiftPopRightTVCell"];
    if (!cell) {
        cell = [[CatSortSiftPopRightTVCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CatSortSiftPopRightTVCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setupViews];
    }
    return cell;
}
-(void)setupViews{
    
    self.titleLb = [[UILabel alloc]initWithFrame:CGRectMake(RH(26.0f), 0, WIDTH()-RH(154.0f), RH(54.0f))];
    _titleLb.textColor = RGBA(51, 51, 51, 1);
    _titleLb.font = RF(15.0f);
    [self addSubview:_titleLb];
    
    self.selectImgV = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH()-RH(168.0f), RH(20.0f), RH(18.0f), RH(12.0f))];
    [self addSubview:_selectImgV];
    _selectImgV.hidden = YES;
}
-(void)setIsSelect:(BOOL)isSelect{
    _isSelect = isSelect;
    if (isSelect) {
        self.titleLb.textColor = self.defaultSelectedTextColor ? : RGBA(57, 161, 253, 1);
        self.backgroundColor = self.defaultSelectedBackgroundColor ? : RGBA(248, 252, 255, 1);
        self.selectImgV.hidden = NO;
    }else{
        self.titleLb.textColor = RGBA(51, 51, 51, 1);
        self.backgroundColor = UIColor.whiteColor;
        self.selectImgV.hidden = YES;
    }
}
@end

@interface CatSortSiftPopView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) UIImage* leftSelectImage;
@property (nonatomic, strong) UIImage* rightSelectImage;
@property (nonatomic, assign) NSInteger leftSelectIndex;
@property (nonatomic, assign) NSInteger rightSelectIndex;
@property (nonatomic, strong) NSMutableArray* array;

@property (nonatomic, strong) UILabel* titleLb;
@property (nonatomic, strong) UITableView* leftTableV;
@property (nonatomic, strong) UITableView* rightTableV;

@end

@implementation CatSortSiftPopView

- (instancetype)initWithTitle:(NSString*)title leftSelectImage:(UIImage*)leftSelectImage rightSelectImage:(UIImage*)rightSelectImage leftSelectIndex:(NSInteger)leftSelectIndex rightSelectIndex:(NSInteger)rightSelectIndex array:(NSArray*)array height:(CGFloat)height {
    if (self = [super init]) {
        self.title = title;
        self.leftSelectImage = leftSelectImage;
        self.rightSelectImage = rightSelectImage;
        self.leftSelectIndex = leftSelectIndex;
        self.rightSelectIndex = rightSelectIndex;
        self.array=@[].mutableCopy;
        [self.array addObjectsFromArray:array];
        
        [self baseConfig];
        self.frame = CGRectMake(0, 0, WIDTH(), height);
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title leftSelectImage:(UIImage *)leftSelectImage rightSelectImage:(UIImage *)rightSelectImage leftSelectIndex:(NSInteger)leftSelectIndex rightSelectIndex:(NSInteger)rightSelectIndex array:(NSArray *)array{
    if (self = [super init]) {
        self.title = title;
        self.leftSelectImage = leftSelectImage;
        self.rightSelectImage = rightSelectImage;
        self.leftSelectIndex = leftSelectIndex;
        self.rightSelectIndex = rightSelectIndex;
        self.array=@[].mutableCopy;
        [self.array addObjectsFromArray:array];
        
        [self baseConfig];
        self.frame = CGRectMake(0, HEIGHT(), WIDTH(), kCatSortSiftPopViewHeight);
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    self.backgroundColor = [UIColor whiteColor];    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(RH(16.0f), RH(16.0f))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
    self.titleLb = [[UILabel alloc]initWithFrame:CGRectMake(RH(16.0f), 0, self.width-RH(16.0f), RH(50.0f))];
    _titleLb.textColor = RGBA(51, 51, 51, 1);
    _titleLb.font = RF(16.0f);
    _titleLb.text = _title;
    [self addSubview:_titleLb];
    
    self.leftTableV = [[UITableView alloc]initWithFrame:CGRectMake(0, _titleLb.bottom, RH(128.0f), kCatSortSiftPopViewHeight-_titleLb.bottom)];
    _leftTableV.delegate = self;
    _leftTableV.dataSource = self;
    _leftTableV.separatorStyle = UITableViewCellSelectionStyleNone;
    [self addSubview:_leftTableV];
    
    self.rightTableV = [[UITableView alloc]initWithFrame:CGRectMake(_leftTableV.right, _titleLb.bottom, self.width-RH(128.0f), kCatSortSiftPopViewHeight-_titleLb.bottom)];
    _rightTableV.delegate = self;
    _rightTableV.dataSource = self;
    _rightTableV.separatorStyle = UITableViewCellSelectionStyleNone;
    [self addSubview:_rightTableV];
}

-(void)baseConfig{
    
}

-(void)updateLeftSelectIndex:(NSInteger)leftSelectIndex rightSelectIndex:(NSInteger)rightSelectIndex rightArr:(NSArray *)rightArr{
    if (_array.count>leftSelectIndex) {
        self.leftSelectIndex=leftSelectIndex;
        self.rightSelectIndex=rightSelectIndex;
        
        NSMutableDictionary*rightDic=[_array[_leftSelectIndex] mutableCopy];
        [rightDic setObject:rightArr forKey:@"array"];
        [_array replaceObjectAtIndex:_leftSelectIndex withObject:rightDic];
        [self.rightTableV reloadData];
    }
}
#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _leftTableV) {
        return _array.count;
    }else{
        if (_array.count==0) {
            return 0;
        }
        return [[_array[_leftSelectIndex]objectForKey:@"array"] count];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _leftTableV) {
        CatSortSiftPopLeftTVCell* cell = [CatSortSiftPopLeftTVCell createCatSortSiftPopLeftTVCellWithTableView:tableView];
        cell.titleLb.text = [_array[indexPath.row] objectForKey:@"name"];
        cell.selectImgV.image = _leftSelectImage;
        cell.isSelect = (indexPath.row==_leftSelectIndex);
        return cell;
    }else{
        CatSortSiftPopRightTVCell* cell = [CatSortSiftPopRightTVCell createCatSortSiftPopRightTVCellWithTableView:tableView];
        cell.titleLb.text = [_array[_leftSelectIndex] objectForKey:@"array"][indexPath.row];
        cell.selectImgV.image = _rightSelectImage;
        cell.isSelect = (indexPath.row==_rightSelectIndex);
        cell.defaultSelectedTextColor = self.defaultSelectedTextColor;
        cell.defaultSelectedBackgroundColor = self.defaultSelectedBackgroundColor;
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return RH(52.0f);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _leftTableV) {
        self.leftSelectIndex = indexPath.row;
        self.rightSelectIndex = -1;
        if (_delegate && [_delegate respondsToSelector:@selector(catSortSiftPopViewSelect:leftIndex:)]) {
            [_delegate catSortSiftPopViewSelect:self leftIndex:_leftSelectIndex];
        }
    }else{
        self.rightSelectIndex = indexPath.row;
        if (_delegate && [_delegate respondsToSelector:@selector(catSortSiftPopViewSelect:leftIndex:rightIndex:)]) {
            [_delegate catSortSiftPopViewSelect:self leftIndex:_leftSelectIndex rightIndex:_rightSelectIndex];
        }
    }
    [_leftTableV reloadData];
    [_rightTableV reloadData];
    
}

@end
