//
//  KKPlayerGameCardView.m
//  kk_espw
//
//  Created by hsd on 2019/7/23.
//  Copyright © 2019 david. All rights reserved.
//

#import "CatAttributedAlert.h"

@interface CatAttributedAlert ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong, nonnull) UIView *contentView;             ///< 白底视图

@property (weak, nonatomic) IBOutlet UIButton *leftUpBtn;              ///< 左上角按钮
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;               ///< 右上角按钮
@property (weak, nonatomic) IBOutlet UIImageView *playerIconImageView;  ///< 头像
@property (weak, nonatomic) IBOutlet UILabel *playerNickLabel;          ///< 昵称
@property (weak, nonatomic) IBOutlet UILabel *gameNameLabel;            ///< 玩的游戏名称
@property (weak, nonatomic) IBOutlet UILabel *gameNumbersLabel;         ///< 游戏局数
@property (weak, nonatomic) IBOutlet UILabel *gameTogetherLabel;        ///< 组队
@property (weak, nonatomic) IBOutlet UILabel *gameTogetherNumbersLabel; ///< 组队次数
@property (weak, nonatomic) IBOutlet UILabel *feelGoodNumbersLabel;     ///< 好评次数

@property (weak, nonatomic) IBOutlet UIView *playerLabelSuperView;      ///< 玩家标签父视图

@property (weak, nonatomic) IBOutlet UIButton *addFriendBtn;           ///< 加好友
@property (weak, nonatomic) IBOutlet UIButton *removeGameRoomBtn;      ///< 移除开黑房

@property (weak, nonatomic) IBOutlet UIView *verticalLineView;
@property (weak, nonatomic) IBOutlet UIView *horizontalLineView1;
@property (weak, nonatomic) IBOutlet UIView *horizontalLineView2;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addFriendBtnHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *removeGameRoomBtnHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *removeGameRoomBtnToBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addFriendToRemoveGameRoomBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playerLabelSuperViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playerLabelSuperViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playerLabelSuperViewToPlayerNicker;


@property (nonatomic, assign) CatAttributedAlertButtonType   btnType;       ///< 按钮类型
@property (nonatomic, copy, nullable) NSArray<CatAttributedAlertLabel *> *labelViewArray; ///< 玩家标签列表

@end

@implementation CatAttributedAlert

#pragma mark - set
- (void)setLeftUpTitleColor:(UIColor *)leftUpTitleColor {
    _leftUpTitleColor = leftUpTitleColor;
    [self.leftUpBtn setTitleColor:leftUpTitleColor forState:UIControlStateNormal];
}

- (void)setGameNumbersColor:(UIColor *)gameNumbersColor {
    _gameNumbersColor = gameNumbersColor;
}

- (void)setNickTitle:(NSString *)title {
    self.playerNickLabel.text = title;
}

- (void)setLeftUpBtnTitle:(NSString *)title {
    [self.leftUpBtn setTitle:title forState:UIControlStateNormal];
}

- (void)setGameNameTitle:(NSString *)title {
    self.gameNameLabel.text = title;
}

- (void)setGameNumbersTitle:(NSString *)numbersStr unitTitle:(NSString *)unitStr {
    
    if (!unitStr) {
        unitStr = @"局";
    }
    
    unitStr = [@" " stringByAppendingString:unitStr];
    NSString *allStr = [numbersStr stringByAppendingString:unitStr];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:allStr];
    UIColor *attriColor = self.gameNumbersColor;
    if (!attriColor) {
        attriColor =  [UIColor colorWithRed:236/255.0 green:193/255.0 blue:101/255.0 alpha:1.0];
    }
    
    NSDictionary *attriDic = @{
                            NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Semibold" size:15],
                            NSForegroundColorAttributeName: attriColor,
                            };
    
    [text addAttributes:attriDic range:[allStr rangeOfString:numbersStr]];
    
    self.gameNumbersLabel.attributedText = text;
}

- (void)setGameTogetherTitle:(NSString *)title {
    self.gameTogetherLabel.text = title;
}

