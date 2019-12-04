//
//  KKPlayerLabelView.m
//  kk_espw
//
//  Created by hsd on 2019/7/19.
//  Copyright © 2019 david. All rights reserved.
//

#import "CatAttributedAlertLabelModel.h"

@implementation CatAttributedAlertLabelModel

- (UIFont *)labelFont {
    if (!_labelFont) {
        _labelFont = [UIFont fontWithName:@"PingFangSC-Regular" size:10];
    }
    return _labelFont;
}

- (UIColor *)labelColor {
    if (!_labelColor) {
        _labelColor = [UIColor whiteColor];
    }
    return _labelColor;
}

+ (instancetype)createWithBgColor:(UIColor *)bgColor img:(UIImage *)img labelStr:(NSString *)labelStr {
    CatAttributedAlertLabelModel *model = [[CatAttributedAlertLabelModel alloc] init];
    model.bgColor = bgColor;
    model.img = img;
    model.labelString = labelStr;
    return model;
}

@end

@interface CatAttributedAlertLabel ()

@property (strong, nonatomic) IBOutlet UIView *bgView;              ///< 背景视图,无颜色
@property (weak, nonatomic) IBOutlet UIView *contentView;           ///< 内容视图,有颜色
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;    ///< 图标
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;         ///< 显示玩家优势
@property (weak, nonatomic) IBOutlet UIView *springView;            ///< 占位视图,无颜色


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconToLead;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLabelToIcon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLabelToTrail;

@end

@implementation CatAttributedAlertLabel

#pragma mark - set
- (void)setModel:(CatAttributedAlertLabelModel *)model {
    _model = model;
    
    self.contentView.backgroundColor = model.bgColor;
    self.contentLabel.font = model.labelFont;
    self.contentLabel.textColor = model.labelColor;
    self.contentLabel.text = model.labelString;
    self.iconImageView.image = model.img;
    
    // 调整约束
    if (model.img) {
        self.iconWidth.constant = 10;
        self.iconHeight.constant = 10;
        self.iconToLead.constant = self.iconImageToLeft;
        self.contentLabelToIcon.constant = self.labelToIconImage;
        
    } else {
        self.iconWidth.constant = 0;
        self.iconHeight.constant = 0;
        self.iconToLead.constant = 0;
        self.contentLabelToIcon.constant = 2;
    }
}

- (void)setIconImageToLeft:(CGFloat)iconImageToLeft {
    _iconImageToLeft = iconImageToLeft;
    self.iconToLead.constant = iconImageToLeft;
}

- (void)setLabelToIconImage:(CGFloat)labelToIconImage {
    _labelToIconImage = labelToIconImage;
    self.contentLabelToIcon.constant = labelToIconImage;
}

- (void)setLabelToTrail:(CGFloat)labelToTrail {
    _labelToTrail = labelToTrail;
    self.contentLabelToTrail.constant = labelToTrail;
}

#pragma mark - get
- (CGFloat)iconImageWidth {
    return self.iconWidth.constant;
}

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initDefaultData];
        [self loadXib];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initDefaultData];
        [self loadXib];
    }
    return self;
}

#pragma mark - load
- (void)loadXib {
    
    UIView *bgView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
    [self addSubview:bgView];
    
    bgView.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *hTraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[bgView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"bgView": bgView}];
    NSArray *vTraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[bgView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"bgView": bgView}];
    [self addConstraints:hTraint];
    [self addConstraints:vTraint];
    
    self.contentView.layer.cornerRadius = 2;
    self.contentView.layer.masksToBounds = YES;
}

- (void)initDefaultData {
    _iconImageToLeft = 2;
    _labelToIconImage = 2;
    _labelToTrail = 2;
}

@end
