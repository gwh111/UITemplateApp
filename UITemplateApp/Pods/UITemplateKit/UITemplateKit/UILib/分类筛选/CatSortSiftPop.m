//
//  CatSortSiftPop.m
//  Doctor
//
//  Created by 路飞 on 2019/6/13.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CatSortSiftPop.h"

@interface CatSortSiftPop ()<CatSortSiftPopViewDelegate>

@property (nonatomic, strong, readwrite) NSString* title;
@property (nonatomic, strong, readwrite) UIImage* leftSelectImage;
@property (nonatomic, strong, readwrite) UIImage* rightSelectImage;
@property (nonatomic, assign, readwrite) NSInteger leftSelectIndex;
@property (nonatomic, assign, readwrite) NSInteger rightSelectIndex;
@property (nonatomic, strong, readwrite) NSArray* array;

@property (nonatomic, strong) UIView* maskView;//蒙版
@property (nonatomic, strong, readwrite) CatSortSiftPopView* sortSiftPopView;

@end
@implementation CatSortSiftPop

- (instancetype)initWithTitle:(NSString *)title leftSelectImage:(UIImage *)leftSelectImage rightSelectImage:(UIImage *)rightSelectImage leftSelectIndex:(NSInteger)leftSelectIndex rightSelectIndex:(NSInteger)rightSelectIndex array:(NSArray *)array{
    if (self = [super init]) {
        self.title = title;
        self.leftSelectImage = leftSelectImage;
        self.rightSelectImage = rightSelectImage;
        self.leftSelectIndex = leftSelectIndex;
        self.rightSelectIndex = rightSelectIndex;
        self.array = array;
    }
    return self;
}

-(void)popUpCatSortSiftPopView{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    self.maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(), HEIGHT())];
    _maskView.backgroundColor = RGBA(51, 51, 51, 0.5);
    _maskView.alpha = 0.0f;
    _maskView.userInteractionEnabled = YES;
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissCatSortSiftPopView)];
    [_maskView addGestureRecognizer:tap];
    [window addSubview:_maskView];
    
    self.sortSiftPopView = [[CatSortSiftPopView alloc]initWithTitle:_title leftSelectImage:_leftSelectImage rightSelectImage:_rightSelectImage leftSelectIndex:_leftSelectIndex rightSelectIndex:_rightSelectIndex array:_array];
    _sortSiftPopView.delegate = self;
    [window addSubview:_sortSiftPopView];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 1.0f;
        self.sortSiftPopView.alpha = 1.0f;
        self.sortSiftPopView.frame = CGRectMake(0, HEIGHT()-kCatSortSiftPopViewHeight, WIDTH(), kCatSortSiftPopViewHeight);
    }];
}

-(void)dismissCatSortSiftPopView{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0.0f;
        self.sortSiftPopView.alpha = 0.0f;
        self.sortSiftPopView.frame = CGRectMake(0, HEIGHT(), WIDTH(), kCatSortSiftPopViewHeight);
    } completion:^(BOOL finished) {
        [self.sortSiftPopView removeFromSuperview];
        self.sortSiftPopView = nil;
        [self.maskView removeFromSuperview];
        self.maskView = nil;
    }];
}

-(void)updateLeftSelectIndex:(NSInteger)leftSelectIndex rightSelectIndex:(NSInteger)rightSelectIndex rightArr:(NSArray *)rightArr{
    [_sortSiftPopView updateLeftSelectIndex:leftSelectIndex rightSelectIndex:rightSelectIndex rightArr:rightArr];
}

#pragma mark - delegate
- (void)catSortSiftPopViewSelect:(CatSortSiftPopView *)catSortSiftPopView leftIndex:(NSInteger)leftIndex{
    if (_delegate && [_delegate respondsToSelector:@selector(catSortSiftPopSelect:leftIndex:)]) {
        [_delegate catSortSiftPopSelect:self leftIndex:leftIndex];
    }
}

- (void)catSortSiftPopViewSelect:(CatSortSiftPopView *)CatSortSiftPopView leftIndex:(NSInteger)leftIndex rightIndex:(NSInteger)rightIndex{
    if (_delegate && [_delegate respondsToSelector:@selector(catSortSiftPopSelect:leftIndex:rightIndex:)]) {
        [_delegate catSortSiftPopSelect:self leftIndex:leftIndex rightIndex:rightIndex];
    }
    [self dismissCatSortSiftPopView];
}

@end
