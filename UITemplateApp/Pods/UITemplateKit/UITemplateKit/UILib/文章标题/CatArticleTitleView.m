//
//  CatArticleTitleView.m
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/20.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatArticleTitleView.h"
#import "UIView+CCWebImage.h"

@interface CatArticleTitleView ()

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* subTitle;
@property (nonatomic, strong) NSArray<UIImage *> * imgTagArr;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* iconUrl;
@property (nonatomic, strong) UIImage* iconPlaceholderImg;
@property (nonatomic, strong) NSString* headImgUrl;
@property (nonatomic, strong) UIImage* headPlaceholderImg;
@property (nonatomic, strong) NSString* time;
@property (nonatomic, assign) BOOL isFocused;
@property (nonatomic, strong) NSString* descriptions;
@property (nonatomic, strong) NSArray<NSString *> * indexTagArr;
@property (nonatomic, assign) CatArticleTitleTheme theme;
@property (nonatomic, copy) PersonBlock personBlock;
@property (nonatomic, copy) FocusBlock focusBlock;
@property (nonatomic, copy) IndexBlock indexBlock;

@property (nonatomic, strong) UILabel* titleLb;
@property (nonatomic, strong) UILabel* subTitleLb;
@property (nonatomic, strong) UILabel* nameLb;
@property (nonatomic, strong) UIImageView* iconImgV;
@property (nonatomic, strong) UILabel* timeLb;
@property (nonatomic, strong) UIImageView* headImgView;
@property (nonatomic, strong) CC_Button* focusBtn;
@property (nonatomic, strong) UILabel* descriptionLb;

@end

