//
//  CatSpinnerList.m
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/5.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CatSpinnerList.h"

@interface CatSpinnerTableViewCell ()

@property (nonatomic, strong) UILabel* label;
@property (nonatomic, strong) UIImageView* imgV;

@end

@implementation CatSpinnerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

+(instancetype)createCatSpinnerTableViewCellWithTableView:(UITableView *)tableView{
    CatSpinnerTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CatSpinnerTableViewCell"];
    if (!cell) {
        cell = [[CatSpinnerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CatSpinnerTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell initViews];
    }
    return cell;
}
-(void)initViews{
    self.imgV = [[UIImageView alloc]initWithFrame:CGRectMake(RH(20.0f), kCatSpinnerListCellHeight/2.0-RH(10.0f), RH(20.0f), RH(20.0f))];
    [self addSubview:_imgV];
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(RH(52.0f), 0, self.width-RH(72.0f), kCatSpinnerListCellHeight)];
    _label.font = RF(17.0f);
    [self addSubview:_label];
}
-(void)setModel:(CatSpinnerModel *)model{
    _model = model;
    _label.text = model.itemContent;
    _label.textColor = model.textColor;
    self.backgroundColor = model.backColor;
    if (model.itemIconName) {
        _imgV.image = [UIImage imageNamed:model.itemIconName];
        _imgV.hidden = NO;
        _label.frame = CGRectMake(RH(52.0f), 0, model.modelWidth-RH(72.0f), kCatSpinnerListCellHeight);
    }else{
        _imgV.hidden = YES;
        _label.frame = CGRectMake(RH(20.0f), 0, model.modelWidth-RH(40.0f), kCatSpinnerListCellHeight);
    }
}
@end

@interface CatSpinnerList ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) CGFloat maxHeight;
@property (nonatomic, assign) CGPoint originPoint;
@property (nonatomic, strong) NSArray<CatSpinnerModel*>* csModelArr;
@end

@implementation CatSpinnerList

- (instancetype)initWithOriginPoint:(CGPoint)originPoint iconArr:(NSArray<NSString *> *)iconArr itemArr:(NSArray<NSString *> *)itemArr{
    if (self = [super initWithFrame:CGRectMake(0, 0, 1, 1) style:UITableViewStylePlain]) {
        self.iconArr = iconArr;
        self.itemArr = itemArr;
        self.originPoint=originPoint;
        [self setupConfig];
        [self setupViews:originPoint];
    }
    return self;
}

-(void)setupConfig{
    self.csModelArr = [CatSpinnerTool tranformArrayWithArray:_itemArr iconArr:_iconArr catSpinnerList:self];
}

-(void)setupViews:(CGPoint)originPoint{
    CGFloat height = kCatSpinnerListCellHeight*_csModelArr.count;
    if (height>(HEIGHT()-originPoint.y)*0.8) {
        height=(HEIGHT()-originPoint.y)*0.8;
    }
    self.maxHeight=height;
    
    self.frame=CGRectMake(originPoint.x, originPoint.y, _csModelArr[0].modelWidth, height);
    self.delegate = self;
    self.dataSource = self;
    self.bounces = NO;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.layer.cornerRadius=RH(4);
    self.layer.masksToBounds=YES;
}
-(void)drawCorners{
    //绘制圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:RH(5.0f)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _csModelArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CatSpinnerTableViewCell* cell = [CatSpinnerTableViewCell createCatSpinnerTableViewCellWithTableView:tableView];
    cell.model = _csModelArr[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kCatSpinnerListCellHeight;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_cslDelegate && [_cslDelegate respondsToSelector:@selector(catSpinnerList:didSelectRowAtIndex:itemName:)]) {
        [_cslDelegate catSpinnerList:self didSelectRowAtIndex:indexPath.row itemName:[_csModelArr[indexPath.row] itemContent]];
    }
}
#pragma mark - public
-(void)updateWidth:(float)width{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}
-(void)updateTextColor:(UIColor *)textColor backColor:(UIColor *)backColor{
    for (CatSpinnerModel* model in _csModelArr) {
        model.textColor = textColor;
        model.backColor = backColor;
    }
    [self reloadData];
}
-(void)updateItems:(NSArray *)items{
    self.itemArr = items;
    [self setupConfig];
    self.frame = CGRectMake(_originPoint.x, _originPoint.y, _csModelArr[0].modelWidth, _maxHeight);
    [self reloadData];
}
-(void)updateIcons:(nullable NSArray *)icons items:(NSArray *)items{
    self.iconArr = icons;
    self.itemArr = items;
    [self setupConfig];
    self.frame = CGRectMake(_originPoint.x, _originPoint.y, _csModelArr[0].modelWidth, _maxHeight);
    [self reloadData];
}
#pragma mark - properties


@end
