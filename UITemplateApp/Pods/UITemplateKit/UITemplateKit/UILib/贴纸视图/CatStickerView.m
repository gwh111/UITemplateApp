//
//  CatStickerView.m
//  UITemplateKit
//
//  Created by ml on 2019/7/10.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatStickerView.h"
#import "ccs.h"
#import "CatSideView.h"

@interface CatStickerView () {
@private
    NSInteger _sections;
    NSInteger _rows;
    NSInteger _ninenine;
    UIScrollView *_scrollView;
    NSMutableArray *_createdViews;
}

// @property (nonatomic,assign) BOOL combineScroll;

@end

@implementation CatStickerView

// MARK: - LifeCycle -
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.backgroundColor = UIColor.whiteColor;
    _layout = [CatStickerViewLayout new];
    _layout.lineSpacing = RH(6);
    _layout.interitemSpacing = RH(10);
    _layout.marginSectionInset = UIEdgeInsetsMake(0, RH(16), 0, RH(16));
    
    [self addSubview:_scrollView = [[UIScrollView alloc] initWithFrame:self.bounds]];
    
    _ninenine = 99;
    
    if (@available(iOS 11.0, *)) {
        _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    _createdViews = [NSMutableArray array];
    _scrollable = YES;
    
    _combineScroll = YES;
    _autoLinebreak = YES;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview) {
        [self reloadData];
    }
}

- (void)didMoveToSuperview {
    if ([UIView cc_currentViewController]) {
        [UIView cc_currentViewController].automaticallyAdjustsScrollViewInsets = NO;
    }
}

// MARK: - Public -
- (void)reloadData {
    _sections = 1;
    
    if ([self.datasource respondsToSelector:@selector(numberOfSectionsInStickerView)]) {
        _sections = [self.datasource numberOfSectionsInStickerView];
    }
    
    for (CatSimpleView *sview in _createdViews) {
        [sview removeFromSuperview];
    }
    
    if (_sections > 0) {
        CGFloat topY = 0;
        CGFloat maxX = 0;
        if (self.headerView) {
            if (_combineScroll) {
                [_scrollView addSubview:self.headerView];
                topY += self.headerView.height;
            }else {
                [self addSubview:self.headerView];
            }
        }
        
        CGFloat calculateHeight = 0;
        CGFloat calculateWidth = 0;
        for (int i = 0; i < _sections; ++i) {
            if ([self.datasource respondsToSelector:@selector(stickerView:numberOfRowsInSection:)]) {
                _rows = [self.datasource stickerView:self numberOfRowsInSection:i];
            }
            
            if (_rows == 0) {
                if (self.placeholderView) {
                    [_scrollView addSubview:self.placeholderView];
                    calculateHeight = self.placeholderView.height;
                }
                return;
            }else {
                [self.placeholderView removeFromSuperview];
                calculateHeight = 0;
            }
            
            if ([self _sectionView:i]) {
                [[self _sectionView:i] removeFromSuperview];
            }
            
            UIEdgeInsets marginInset = _layout.marginSectionInset;
            
            if ([self.datasource respondsToSelector:@selector(stickerView:viewForHeaderInSection:)]) {
                CatSimpleView *sview = [self.datasource stickerView:self viewForHeaderInSection:i];
                sview.identifier = [NSString stringWithFormat:@"section%d",i];
                sview.top = topY;
                if (i > 0) {
                    sview.top += marginInset.bottom;
                }
                topY += sview.height;
                [_scrollView addSubview:sview];
            }
            
            if (_rows > 0) {
                CatSimpleView *lastSView = nil;
                for (int j = 0; j < _rows; ++j) {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:i];
                    CatSimpleView *sview = [self dequeueReusableViewAtIndexPath:indexPath];
                    if([self.datasource respondsToSelector:@selector(stickerView:willDisplayView:atIndexPath:)]) {
                        [self.datasource stickerView:self willDisplayView:sview atIndexPath:indexPath];
                        /// 确保sview处在正确的位置
                        sview.left = 0;
                        sview.top = 0;
                    }
                    
                    CGFloat interitemSpacing = _layout.interitemSpacing;
                    CGFloat lineSpacing = _layout.lineSpacing;
                    
                    if ([self.delegate respondsToSelector:@selector(stickerView:layoutAtIndexPath:)]) {
                        CatStickerViewLayout *layout = [self.delegate stickerView:self layoutAtIndexPath:indexPath];
                        interitemSpacing = layout.interitemSpacing;
                        lineSpacing = layout.lineSpacing;
                        marginInset = layout.marginSectionInset;
                    }
                    
                    CGFloat left = CGRectGetMaxX(lastSView.frame);
                    CGFloat top = lastSView.top;
                    
                    if (self.autoLinebreak) {
                        /// 是否换行
                        if ((left + interitemSpacing + sview.width) > MIN(WIDTH(),self.width)) {
                            left = marginInset.left;
                            top += (lastSView.height + lineSpacing);
                        }else {
                            left += interitemSpacing;
                        }
                    }else {
                        left += interitemSpacing;
                    }
                    
                    /// 该组的第一个
                    if (j == 0) {
                        left = marginInset.left;
                        top = topY + marginInset.top;
                    }
                    
                    sview.left = left;
                    sview.top = top;
                    
                    [_scrollView addSubview:sview];
                    
                    lastSView = sview;
                }
                topY = CGRectGetMaxY(lastSView.frame);
                maxX = CGRectGetMaxX(lastSView.frame);
            }
            calculateHeight = (topY + marginInset.bottom);
            calculateWidth = (maxX + marginInset.right);
        }
        
        if(self.footerView) {
            if (_combineScroll) {
                self.footerView.top = calculateHeight;
                [_scrollView addSubview:self.footerView];
                calculateHeight += self.footerView.height;
            }else {
                self.footerView.top = calculateHeight;
                calculateHeight += self.footerView.height;
                [self addSubview:self.footerView];
            }
        }
        
        self.height = calculateHeight;
        
        /** 手动设置固定高度,根据内容调整滚动范围 */
        if(self.fixedHeight != 0) {
            self.height = self.fixedHeight;
        }
        
        _scrollView.width = self.width;
        _scrollView.height = self.height;
        
        /** 头部视图伴随滚动 */
        if (_combineScroll) {
            _scrollView.top = 0;
            _scrollView.left = 0;
            _scrollView.contentSize = CGSizeMake(_scrollView.width, self.height + _scrollable);
            /** 要根据实际的高度计算可滚动范围 */
            if (self.fixedHeight != 0) {
                _scrollView.contentSize = CGSizeMake(_scrollView.width, calculateHeight + _scrollable);
            }
        }else {
            _scrollView.top = self.headerView.height;
            _scrollView.left = 0;
            
            if (self.fixedHeight != 0) {
                _scrollView.height = self.height - self.headerView.height;
                _scrollView.contentSize = CGSizeMake(_scrollView.width, calculateHeight + _scrollable);
            }else {
                self.height = calculateHeight + self.headerView.height;
                _scrollView.height = self.height - self.headerView.height;
                _scrollView.contentSize = CGSizeMake(_scrollView.width, calculateHeight + _scrollable);
            }
        }
        
        if(_autoLinebreak == NO) {
            _scrollView.contentSize = CGSizeMake(calculateWidth + _scrollable, calculateHeight);
        }
    }
}