@implementation CatArticleTitleView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title subTitle:(nullable NSString *)subTitle imgTagArr:(nullable NSArray<UIImage *> *)imgTagArr name:(nonnull NSString *)name iconUrl:(nullable NSString *)iconUrl iconPlaceholderImg:(nullable UIImage *)iconPlaceholderImg headImgUrl:(nullable NSString *)headImgUrl headPlaceholderImg:(nullable UIImage *)headPlaceholderImg time:(nullable NSString *)time description:(nullable NSString *)description indexTagArr:(nullable NSArray<NSString *> *)indexTagArr theme:(CatArticleTitleTheme)theme isFocused:(BOOL)isFocused personBlock:(nullable PersonBlock)personBlock focusBlock:(nullable FocusBlock)focusBlock indexBlock:(nullable IndexBlock)indexBlock{
    if (self = [super initWithFrame:frame]) {
        self.title = title;
        self.subTitle = subTitle;
        self.imgTagArr = imgTagArr;
        self.name = name;
        self.iconUrl = iconUrl;
        self.iconPlaceholderImg = iconPlaceholderImg;
        self.headImgUrl = headImgUrl;
        self.headPlaceholderImg = headPlaceholderImg;
        self.time = time;
        self.descriptions = description;
        self.indexTagArr = indexTagArr;
        self.theme = theme;
        self.isFocused = isFocused;
        self.personBlock = personBlock;
        self.focusBlock = focusBlock;
        self.indexBlock = indexBlock;
        [self setupConfig];
        [self setupViews];
    }
    return self;
}
- (void)setupConfig{
    WS(weakSelf);
    self.headImgView = [[UIImageView alloc]init];
    [self addSubview:_headImgView];
    self.titleLb = [[UILabel alloc]init];
    _titleLb.numberOfLines = 0;
    _titleLb.font = RF(18.0f);
    _titleLb.textColor = RGBA(6, 18, 30, 1);
    [self addSubview:_titleLb];
    self.nameLb = [[UILabel alloc]init];
    _nameLb.userInteractionEnabled = YES;
    _nameLb.numberOfLines = 0;
    [self addSubview:_nameLb];
    UITapGestureRecognizer* nameTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPerson)];
    [_nameLb addGestureRecognizer:nameTap];
    
    self.iconImgV = [[UIImageView alloc]init];
    _iconImgV.userInteractionEnabled = YES;
    [self addSubview:_iconImgV];
    UITapGestureRecognizer* iconTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPerson)];
    [_iconImgV addGestureRecognizer:iconTap];
    
    self.timeLb = [[UILabel alloc]init];
    _timeLb.font = RF(10.0f);
    _timeLb.textColor = RGBA(140, 145, 152, 1);
    [self addSubview:_timeLb];
    self.subTitleLb = [[UILabel alloc]init];
    _subTitleLb.font = RF(12.0f);
    _subTitleLb.textColor = RGBA(140, 145, 152, 1);
    _subTitleLb.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_subTitleLb];
    self.descriptionLb = [[UILabel alloc]init];
    _descriptionLb.font = RF(11.0f);
    _descriptionLb.textColor = RGBA(140, 145, 152, 1);
    [self addSubview:_descriptionLb];
    
    self.focusBtn = [[CC_Button alloc]init];
    [_focusBtn setTitle:@"＋ 关注" forState:UIControlStateNormal];
    [_focusBtn setTitle:@"已关注" forState:UIControlStateSelected];
    [_focusBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_focusBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    _focusBtn.titleLabel.font = RF(11.0f);
    [_focusBtn cc_tappedInterval:0.1 withBlock:^(id  _Nonnull view) {
        UIButton *button = (UIButton *)view;
        button.selected = !button.isSelected;
        if (button.isSelected) {
            button.backgroundColor = RGBA(153, 153, 153, 1);
        }else{
            button.backgroundColor = RGBA(36, 151, 235, 1);
        }
        SS(strongSelf);
        if (strongSelf.focusBlock) {
            strongSelf.focusBlock(button);
        }
    }];
    [self addSubview:_focusBtn];
    _focusBtn.selected = _isFocused;
    if (_focusBtn.isSelected) {
        _focusBtn.backgroundColor = RGBA(153, 153, 153, 1);
    }else{
        _focusBtn.backgroundColor = RGBA(36, 151, 235, 1);
    }
}
- (void)setupViews{
    self.backgroundColor = [UIColor whiteColor];
    self.titleLb.text = _title;
    switch (_theme) {
            //名字带标签
        case CatArticleTitleThemeMultiplyTag:
        {
            self.titleLb.frame = CGRectMake(RH(16.0f), RH(16.0f), self.width-RH(32.0f), [CatArticleTitleTool caculateTextHeight:_title font:RF(18.0f) width:self.width-RH(32.0f)]);
            self.nameLb.attributedText = [CatArticleTitleTool caculateTitleContent:_name imgTagArr:_imgTagArr font:RF(11.0f) color:RGBA(91, 94, 99, 1)];
            self.nameLb.frame = CGRectMake(RH(16.0f), _titleLb.bottom+RH(10.0f), self.width-RH(32.0f), [CatArticleTitleTool caculateAttributedTextHeight:_nameLb.attributedText width:self.width-RH(32.0f)]);
            [_nameLb sizeToFit];
            
            CGRect rect = self.frame;
            rect.size.height = _nameLb.bottom+RH(16.0f);
            self.frame = rect;
        }
            break;
            //有头部视图、关注
            case CatArticleTitleThemeHeadView:
        {
            self.headImgView.frame = CGRectMake(0, 0, self.width, RH(208.0f));
            [_headImgView cc_setImageWithURL:[NSURL URLWithString:_headImgUrl] placeholderImage:_headPlaceholderImg];
            self.iconImgV.frame = CGRectMake(RH(16.0f), _headImgView.bottom+RH(8.0f), RH(36.0f), RH(36.0f));
            [_iconImgV cc_setImageWithURL:[NSURL URLWithString:_iconUrl] placeholderImage:_iconPlaceholderImg];
            
            CGFloat titleHeight = [CatArticleTitleTool caculateTextHeight:_title font:RF(18.0f) width:self.width-RH(32.0f)];
            self.titleLb.frame = CGRectMake(RH(16.0f), _headImgView.bottom-titleHeight-RH(10.0f), self.width-RH(32.0f), titleHeight);
            _titleLb.textColor = [UIColor whiteColor];
            self.nameLb.frame = CGRectMake(_iconImgV.right+RH(10.0f), _iconImgV.top+RH(4.0f), self.width-RH(122.0f), RH(16.0f));
            _nameLb.text = _name;
            _nameLb.textColor = RGBA(6, 18, 30, 1);
            _nameLb.font = RF(11.0f);
            [_nameLb sizeToFit];
            self.timeLb.frame = CGRectMake(_iconImgV.right+RH(10.0f), _iconImgV.top+RH(20.0f), self.width-RH(122.0f), RH(14.0f));
            _timeLb.text = _time;
            self.focusBtn.frame = CGRectMake(self.width-RH(16.0f+44.0f), _headImgView.bottom+RH(16.0f), RH(44.0f), RH(24.0f));
            [CatArticleTitleTool drawCorners:_focusBtn cornerRadius:RH(2.0f)];
            [CatArticleTitleTool drawCorners:_iconImgV cornerRadius:RH(18.0f)];
            
            CGRect rect = self.frame;
            rect.size.height = RH(260.0f);
            self.frame = rect;
        }
            break;
        //有索引目录
        case CatArticleTitleThemeMultiplyIndex:
        {
            [self setupMultiplyIndex];
            _titleLb.font = RF(22.0f);
            self.titleLb.frame = CGRectMake(RH(16.0f), RH(48.0f), self.width-RH(32.0f), [CatArticleTitleTool caculateTextHeight:_title font:RF(22.0f) width:self.width-RH(32.0f)]);
            
            self.iconImgV.frame = CGRectMake(RH(16.0f), _titleLb.bottom+RH(10.0f), RH(36.0f), RH(36.0f));
            [_iconImgV cc_setImageWithURL:[NSURL URLWithString:_iconUrl] placeholderImage:_iconPlaceholderImg];
            self.nameLb.frame = CGRectMake(_iconImgV.right+RH(10.0f), _iconImgV.top+RH(4.0f), self.width-RH(62.0f), RH(16.0f));
            _nameLb.text = _name;
            _nameLb.textColor = RGBA(6, 18, 30, 1);
            _nameLb.font = RF(11.0f);
            [_nameLb sizeToFit];
            self.timeLb.frame = CGRectMake(_iconImgV.right+RH(10.0f), _iconImgV.top+RH(20.0f), self.width-RH(62.0f), RH(14.0f));
            _timeLb.text = _time;
            [CatArticleTitleTool drawCorners:_iconImgV cornerRadius:RH(18.0f)];
            
            CGRect rect = self.frame;
            rect.size.height = _iconImgV.bottom+RH(16.0f);
            self.frame = rect;
        }
            break;
            //有描述、关注
        case CatArticleTitleThemeDescriptionFocus:
        {
            self.iconImgV.frame = CGRectMake(RH(16.0f), RH(12.0f), RH(36.0f), RH(36.0f));
            [_iconImgV cc_setImageWithURL:[NSURL URLWithString:_iconUrl] placeholderImage:_iconPlaceholderImg];
            
            self.nameLb.frame = CGRectMake(_iconImgV.right+RH(10.0f), _iconImgV.top+RH(4.0f), self.width-RH(142.0f), RH(16.0f));
            _nameLb.text = _name;
            _nameLb.textColor = RGBA(6, 18, 30, 1);
            _nameLb.font = RF(14.0f);
            [_nameLb sizeToFit];
            self.descriptionLb.frame = CGRectMake(_iconImgV.right+RH(10.0f), _iconImgV.top+RH(20.0f), self.width-RH(142.0f), RH(14.0f));
            _descriptionLb.text = _descriptions;
            self.focusBtn.frame = CGRectMake(self.width-RH(16.0f+64.0f), RH(18.0f), RH(64.0f), RH(28.0f));
            [CatArticleTitleTool drawCorners:_focusBtn cornerRadius:RH(14.0f)];
            [CatArticleTitleTool drawCorners:_iconImgV cornerRadius:RH(18.0f)];
            UIView* seperateLine = [[UIView alloc]initWithFrame:CGRectMake(0, _iconImgV.bottom+RH(12.0f), self.width, RH(1.0f))];
            seperateLine.backgroundColor = RGBA(238, 238, 238, 1);
            [self addSubview:seperateLine];
            
            CGFloat titleHeight = [CatArticleTitleTool caculateTextHeight:_title font:RF(18.0f) width:self.width-RH(32.0f)];
            self.titleLb.frame = CGRectMake(RH(16.0f), seperateLine.bottom+RH(16.0f), self.width-RH(32.0f), titleHeight);
            _titleLb.textColor = RGBA(6, 18, 30, 1);
            
            CGRect rect = self.frame;
            rect.size.height = _titleLb.bottom+RH(16.0f);
            self.frame = rect;
        }
            break;
            //有副标题
        case CatArticleTitleThemeSubtitle:
        {
            self.titleLb.textAlignment = NSTextAlignmentCenter;
            self.titleLb.font = RF(22.0f);
            self.titleLb.frame = CGRectMake(RH(16.0f), RH(16.0f), self.width-RH(32.0f), [CatArticleTitleTool caculateTextHeight:_title font:RF(22.0f) width:self.width-RH(32.0f)]);
            self.subTitleLb.frame = CGRectMake(RH(16.0f), _titleLb.bottom+RH(10.0), self.width-RH(32.0f), [CatArticleTitleTool caculateTextHeight:_subTitle font:RF(12.0f) width:self.width-RH(32.0f)]);
            _subTitleLb.text = _subTitle;
            
            UIView* seperateLine = [[UIView alloc]initWithFrame:CGRectMake(self.width/2.0-RH(6.0f), _subTitleLb.bottom+RH(20.0f), RH(12.0f), RH(2.0f))];
            seperateLine.backgroundColor = RGBA(6, 18, 30, 1);
            [self addSubview:seperateLine];
            
            CGFloat nameWidth = [CatArticleTitleTool caculateTextWidth:[NSString stringWithFormat:@"by %@", _name] font:RF(11.0f) height:RH(16.0f)];
            self.iconImgV.frame = CGRectMake((self.width-RH(20.0f+6.0f)-nameWidth)/2.0, _subTitleLb.bottom+RH(40.0f), RH(20.0f), RH(20.0f));
            [_iconImgV cc_setImageWithURL:[NSURL URLWithString:_iconUrl] placeholderImage:_iconPlaceholderImg];
            
            self.nameLb.text = [NSString stringWithFormat:@"by %@", _name];
            _nameLb.textColor = RGBA(140, 145, 152, 1);
            _nameLb.font = RF(11.0f);
            self.nameLb.frame = CGRectMake(_iconImgV.right+RH(6.0f), _iconImgV.top+RH(2.0f), nameWidth, RH(16.0f));
            
            [CatArticleTitleTool drawCorners:_iconImgV cornerRadius:RH(10.0f)];
            CGRect rect = self.frame;
            rect.size.height = _iconImgV.bottom+RH(16.0f);
            self.frame = rect;
        }
            break;
            //普通的
        case CatArticleTitleThemeNormal:
        {
            self.titleLb.frame = CGRectMake(RH(16.0f), RH(16.0f), self.width-RH(32.0f), [CatArticleTitleTool caculateTextHeight:_title font:RF(18.0f) width:self.width-RH(32.0f)]);
            self.iconImgV.frame = CGRectMake(RH(16.0f), _titleLb.bottom+RH(16.0f), RH(20.0f), RH(20.0f));
            [_iconImgV cc_setImageWithURL:[NSURL URLWithString:_iconUrl] placeholderImage:_iconPlaceholderImg];
            self.nameLb.frame = CGRectMake(_iconImgV.right+RH(6.0f), _iconImgV.top+RH(4.0f), self.width, RH(16.0f));
            _nameLb.textColor = RGBA(91, 94, 99, 1);
            _nameLb.font = RF(11.0f);
            _nameLb.text = _name;
            [_nameLb sizeToFit];
            
            self.timeLb.frame = CGRectMake(self.width/2.0, _nameLb.top, self.width/2.0-RH(16.0f), RH(16.0f));
            _timeLb.textAlignment = NSTextAlignmentRight;
            _timeLb.text = _time;
            
            [CatArticleTitleTool drawCorners:_iconImgV cornerRadius:RH(10.0f)];
            CGRect rect = self.frame;
            rect.size.height = _iconImgV.bottom+RH(16.0f);
            self.frame = rect;
        }
            break;
        default:
            break;
    }
}

