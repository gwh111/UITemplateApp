//
//  CatNetBrokenView.m
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/10.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CatNetBrokenView.h"
#import "CatNetConnectVC.h"

@interface CatNetBrokenView ()<UITextViewDelegate>

@end

@implementation CatNetBrokenView

- (instancetype)initWithFrame:(CGRect)frame emptyImage:(UIImage *)emptyImage reloadBlock:(nonnull ReloadBlock)reloadBlock {
    if (self = [super initWithFrame:frame]) {
        self.reloadBlock = reloadBlock;
        [self setupViews:emptyImage];
    }
    return self;
}

-(void)dismissCatBrokenView {
    [self removeFromSuperview];
}

- (void)setupViews:(UIImage*)emptyImage {
    self.backgroundColor = [UIColor clearColor];
    //空白图
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, RH(160.0f))];
    imgV.image = emptyImage;
    [self addSubview:imgV];
    
    UILabel *errorLb = [[UILabel alloc]initWithFrame:CGRectMake(0, imgV.bottom+RH(8.0f), self.width, RH(12.0f))];
    errorLb.textColor = RGBA(153, 153, 153, 1);
    errorLb.textAlignment = NSTextAlignmentCenter;
    errorLb.font = RF(14.0f);
    errorLb.text = @"咦？网络开小差了";
    [self addSubview:errorLb];
    
    UILabel *tipLb = [[UILabel alloc]initWithFrame:CGRectMake(0, errorLb.bottom+RH(8.0f), self.width, RH(14.0f))];
    tipLb.textColor = RGBA(51, 51, 51, 1);
    tipLb.textAlignment = NSTextAlignmentCenter;
    tipLb.font = RF(15.0f);
    tipLb.text = @"点击下方按钮帮你连上它！";
    [self addSubview:tipLb];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"温馨提示：\n" attributes:@{NSFontAttributeName:RF(12.0f), NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n请确保手机连接的WIFI或者运营商网络正常。如果正常，您可能关闭了%@的网络使用权限，", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]] attributes:@{NSFontAttributeName:RF(12.0f), NSForegroundColorAttributeName:RGBA(102, 102, 102, 1)}]];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"查看解决方案" attributes:@{NSFontAttributeName:RF(12.0f), NSForegroundColorAttributeName:RGBA(0, 118, 255, 1), NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)}]];
    [attributedString addAttribute:NSLinkAttributeName value:@"solveMethod://" range:[[attributedString string] rangeOfString:@"查看解决方案"]];
    
    CGFloat backHeight = [attributedString boundingRectWithSize:CGSizeMake(self.width-RH(32.0f), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
    
    CC_View *backV = ccs.View;
    backV.frame = CGRectMake(0, tipLb.bottom+RH(24.0f), self.width, backHeight + RH(32.0f));
    backV.backgroundColor = RGBA(238, 238, 238, 1);
    [self addSubview:backV];
    
    CC_TextView *textView = ccs.TextView;
    textView.frame = CGRectMake(RH(16.0f), RH(8.0f), self.width-RH(32.0f), backHeight + RH(24.0f));
    textView.backgroundColor = RGBA(238, 238, 238, 1);
    textView.delegate = self;
    textView.editable = NO;//必须禁止输入，否则点击将会弹出输入键盘
    textView.scrollEnabled = NO;//可选的，视具体情况而定
    [backV addSubview:textView];
    textView.attributedText = attributedString;
    
    CC_Button *reloadBtn = ccs.Button;
    reloadBtn.frame = CGRectMake(self.width/2.0 - RH(40.0f), backV.bottom+RH(24.0f), RH(80.0f), RH(32.0f));
    reloadBtn.backgroundColor = RGBA(0, 144, 255, 1);
    [reloadBtn setTitle:@"重新加载" forState:UIControlStateNormal];
    [reloadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    reloadBtn.titleLabel.font = RF(14.0f);
    [self addSubview:reloadBtn];
    WS(weakSelf);
    [reloadBtn cc_tappedInterval:0.1 withBlock:^(id  _Nonnull view) {
        SS(strongSelf);
        if (strongSelf.reloadBlock) {
            strongSelf.reloadBlock();
        }
    }];
    
    [self drawCorners:backV radius:4.0f];
    [self drawCorners:reloadBtn radius:4.0f];
    
    CGRect selfFrame = self.frame;
    selfFrame.size.height = reloadBtn.bottom;
    self.frame = selfFrame;
}

- (void)drawCorners:(UIView *)view radius:(CGFloat)radius {
    //绘制圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:radius];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

#pragma mark - delegate
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction  API_AVAILABLE(ios(10.0)){
    if ([[URL scheme] isEqualToString:@"solveMethod"]) {
        //点击了查看解决方案
        CatNetConnectVC *netConnectVC = [ccs init:CatNetConnectVC.class];
        [ccs pushViewController:netConnectVC];
        return NO;
    }
    return YES;
}

@end
