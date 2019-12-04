//
//  CatListCell.m
//  UITemplateLib
//
//  Created by yichen on 2019/5/28.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CatListCell.h"
#import "Masonry.h"
#import "ccs.h"

@interface CatListCell ()
@property (nonatomic, strong)UIImageView *firstIv;
@property (nonatomic, strong)UIImageView *secondIv;
@property (nonatomic, strong)UIImageView *thirdIv;
@property (nonatomic, strong)UIView      *sepLine;

@end
#define bottomBtnWidth 55.f
#define  widthRatio WIDTH() /375.0

@implementation CatListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self loadView];
//        self.imgArr = @[];
    }
    return self;
}

- (void)loadView {
    [self.contentView addSubview:self.headIv];
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.timeLb];
    [self.contentView addSubview:self.titleLb];
    [self.contentView addSubview:self.contentLb];
    [self.contentView addSubview:self.firstIv];
    [self.contentView addSubview:self.secondIv];
    [self.contentView addSubview:self.thirdIv];
    [self.contentView addSubview:self.sharedBtn];
    [self.contentView addSubview:self.commentBtn];
    [self.contentView addSubview:self.likeBtn];
    [self.contentView addSubview:self.sepLine];
    [self layoutSubviewss];

}

-(void)setImgArr:(NSArray *)imgArr {
    _imgArr = imgArr;
    self.firstIv.hidden = self.secondIv.hidden = self.thirdIv.hidden = YES;
    if (_imgArr.count > 0) {
        if (_imgArr.count == 1) {
            self.firstIv.hidden = NO;
            self.secondIv.hidden = self.thirdIv.hidden = YES;
        }else if(_imgArr.count == 2) {
            self.firstIv.hidden = self.secondIv.hidden = NO;
            self.thirdIv.hidden = YES;
        }else{
            self.firstIv.hidden = self.secondIv.hidden = self.thirdIv.hidden = NO;
        }
        [self layoutImageViews];
    }else{
        self.firstIv.hidden = self.secondIv.hidden = self.thirdIv.hidden = YES;
        [_firstIv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLb.mas_bottom);
            make.height.width.mas_equalTo(0.1);
            make.left.equalTo(self.contentView);
        }];
    }
}

-(void)setBottomStyle:(CatCellBottomStyle)bottomStyle {
    _bottomStyle = bottomStyle;
    [self layoutBottomViews];
}

-(void)layoutSubviewss {
    self.headIv.frame = CGRectMake(16, RH(12), RH(35), RH(35));
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headIv.mas_right).offset(8);
        make.top.equalTo(self.headIv).offset(1);
        make.width.mas_lessThanOrEqualTo(200);
        make.height.mas_lessThanOrEqualTo(20);
    }];
    [self.timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.headIv).offset(-1);
        make.left.equalTo(self.nameLb);
        make.width.mas_lessThanOrEqualTo(200);
        make.height.mas_lessThanOrEqualTo(20);
    }];
//    self.nameLb.frame = CGRectMake(61, RH(15), 150, RH(14));
//    self.timeLb.frame = CGRectMake(61, RH(35), 150, RH(12));
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(RH(59));
        make.left.equalTo(self.contentView).offset(17);
        make.right.equalTo(self.contentView).offset(-20);
        make.height.mas_lessThanOrEqualTo(666);
    }];
    [self.contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLb);
        make.top.equalTo(self.titleLb.mas_bottom);
        make.height.mas_lessThanOrEqualTo(666);
    }];
    
    if (self.imgArr.count > 0) {
        [self layoutImageViews];
    }else{
        [_firstIv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLb.mas_bottom);
            make.height.width.mas_equalTo(0.1);
            make.left.equalTo(self.contentView);
        }];
    }
    
    [self layoutBottomViews];
    
}