//创建头部tagView
-(void)setupMultiplyIndex{
    WS(weakSelf);
    UIScrollView* scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(RH(16.0f), RH(16.0f), self.width-RH(32.0f), RH(24.0f))];
    [self addSubview:scrollV];
    CGFloat originX = 0.0f;
    CGFloat originY = 0.0f;
    CGFloat margin = RH(10.0f);
    for (int i = 0; i < _indexTagArr.count; i++) {
        NSString* tag = _indexTagArr[i];
        CGFloat tagWidth = [CatArticleTitleTool caculateTextWidth:[NSString stringWithFormat:@"%@ >", tag] font:RF(11.0f) height:RH(24.0f)];
        CC_Button* btn = [[CC_Button alloc]initWithFrame:CGRectMake(originX, originY, tagWidth+RH(16.0f), RH(24.0f))];
        [btn setTitle:[NSString stringWithFormat:@"%@ >", tag] forState:UIControlStateNormal];
        [btn setTitleColor:RGBA(6, 18, 30, 1) forState:UIControlStateNormal];
        btn.backgroundColor = RGBA(238, 238, 238, 1);
        btn.titleLabel.font = RF(11.0f);
        btn.tag = 100+i;
        [btn cc_tappedInterval:0.1 withBlock:^(id  _Nonnull view) {
            SS(strongSelf);
            UIButton *button = (UIButton *)view;
            if (strongSelf.indexBlock) {
                strongSelf.indexBlock(strongSelf.indexTagArr[button.tag-100], button.tag-100);
            }
        }];
        [scrollV addSubview:btn];
        
        btn.layer.cornerRadius = RH(12.0f);
        btn.layer.borderWidth = 0.5f;
        btn.layer.borderColor = RGBA(6, 18, 30, 1).CGColor;
        btn.layer.masksToBounds = YES;
        
        originX += tagWidth+RH(16.0f)+margin;
    }
    scrollV.contentSize = CGSizeMake(originY, RH(24.0f));
}

-(void)tapPerson{
    if (_personBlock) {
        _personBlock(_title);
    }
}
@end
