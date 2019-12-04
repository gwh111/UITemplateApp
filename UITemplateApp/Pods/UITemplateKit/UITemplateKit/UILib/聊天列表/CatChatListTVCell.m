//
//  CatChatListTVCell.m
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/9.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CatChatListTVCell.h"

@interface CatChatListTVCell ()

//未读消息数
@property (nonatomic, strong) UILabel* unReadLb;

@end

@implementation CatChatListTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

+(CatChatListTVCell *)createCatChatListTVCellWithTableView:(UITableView *)tableView{
    CatChatListTVCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CatChatListTVCell"];
    if (!cell) {
        cell = [[CatChatListTVCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CatChatListTVCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        [cell setupViews];
    }
    return cell;
}

-(void)drawRect:(CGRect)rect{
    
}

-(void)setupViews{
    self.iconImgV = [[UIImageView alloc]initWithFrame:CGRectMake(RH(20.0f), RH(12.0f), RH(48.0f), RH(48.0f))];
    [self addSubview:_iconImgV];
    
    self.titleLb = [[UILabel alloc]initWithFrame:CGRectMake(_iconImgV.right+RH(16.0f), RH(4.0f), WIDTH()-RH(140.0f), RH(44.0f))];
    [self addSubview:_titleLb];
    
    self.contentLb = [[UILabel alloc]initWithFrame:CGRectMake(_iconImgV.right+RH(16.0f), _titleLb.bottom-RH(2.0f), WIDTH()-RH(140.0f), RH(14.0f))];
    [self addSubview:_contentLb];
    
    self.timeLb = [[UILabel alloc]initWithFrame:CGRectMake(_titleLb.right, 0, WIDTH()-_titleLb.right, RH(44.0f))];
    _timeLb.font = RF(11.0f);
    _timeLb.textColor = RGBA(192, 192, 192, 1);
    _timeLb.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_timeLb];
    
    self.unReadLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    _unReadLb.backgroundColor = [UIColor colorWithRed:1 green:0.23 blue:0.19 alpha:1];
    // ccRGBA(255, 68, 94, 1);
    _unReadLb.font = RF(11.0f);;
    // _unReadLb.font = RF(10.0f);
    _unReadLb.textColor = [UIColor whiteColor];
    _unReadLb.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_unReadLb];
    
    self.seperateLine = [[UIView alloc]initWithFrame:CGRectMake(RH(14.0f), RH(71.0f), WIDTH()-RH(28.0f), RH(1.0f))];
    _seperateLine.backgroundColor = RGBA(212, 216, 238, 1);
    [self addSubview:_seperateLine];
    
    [self drawCorners:_iconImgV radius:RH(24.0f)];
}

-(void)drawCorners:(UIView*)view radius:(CGFloat)radius{
    //绘制圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:radius];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

-(CGFloat)caculateTime:(NSString*)timeStr{
    CGSize size = [timeStr boundingRectWithSize:CGSizeMake(MAXFLOAT, RH(16.0f)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:RF(11.0f)} context:nil].size;
    return size.width;
}

-(CGSize)caculateUnReadLbSize:(NSString*)string{
    CGSize size = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, RH(16.0f)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:RF(10.0f)} context:nil].size;
    if (size.width <= RH(8.0f)) {
        size.width = 8.0f;
    }
    size.height = RH(16.0f);
    size.width += RH(8.0f);

    return size;
}
#pragma mark - properties
-(void)setUnReadNum:(NSString *)unReadNum{
    _unReadNum = unReadNum;
    _unReadLb.text = unReadNum;
    if (unReadNum.length<=0 || [unReadNum isEqualToString:@"0"]) {
        _unReadLb.hidden = YES;
        _contentLb.frame = CGRectMake(_iconImgV.right+RH(16.0f), _titleLb.bottom-RH(4.0f), WIDTH()-RH(100.0f), RH(14.0f));
    }else{
        _contentLb.frame = CGRectMake(_iconImgV.right+RH(16.0f), _titleLb.bottom-RH(4.0f), WIDTH()-RH(140.0f), RH(14.0f));
        _unReadLb.hidden = NO;
        CGSize size = [self caculateUnReadLbSize:unReadNum];
        _unReadLb.frame = CGRectMake(WIDTH()-size.width-RH(16.0f), _contentLb.top, size.width, size.height);
        [self drawCorners:_unReadLb radius:RH(8.0f)];
    }
}
-(void)setTimeStr:(NSString *)timeStr{
    _timeStr = timeStr;
    self.timeLb.text = timeStr;
    CGFloat width = [self caculateTime:timeStr];
    self.timeLb.frame = CGRectMake(WIDTH()-width-RH(16.0f), 0, width, RH(44.0f));
}
@end