//- (void)reloadSections:(NSIndexSet *)sections {
//    /// TODO
//}

- (CatSimpleView *)stickerViewForIndexPath:(NSIndexPath *)indexPath{
    for (UIView *view in _createdViews) {
        if ([view isKindOfClass:[CatSimpleView class]]) {
            CatSimpleView *sview = (CatSimpleView *)view;
            if ([sview isEqual:self.headerView] ||
                [sview isEqual:self.placeholderView] ||
                [sview.identifier hasPrefix:@"section"]) {
                continue;
            }
            
            if (sview.tag == (indexPath.section * _ninenine + indexPath.row)) {
                return sview;
            }
        }
    }
    return nil;
}

- (NSArray <CatSimpleView *>*)fetchSimpleViews {
    NSMutableArray *sviews = [NSMutableArray array];
    for (UIView *view in _createdViews) {
        if ([view isKindOfClass:[CatSimpleView class]]) {
            CatSimpleView *sview = (CatSimpleView *)view;
            if ([sview isEqual:self.headerView] ||
                [sview isEqual:self.placeholderView] ||
                [sview.identifier hasPrefix:@"section"]) {
                continue;
            }
            [sviews addObject:sview];
        }
    }
    return sviews.copy;
}

- (__kindof CatSimpleView *)dequeueReusableViewAtIndexPath:(NSIndexPath *)indexPath {
    for (UIView *view in _createdViews) {
        if ([view isKindOfClass:[CatSimpleView class]]) {
            CatSimpleView *sview = (CatSimpleView *)view;
            if ([sview isEqual:self.headerView] ||
                [sview isEqual:self.placeholderView] ||
                [sview.identifier hasPrefix:@"section"]) {
                continue;
            }
            
            if (view.tag == (indexPath.section * _ninenine + indexPath.row)) {
                return (CatSimpleView *)view;
            }
        }
    }
    CatSimpleView *sview = nil;
    if ([self.datasource respondsToSelector:@selector(stickerView:customViewForRowAtIndexPath:)]) {
        sview = [self.datasource stickerView:self customViewForRowAtIndexPath:indexPath];
    }else {
        sview = [CatSimpleView new];
    }
    
    sview.tag = indexPath.section * _ninenine + indexPath.row;
    [sview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapAction:)]];
    [_createdViews addObject:sview];
    return sview;
}

// MARK: - Internal -
- (CatSimpleView *)_sectionView:(NSInteger)section {
    // for (UIView *view in self.subviews) {
    for (UIView *view in _scrollView.subviews) {
        if ([view isKindOfClass:[CatSimpleView class]]) {
            CatSimpleView *sview = (CatSimpleView *)view;
            if ([sview.identifier isEqualToString:[NSString stringWithFormat:@"section%ld",section]]) {
                return sview;
            }
        }
    }
    return nil;
}

- (void)_tapAction:(UITapGestureRecognizer *)sender {
    if ([self.delegate respondsToSelector:@selector(stickerView:didSelectAtIndexPath:)]) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(sender.view.tag % _ninenine) inSection:(sender.view.tag / _ninenine)];
        [self.delegate stickerView:self didSelectAtIndexPath:indexPath];
    }
}

@end
