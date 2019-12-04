//
//  CatQRcodeView.m
//  UITemplateKit
//
//  Created by ml on 2019/10/30.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatQRcodeView.h"
#import "ccs.h"

@implementation CatQRcodeView

- (instancetype)initWithFrame:(CGRect)frame
                effectiveArea:(CGRect)area {
    
    if (self = [super initWithFrame:frame]) {
        _coverView = [[UIView alloc] initWithFrame:self.bounds];
        _coverView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        
        // 贝塞尔曲线 画一个带有圆角的矩形
        UIBezierPath *bpath = [UIBezierPath bezierPathWithRect:UIScreen.mainScreen.bounds];
           // 贝塞尔曲线 画一个矩形
           // [bpath appendPath:[UIBezierPath bezierPathWithArcCenter:scanner.appearance.coverView.center radius:150 startAngle:0 endAngle:2*M_PI clockwise:NO]];
        [bpath appendPath:[[UIBezierPath bezierPathWithRect:area] bezierPathByReversingPath]];
           // [bpath appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(coverView.centerX,frame.origin.y + frame.size.height + 50) radius:30 startAngle:0 endAngle:2*M_PI clockwise:NO]];
           
        // 创建一个CAShapeLayer 图层
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = bpath.CGPath;
           
        // 添加图层蒙板
        _coverView.layer.mask = shapeLayer;
        
//        _effectAreaImageView = [[UIImageView alloc] initWithImage:[CatQRcodeView bundleImageWithName:@""]];
//        _effectAreaImageView.frame = area;
//
//        _shockwaveImageView = [[UIImageView alloc] initWithImage:[CatQRcodeView bundleImageWithName:@""]];
        
        [self addSubview:_coverView];
//        [self addSubview:_effectAreaImageView];
//        [self addSubview:_shockwaveImageView];
    }
    return self;
}



+ (UIImage *)bundleImageWithName:(NSString *)name {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CatPickerPhoto" ofType:@"bundle"];
    NSBundle *extBundle = [NSBundle bundleWithPath:bundlePath];
    NSString *resourcePath = [extBundle pathForResource:[name stringByAppendingString:@"@2x"] ofType:@"png"];
    return [UIImage imageWithContentsOfFile:resourcePath];
}

@end
