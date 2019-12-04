//
//  CatSpinner.m
//  UITemplateLib
//
//  Created by gwh on 2019/4/25.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CatSpinner.h"

@interface CatSpinner ()<CatSpinnerListDelegate>

@property (nonatomic, strong) UIView* baseView;
@property (nonatomic, strong) CatSpinnerList* csList;
@property (nonatomic, assign) CGPoint originPoint;
@property (nonatomic, strong) NSArray* iconArr;
@property (nonatomic, strong) NSArray* itemArr;

@property (nonatomic, strong) UIView* maskView;//蒙版
@end

@implementation CatSpinner

- (instancetype)initOn:(UIView *)view originPoint:(CGPoint)originPoint iconArr:(nullable NSArray<NSString *> *)iconArr itemArr:(nonnull NSArray<NSString *> *)itemArr{
    if (self = [super init]) {

        self.baseView = view;
        self.originPoint = originPoint;
        self.iconArr = iconArr;
        self.itemArr = itemArr;
        
    }
    return self;
}

-(void)popUp{
    if (_itemArr.count <= 0) return;
    self.csList = [[CatSpinnerList alloc] initWithOriginPoint:CGPointMake(_originPoint.x, _originPoint.y) iconArr:_iconArr itemArr:_itemArr];
    _csList.cslDelegate = self;
    self.csList.alpha = 0.0f;

    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissCatSpinnerList)];
    
    if (_baseView) {
        //列表
        self.maskView=[[UIView alloc]initWithFrame:CGRectMake(0, _originPoint.y, WIDTH(), HEIGHT()-_originPoint.y)];
        _maskView.backgroundColor=RGBA(51, 51, 51, 0.5);
        _maskView.alpha=0;
        [_maskView addGestureRecognizer:tap];
        [_baseView addSubview:_maskView];
        [_baseView addSubview:self.csList];
        
        [UIView animateWithDuration:.3 animations:^{
            self.csList.alpha = 1;
            self.maskView.alpha=1;
        }];
    }else{
        UIWindow* window = [UIApplication sharedApplication].keyWindow;
        self.maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(), HEIGHT())];
        _maskView.backgroundColor = RGBA(51, 51, 51, 0.5);
        _maskView.alpha=0;
        [_maskView addGestureRecognizer:tap];
        [window addSubview:_maskView];
        [window addSubview:self.csList];
        
        [UIView animateWithDuration:.3 animations:^{
            self.csList.alpha = 1;
            self.maskView.alpha=1;
        }];
    }
}

-(void)catSpinnerList:(CatSpinnerList *)catSpinnerList didSelectRowAtIndex:(NSInteger)index itemName:(NSString *)itemName{
    if (_csDelegate && [_csDelegate respondsToSelector:@selector(catSpinner:didSelectRowAtIndex:itemName:)]) {
        [_csDelegate catSpinner:self didSelectRowAtIndex:index itemName:itemName];
    }
    [self dismissCatSpinnerList];
}
-(void)dismissCatSpinnerList:(CatSpinnerList *)catSpinnerList{
    [self dismissCatSpinnerList];
}
-(void)dismissCatSpinnerList{
    if ([_csDelegate respondsToSelector:@selector(catSpinnerDimiss:)]) {
        [_csDelegate catSpinnerDimiss:self];
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.csList.alpha = 0;
        self.maskView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.csList removeFromSuperview];
        self.csList = nil;
        [self.maskView removeFromSuperview];
        self.maskView = nil;
    }];
}

#pragma mark - public
-(void)updateWidth:(float)width{
    [_csList updateWidth:width];
}
-(void)updateTextColor:(UIColor *)textColor backColor:(UIColor *)backColor{
    [_csList updateTextColor:textColor backColor:backColor];
}
-(void)updateItems:(NSArray *)items{
    [_csList updateIcons:nil items:items];
}
-(void)updateIcons:(NSArray *)icons items:(NSArray *)items{
    [_csList updateIcons:icons items:items];
}
-(void)updateShapeCornerMask:(CACornerMask)mask cornerRadius:(CGFloat)cornerRadius{
    if (@available(iOS 11.0, *)) {
        self.csList.layer.maskedCorners = mask;
        self.csList.layer.cornerRadius = cornerRadius;
    }
}
@end