- (void)setGameTogetherNumbersTitle:(NSString *)title {
    self.gameTogetherNumbersLabel.text = title;
}

- (void)setHighPraiseTitle:(NSString *)title {
    self.feelGoodNumbersLabel.text = title;
}

- (void)setPlayerLabels:(NSArray<CatAttributedAlertLabelModel *> *)labelsArr {
    [self resetPlayerLabelsWith:labelsArr];
}

- (void)setBackgroundColor:(UIColor * _Nullable)backgroundColor forButtonType:(CatAttributedAlertButtonType)btnType {
    if (btnType == CatAttributedAlertButtonTypeAll) {
        [self.addFriendBtn setBackgroundColor:backgroundColor];
        [self.removeGameRoomBtn setBackgroundColor:backgroundColor];
        
    } else if (btnType == CatAttributedAlertButtonTypeNoBorder) {
        [self.addFriendBtn setBackgroundColor:backgroundColor];
        
    } else if (btnType == CatAttributedAlertButtonTypeBorder) {
        [self.removeGameRoomBtn setBackgroundColor:backgroundColor];
    }
}

- (void)setTitle:(NSString * _Nullable)title forState:(UIControlState)state forButtonType:(CatAttributedAlertButtonType)btnType {
    if (btnType == CatAttributedAlertButtonTypeAll) {
        [self.addFriendBtn setTitle:title forState:state];
        [self.removeGameRoomBtn setTitle:title forState:state];
        
    } else if (btnType == CatAttributedAlertButtonTypeNoBorder) {
        [self.addFriendBtn setTitle:title forState:state];
        
    } else if (btnType == CatAttributedAlertButtonTypeBorder) {
        [self.removeGameRoomBtn setTitle:title forState:state];
    }
}

#pragma mark - init
- (instancetype)initWithButtons:(CatAttributedAlertButtonType)btnType {
    if (self = [super init]) {
        
        self.btnType = btnType;
        
        [self resetBgColor];
        [self addTapGes];
        [self loadXib];
        [self resetSubviews];
        [self resetButtons];
    }
    return self;
}

- (void)resetBgColor {
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
}

- (void)addTapGes {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBackgroundView)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
}

- (void)loadXib {
    self.contentView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.contentView];
    
    CGFloat height = 366;
    if (self.btnType == CatAttributedAlertButtonTypeNoBorder ||
        self.btnType == CatAttributedAlertButtonTypeBorder) {
        height -= 63;
    } else if (self.btnType == CatAttributedAlertButtonTypeNone) {
        height -= 142;
    }
    
    NSLayoutConstraint *widthTraint = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute: NSLayoutAttributeNotAnAttribute multiplier:1 constant:300];
    NSLayoutConstraint *heightTraint = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute: NSLayoutAttributeNotAnAttribute multiplier:1 constant:height];
    NSLayoutConstraint *centerXTraint = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute: NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *centerYTraint = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute: NSLayoutAttributeCenterY multiplier:1 constant:-23];
    
    [self addConstraint:widthTraint];
    [self addConstraint:heightTraint];
    [self addConstraint:centerXTraint];
    [self addConstraint:centerYTraint];
}