-(void)layoutImageViews {

    if (self.imageStyle == CatCellImageStyleThreeTypeMode) {
        for (int i = 0; i < self.imgArr.count; i ++) {
            UIImageView *iv = [self viewWithTag:100 + i];
            iv.hidden = NO;
            iv.image = [UIImage imageNamed:self.imgArr[i]];
            [iv mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentLb.mas_bottom).offset(RH(10));
                make.left.equalTo(self.contentView).offset(15 + 117 * i * widthRatio);
                make.height.width.mas_equalTo(111 * widthRatio);
            }];
        }
    }else if (self.imageStyle == CatCellImageStyleNewThreeTypeMode){
        for (int i = 0; i < self.imgArr.count; i ++) {
            UIImageView *iv = [self viewWithTag:100 + i];
            iv.hidden = NO;
            iv.image = [UIImage imageNamed:self.imgArr[i]];
            if (i == 0) {
                [iv mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.contentLb.mas_bottom).offset(RH(10));
                    make.left.equalTo(self.contentView).offset(15);
                    make.height.mas_equalTo(RH(168));
                    make.width.mas_equalTo(RH(238));
                }];
            }else {
                [iv mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.contentLb.mas_bottom).offset(RH(10) + (i - 1) * RH(87));
                    make.left.equalTo(self.contentView).offset(RH(244) + 15);
                    make.height.mas_equalTo(RH(81));
//                    make.width.mas_equalTo(101);
                    make.right.equalTo(self.contentView).offset(-15);
                }];
            }
        }
    }else if (self.imageStyle == CatCellImageStyleListMode){
        //默认列表样式
        for (int i = 0; i < self.imgArr.count; i ++) {
            UIImageView *iv = [self viewWithTag:100 + i];
            iv.hidden = NO;
            iv.image = [UIImage imageNamed:self.imgArr[i]];
            [iv mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentLb.mas_bottom).offset(RH(10));
                make.left.equalTo(self.contentView).offset( 15 + RH(88) * i);
                make.height.width.mas_equalTo(RH(84));
            }];
        }
    }
    
}

-(void)layoutBottomViews {
    _sharedBtn.hidden = _sepLine.hidden = YES;
    if (self.bottomStyle == CatCellStyleBottomTypeRight) {
        _sharedBtn.hidden = _sepLine.hidden = YES;
        [self.likeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.firstIv.mas_bottom).offset(RH(15));
            make.right.equalTo(self.contentView).offset(-15);
            make.bottom.equalTo(self.contentView).offset(-RH(12));
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(bottomBtnWidth);
        }];
        [self.commentBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.likeBtn.mas_left).offset(-5);
            make.top.bottom.equalTo(self.likeBtn);
            make.width.mas_equalTo(bottomBtnWidth);
        }];
    }else if (self.bottomStyle == CatCellStyleBottomTypeCenter){
        _sharedBtn.hidden =  YES;
        _sepLine.hidden = NO;
        [self.likeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.firstIv.mas_bottom).offset(RH(15));
            make.right.equalTo(self.contentView).offset(-75 * widthRatio);
            make.bottom.equalTo(self.contentView).offset(-RH(12));
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(bottomBtnWidth);
        }];
        [self.commentBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.likeBtn);
            make.left.equalTo(self.contentView).offset(75 * widthRatio);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(bottomBtnWidth);
        }];

        [self.sepLine mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.likeBtn).offset(2);
            make.bottom.equalTo(self.likeBtn).offset(-2);
            make.width.mas_equalTo(1);
        }];
    }else if (self.bottomStyle == CatCellStyleBottomTypeCenterContainShared){
        _sharedBtn.hidden = NO;
        _sepLine.hidden = YES;
        [self.likeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.firstIv.mas_bottom).offset(RH(15));
            make.right.equalTo(self.contentView).offset(-28 * widthRatio);
            make.bottom.equalTo(self.contentView).offset(-RH(12));
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(bottomBtnWidth);
        }];
        [self.commentBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.likeBtn);
            make.centerX.equalTo(self.contentView);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(bottomBtnWidth);
        }];
        [self.sharedBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.likeBtn);
            make.left.equalTo(self.contentView).offset(28 * widthRatio);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(bottomBtnWidth);
        }];
    }
}

#pragma mark - clickAction
-(void)headClick{
    if ([_delegate respondsToSelector:@selector(didClickCellContent:withType:withIndexPath:withInfo:)]) {
        [_delegate didClickCellContent:self withType:CatCellContentClickTypeHead withIndexPath:self.index withInfo:-1];
    }
}

-(void)imgDidTapped:(UITapGestureRecognizer *)tap {
    if ([_delegate respondsToSelector:@selector(didClickCellContent:withType:withIndexPath:withInfo:)]) {
        [_delegate didClickCellContent:self withType:CatCellContentClickTypeHead withIndexPath:self.index withInfo:(tap.view.tag - 100)];
    }
}

-(void)btnAction:(UIButton *)sender {
    CatCellContentClickType type;
    if (sender.tag == 1000) {
        type = CatCellContentClickTypeShare;
    }else if (sender.tag == 1001) {
        type = CatCellContentClickTypeComment;
    }else if (sender.tag == 1002) {
        type = CatCellContentClickTypeLike;
    }else{
        type = CatCellContentClickTypeShare;
    }
    if ([_delegate respondsToSelector:@selector(didClickCellContent:withType:withIndexPath:withInfo:)]) {
        [_delegate didClickCellContent:self withType:type withIndexPath:self.index withInfo:-1];
    }
}

