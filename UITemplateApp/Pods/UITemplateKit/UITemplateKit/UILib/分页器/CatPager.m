//
//  CatPager.m
//  UITemplateLib
//
//  Created by gwh on 2019/4/24.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CatPager.h"

@interface CatPager ()<CatPagerSegmentDelegate>

@property (nonatomic, weak) UIView* baseView;
@property (nonatomic, readwrite, strong) CatPagerSegment *segment;

@end

@implementation CatPager 

#pragma mark - lifeCycle
- (void)dealloc
{
    if (self.contentScrollView) {
        [self.contentScrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
}
#pragma mark - private
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"] && (self.contentScrollView.isTracking || self.contentScrollView.isDecelerating)) {
        //用户滚动引起的contentOffset变化，才处理。
        CGPoint contentOffset = [change[NSKeyValueChangeNewKey] CGPointValue];
        [self contentOffsetOfContentScrollViewDidChanged:contentOffset];
    }
}
- (void)contentOffsetOfContentScrollViewDidChanged:(CGPoint)contentOffset {
    CGFloat ratio = contentOffset.x/self.contentScrollView.bounds.size.width;
    if (ratio > self.segment.itemArr.count - 1 || ratio < 0) {
        //超过了边界，不需要处理
        return;
    }
    ratio = MAX(0, MIN(self.segment.itemArr.count - 1, ratio));
    NSInteger baseIndex = floorf(ratio);
    CGFloat remainderRatio = ratio - baseIndex;
    if (remainderRatio == 0) {
        //连续滑动翻页，需要更新选中状态
        [self selectItemAtIndex:baseIndex animated:YES];
    }
}
#pragma mark - public
- (void)selectItemAtIndex:(NSInteger)index animated:(BOOL)animated{
    self.currentIndex = index;
    [_segment selectItemAtIndex:index animated:animated];
}

-(instancetype)initOn:(UIView *)view theme:(CatPagerTheme)theme itemArr:(nonnull NSArray *)itemArr selectedIndex:(NSUInteger)selectedIndex{
    if (self = [super init]) {
        self.baseView = view;
        self.segment = [[CatPagerSegment alloc]initWithTheme:theme itemArr:itemArr selectedIndex:selectedIndex];
        _segment.delegate = self;
        self.currentIndex = selectedIndex;
        [view addSubview:_segment];
    }
        return self;
}

-(void)updateItems:(NSArray *)items{
    [_segment updateItemArr:items];
}

-(void)updateWidth:(float)width{
    [_segment updateWidth:width];
}

-(void)updateSelectedTextColor:(UIColor *)selectedTextColor selectedBackColor:(UIColor *)selectedBackColor textColor:(UIColor *)textColor backColor:(UIColor *)backColor bottomLineColor:(UIColor *)bottomLineColor{
    [_segment updateSelectedTextColor:selectedTextColor selectedBackColor:selectedBackColor textColor:textColor backColor:backColor bottomLineColor:bottomLineColor];
}

-(void)updateItemAtIndex:(NSInteger)index tagType:(CatPagerCellTagType)tagType content:(nullable NSString *)content{
    [_segment updateItemAtIndex:index tagType:tagType content:content];
}

-(void)updateCatPagerThemeLineZoom:(UIFont *)zoomFont{
    [_segment updateCatPagerThemeLineZoom:zoomFont];
}

- (void)updateCatPagerThemeLineSize:(CGSize)lineSize{
    [_segment updateCatPagerThemeLineSize:lineSize];
}

-(void)updateBottomLine:(BOOL)hidden{
    [_segment updateBottomLine:hidden];
}

- (void)updateHeight:(float)height{
    [_segment updateHeight:height];
}

-(void)updatePadding:(float)padding{
    [_segment updatePadding:padding];
}

-(void)updateCatPagerTitleFont:(UIFont *)font{
    [_segment updateCatPagerTitleFont:font];
}

#pragma mark - delegate
-(void)catPagerSegment:(CatPagerSegment *)catPagerSegment didSelectRowAtIndex:(NSInteger)index{
    if (_delegate && [_delegate respondsToSelector:@selector(catPager:didSelectRowAtIndex:)]) {
        [_delegate catPager:self didSelectRowAtIndex:index];
        self.currentIndex = index;
    }
}
#pragma mark -properties
- (void)setContentScrollView:(UIScrollView *)contentScrollView
{
    if (_contentScrollView != nil) {
        [_contentScrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
    _contentScrollView = contentScrollView;
    
    [contentScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

@end