- (void)resetSubviews {
    
    self.contentView.layer.cornerRadius = 10;
    
    self.playerIconImageView.layer.cornerRadius = 37.5;
    self.playerIconImageView.layer.masksToBounds = YES;
    
    self.addFriendBtn.layer.cornerRadius = 4;
    self.addFriendBtn.layer.masksToBounds = YES;
    
    self.removeGameRoomBtn.layer.cornerRadius = 4;
    self.removeGameRoomBtn.layer.masksToBounds = YES;
    
    self.removeGameRoomBtn.layer.borderWidth = 1;
    self.removeGameRoomBtn.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5].CGColor;
    
    [self.leftUpBtn setContentEdgeInsets:UIEdgeInsetsMake(7, 7, 7, 7)];
    [self.closeBtn setContentEdgeInsets:UIEdgeInsetsMake(7, 7, 7, 7)];
    
    _iconImgView = self.playerIconImageView;
    
    [self.leftUpBtn addTarget:self action:@selector(clickLeftUpBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.closeBtn addTarget:self action:@selector(clickCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.addFriendBtn addTarget:self action:@selector(clickAddFriendBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.removeGameRoomBtn addTarget:self action:@selector(clickRemoveGameRoomBtn:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)resetButtons {
    if (self.btnType == CatAttributedAlertButtonTypeNoBorder) {
        self.removeGameRoomBtnHeight.constant = 0;
        self.removeGameRoomBtnToBottom.constant = 0;
        self.removeGameRoomBtn.hidden = YES;
        
    } else if (self.btnType == CatAttributedAlertButtonTypeBorder) {
        self.addFriendBtnHeight.constant = 0;
        self.addFriendToRemoveGameRoomBtn.constant = 0;
        self.addFriendBtn.hidden = YES;
        
    } else if (self.btnType == CatAttributedAlertButtonTypeNone) {
        self.addFriendBtnHeight.constant = 0;
        self.addFriendToRemoveGameRoomBtn.constant = 0;
        self.addFriendBtn.hidden = YES;
        
        self.removeGameRoomBtnHeight.constant = 0;
        self.removeGameRoomBtnToBottom.constant = 0;
        self.removeGameRoomBtn.hidden = YES;
        
        self.horizontalLineView2.hidden = YES;
    }
}

/// 创建玩家标签
- (void)resetPlayerLabelsWith:(NSArray<CatAttributedAlertLabelModel *> *)labelsArr {
    // 先清空
    if (self.labelViewArray && self.labelViewArray.count > 0) {
        for (CatAttributedAlertLabel *label in self.labelViewArray) {
            [label removeFromSuperview];
        }
    }
    
    self.labelViewArray = nil;
    
    // 判空
    if (!labelsArr) {
        return;
    }
    
    NSMutableArray<CatAttributedAlertLabel *> *mutArr = [NSMutableArray array];
    CGFloat totalWidth = 0;
    CGFloat minLabelWidth = 34;
    CGFloat maxSpace = 4;
    
    //创建标签
    for (CatAttributedAlertLabelModel *model in labelsArr) {
        CatAttributedAlertLabel *labelView = [[CatAttributedAlertLabel alloc] init];
        
        /*
         标签最少 34pt 宽, 如果过短, 则保持 34pt 不变, 而拉伸 icon和label的间距(内间距) 以及左右边距
         内间距最大 4pt, 达到此间距后, 只能靠拉伸左右间距来自适应宽度
         优先拉伸左右间距, 其超过 4pt 后, 再拉伸 内间距
         */
        
        // 文字宽度
        CGFloat strWidth = [self str:model.labelString widthForHeight:self.playerLabelSuperViewHeight.constant font:model.labelFont];
        
        //原则上的标签宽度
        CGFloat labelWidth = strWidth + labelView.iconImageWidth + labelView.iconImageToLeft + labelView.labelToIconImage + labelView.labelToTrail;
        
        // 宽度过小
        if (labelWidth < minLabelWidth) {
            
            //内容宽
            CGFloat contentWidth = strWidth + labelView.iconImageWidth;
            
            // 左右间距
            CGFloat lrSpace = (minLabelWidth - contentWidth - labelView.labelToIconImage) / 2;
            
            if (lrSpace > maxSpace) {
                
                // 开始同步拉伸内间距
                CGFloat overflowWidth = minLabelWidth - contentWidth - labelView.labelToIconImage - 2 * maxSpace;
                CGFloat overflowSpace = overflowWidth / 3;
                
                // 超过最大内间距, 继续拉伸左右间距
                if (labelView.labelToIconImage + overflowSpace > maxSpace) {
                    labelView.labelToIconImage = maxSpace;
                    lrSpace = (minLabelWidth - contentWidth - labelView.labelToIconImage) / 2;
                    
                } else {
                    labelView.labelToIconImage += overflowSpace;
                    lrSpace = maxSpace + overflowSpace;
                }
            }
            
            labelView.iconImageToLeft = lrSpace;
            labelView.labelToTrail = lrSpace;
            
            // 重新计算下标签宽度
            labelWidth = strWidth + labelView.iconImageWidth + labelView.iconImageToLeft + labelView.labelToIconImage + labelView.labelToTrail;
        }
        
        // 计算总宽度
        NSUInteger index = [labelsArr indexOfObject:model];
        totalWidth += (labelWidth + (index == 0 ? 0 : 4));
        
        // 添加到父视图
        [self.playerLabelSuperView addSubview:labelView];
        
        // 约束
        labelView.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:labelView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.playerLabelSuperView attribute:NSLayoutAttributeLeft multiplier:1 constant:totalWidth - labelWidth];
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:labelView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.playerLabelSuperView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:labelView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.playerLabelSuperView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:labelView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:labelWidth];
        
        [self.playerLabelSuperView addConstraint:leftConstraint];
        [self.playerLabelSuperView addConstraint:topConstraint];
        [self.playerLabelSuperView addConstraint:bottomConstraint];
        [self.playerLabelSuperView addConstraint:widthConstraint];
        
        // 界面数据赋值
        labelView.model = model;
        
        // 记录下来
        [mutArr addObject:labelView];
        
    }
    
    self.playerLabelSuperViewWidth.constant = totalWidth;
}

#pragma mark - Action
/// 显示
- (void)showIn:(UIView * _Nullable)inView animated:(BOOL)animated {
    if (!inView) {
        inView = [UIApplication sharedApplication].keyWindow;
    }
    self.frame = inView.bounds;
    [inView addSubview:self];
    [inView bringSubviewToFront:self];
    
    if (animated) {
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        
        self.contentView.alpha = 0;
        self.contentView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
            
            self.contentView.alpha = 1.0;
            self.contentView.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            
        }];
    }
}