#pragma mark - setter/getter
-(UIImageView *)headIv {
    if (!_headIv) {
        _headIv = [[UIImageView alloc]init];
        _headIv.layer.cornerRadius = RH(17.5);
        _headIv.layer.masksToBounds = YES;
        _headIv.backgroundColor = [UIColor grayColor];
        UITapGestureRecognizer *headTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headClick)];
        _headIv.userInteractionEnabled = YES;
        [_headIv addGestureRecognizer:headTap];
    }
    return _headIv;
}

-(UILabel *)nameLb {
    if (!_nameLb) {
        _nameLb = [[UILabel alloc]init];
        _nameLb.font = RF(15);
        _nameLb.textColor = [ccs appStandard:TITLE_COLOR];
        _nameLb.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLb;
}

-(UILabel *)timeLb {
    if (!_timeLb) {
        _timeLb = [[UILabel alloc]init];
        _timeLb.font = RF(11);
        _timeLb.textColor = [ccs appStandard:DATE_COLOR];
        _timeLb.textAlignment = NSTextAlignmentLeft;
    }
    return _timeLb;
}

-(UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]init];
        _titleLb.font = [UIFont fontWithName:@"PingFang-SC-Bold" size:16 * widthRatio];
        _titleLb.numberOfLines = 0;
    }
    return _titleLb;
}

-(UILabel *)contentLb {
    if (!_contentLb) {
        _contentLb = [[UILabel alloc]init];
        _contentLb.font = RF(14);
        _contentLb.textColor = [ccs appStandard:CONTENT_COLOR];
        _contentLb.numberOfLines = 0;
    }
    return _contentLb;
}

-(UIImageView *)firstIv {
    if (!_firstIv) {
        _firstIv = [[UIImageView alloc]init];
        _firstIv.tag = 100;
        _firstIv.backgroundColor = [UIColor grayColor];
        UITapGestureRecognizer *firstTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgDidTapped:)];
        _firstIv.userInteractionEnabled = YES;
        [_firstIv addGestureRecognizer:firstTap];
    }
    return _firstIv;
}

-(UIImageView *)secondIv {
    if (!_secondIv) {
        _secondIv = [[UIImageView alloc]init];
        _secondIv.tag = 101;
        _secondIv.backgroundColor = [UIColor grayColor];
        UITapGestureRecognizer *secondTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgDidTapped:)];
        _secondIv.userInteractionEnabled = YES;
        [_secondIv addGestureRecognizer:secondTap];
    }
    return _secondIv;
}

-(UIImageView *)thirdIv {
    if (!_thirdIv) {
        _thirdIv = [[UIImageView alloc]init];
        _thirdIv.tag = 102;
        _thirdIv.backgroundColor = [UIColor grayColor];
        UITapGestureRecognizer *thirdTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgDidTapped:)];
        _thirdIv.userInteractionEnabled = YES;
        [_thirdIv addGestureRecognizer:thirdTap];
    }
    return _thirdIv;
}

-(YCButton *)sharedBtn {
    if (!_sharedBtn) {
        _sharedBtn = [[YCButton alloc]init];
        _sharedBtn.titleLabel.font = RF(12);
        _sharedBtn.tag = 1000;
        [_sharedBtn setTitle:@"66" forState:UIControlStateNormal];
        [_sharedBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_sharedBtn setImage:[UIImage imageNamed:@"lib_shared"] forState:UIControlStateNormal];
        [_sharedBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sharedBtn;
}

-(YCButton *)commentBtn {
    if (!_commentBtn) {
        _commentBtn = [[YCButton alloc]init];
        _commentBtn.titleLabel.font = RF(12);
        _commentBtn.tag = 1001;
        [_commentBtn setTitle:@"66666" forState:UIControlStateNormal];
        [_commentBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_commentBtn setImage:[UIImage imageNamed:@"lib_comment"] forState:UIControlStateNormal];
        [_commentBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentBtn;
}

-(YCButton *)likeBtn {
    if (!_likeBtn) {
        _likeBtn = [[YCButton alloc]init];
        _likeBtn.titleLabel.font = RF(12);
        _likeBtn.tag = 1002;
        [_likeBtn setTitle:@"66666" forState:UIControlStateNormal];
        [_likeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_likeBtn setImage:[UIImage imageNamed:@"lib_like"] forState:UIControlStateNormal];
        [_likeBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeBtn;
}

-(UIView *)sepLine {
    if (!_sepLine) {
        _sepLine = [[UIView alloc]init];
        _sepLine.backgroundColor = [UIColor grayColor];
    }
    return _sepLine;
}

@end

@implementation YCButton

-(void)layoutSubviews {
    [super layoutSubviews];
    self.imageEdgeInsets = UIEdgeInsetsMake(0, -2, 0, 2);
    //    self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.imageView.width, 0, self.imageView.width);
}

@end