/// 移除
- (void)dismissWithAnimated:(BOOL)animated {
    
    if (animated) {
        
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
            
            self.contentView.alpha = 0;
            self.contentView.transform = CGAffineTransformMakeScale(1.2, 1.2);
            
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
        
    } else {
        [self removeFromSuperview];
    }
}

- (void)clickBackgroundView {
    if (self.tapBlock) {
        self.tapBlock(CatAttributedAlertTapTypeBackground);
    } else {
        [self dismissWithAnimated:NO];
    }
}

- (void)clickLeftUpBtn:(UIButton *)sender {
    if (self.tapBlock) {
        self.tapBlock(CatAttributedAlertTapTypeLeftUp);
    } else {
        [self dismissWithAnimated:NO];
    }
}

- (void)clickCloseBtn:(UIButton *)sender {
    if (self.tapBlock) {
        self.tapBlock(CatAttributedAlertTapTypeRightUp);
    } else {
        [self dismissWithAnimated:NO];
    }
}

- (void)clickAddFriendBtn:(UIButton *)sender {
    if (self.tapBlock) {
        self.tapBlock(CatAttributedAlertTapTypeNoBorder);
    } else {
        [self dismissWithAnimated:NO];
    }
}

- (void)clickRemoveGameRoomBtn:(UIButton *)sender {
    if (self.tapBlock) {
        self.tapBlock(CatAttributedAlertTapTypeBorder);
    } else {
        [self dismissWithAnimated:NO];
    }
}

- (CGFloat)str:(NSString *)str widthForHeight:(CGFloat)height font:(UIFont *)font{
    
    if (str.length<=0) {
        return 0;
    }
    CGSize textSize = CGSizeMake(CGFLOAT_MAX , height);
    NSMutableParagraphStyle *parStyle=[[NSMutableParagraphStyle alloc]init];
    parStyle.lineBreakMode=NSLineBreakByWordWrapping;
    NSDictionary *attributes=@{NSFontAttributeName:font,NSParagraphStyleAttributeName:parStyle };
    return ceil([str boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size.width);
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if ([touch.view isDescendantOfView:self.contentView]) {
        return NO;
    }
    return YES;
}

@end
