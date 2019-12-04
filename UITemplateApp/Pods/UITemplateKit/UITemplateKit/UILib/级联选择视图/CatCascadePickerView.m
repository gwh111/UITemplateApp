//
//  CatCascadePickerView.m
//  UITemplateKit
//
//  Created by ml on 2019/8/13.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatCascadePickerView.h"
#import "ccs.h"

@interface CatCascadePickerView () <UIScrollViewDelegate,CatStickerViewDatesource,CatStickerViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray *sectionTitles;

@end

@implementation CatCascadePickerView

// MARK: - LifeCycle -
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _commonInit];
    }
    return self;
}

- (void)_commonInit {
    _headerView = [[CatCascadePickerHeaderView alloc] initWithFrame:CGRectMake(0, 0,self.width , RH(56 + 32))];
    _headerView.sectionView.datasource = self;
    _headerView.sectionView.delegate = self;
    _headerView.c2Superview(self);
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _headerView.bottom, self.width, self.height - _headerView.bottom)];
    _scrollView.delegate = self;
    _scrollView.scrollEnabled = NO;
    _scrollView.c2Superview(self);
    
    _sectionTitles = @[@"请选择"].mutableCopy;
}

- (void)reloadDataWithSection:(NSInteger)section {
    for (UIView *view in _scrollView.subviews) {
        if ([view isKindOfClass:UITableView.class]) {
            if (view.tag == section) {
                [(UITableView *)view reloadData];
                [_headerView.sectionView reloadData];
            }
        }
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview) {
        UITableView *tableView = [self dequeueReusableViewAtSection:0];
        [_scrollView addSubview:tableView];
        [self reloadDataWithSection:0];
        _currentSelectedSection = 0;
    }
}

// MARK: - UITableView -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(cascadePickerView:numberOfRowsInSection:)]) {
        return [self.delegate cascadePickerView:self numberOfRowsInSection:tableView.tag];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CatSimpleTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CatSimpleTableCellString];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row inSection:tableView.tag];
    if ([self.delegate respondsToSelector:@selector(cascadePickerView:titleForRowAtIndexPath:)]) {
        NSString *title = [self.delegate cascadePickerView:self titleForRowAtIndexPath:path];
        cell.sview
            .LYTitleLabel
                .n2Text(title)
                .n2Font(RF(14))
                .n2Left(RH(16))
                .n2SizeToFit()
                .n2CenterY(cell.sview.centerY)
        ;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(CatSimpleTableCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(cascadePickerView:tableView:willDisplayCell:forRowAtIndexPath:)]) {
        [self.delegate cascadePickerView:self tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _currentSelectedSection = tableView.tag;
    
    CatSimpleTableCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *currentString = cell.sview.titleLabel.text;
    
    if(currentString) {
        NSMutableArray *allStrings = [NSMutableArray array];
        for (int i = 0; i < self.sectionTitles.count; ++i) {
            if (_currentSelectedSection > i) {
                NSString *string = self.sectionTitles[i];
                if ([string isEqualToString:@"请选择"]) {
                    continue;
                }else {
                    [allStrings addObject:string];
                }
            }
        }
        
        [allStrings addObject:currentString];
        self.sectionTitles = allStrings;
    }
    
    if([self.delegate respondsToSelector:@selector(cascadePickerView:didSelectRowAtIndexPath:)]) {
        [self.delegate cascadePickerView:self
                 didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:tableView.tag]];
    }
    
    if ([self.delegate respondsToSelector:@selector(nextLevel:)]) {
        /// 存在下一级菜单
        if ([self.delegate nextLevel:self]) {
            
            /// 更新section视图
            [self.sectionTitles addObject:@"请选择"];
            [_headerView.sectionView reloadData];
            
            /// 添加下一级UITableView视图
            UITableView *t = [self dequeueReusableViewAtSection:(tableView.tag + 1)];
            [_scrollView addSubview:t];
            _nextSection = t.tag;
            
            /// 更新UIScrollView的contentSize和contentOffset
            [_scrollView setContentOffset:CGPointMake(t.tag * self.width, 0) animated:YES];
        }
    }
}

// MARK: - CatStickerView -
- (NSInteger)stickerView:(CatStickerView *)stickerView numberOfRowsInSection:(NSInteger)section {
    return _sectionTitles.count;
}

- (void)stickerView:(CatStickerView *)stickerView willDisplayView:(CatSimpleView *)view atIndexPath:(NSIndexPath *)indexPath {
    NSString *sectionTitle = _sectionTitles[indexPath.row];
    view
        .LYOneButton
            .n2UserInteractionEnabled(NO)
            .n2Text(sectionTitle)
            .n2Font(RF(15))
            .n2Left(RH(5))
            .n2BtnTextColor(UIControlStateNormal,HEX(0x3EA6FD))
            .n2SizeToFit()
        .LYSepartor
            .n2BackgroundColor(HEX(0x3EA6FD))
            .n2Top(view.oneButton.bottom)
            .n2W(30)
            .n2CenterX(view.oneButton.centerX)
            .n2H(3)
    ;
    
    view.size = CGSizeMake(view.oneButton.width + RH(10), RH(32));
}

- (void)stickerView:(CatStickerView *)stickerView didSelectAtIndexPath:(NSIndexPath *)indexPath {
    /// 更新sectionView
    NSMutableArray *titlesM = [NSMutableArray array];
    [_sectionTitles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < indexPath.row) {
            [titlesM addObject:obj];
        }
    }];
    
    if (indexPath.row == 0) {
        titlesM = @[@"请选择"].mutableCopy;
    }else {
        [titlesM addObject:@"请选择"];
    }
    
    _sectionTitles = titlesM;
    [_headerView.sectionView reloadData];
    
    /// 更新UIScrollView
    [_scrollView setContentOffset:CGPointMake((_sectionTitles.count - 1)* self.width, 0)
                         animated:YES];
    
    _currentSelectedSection = _sectionTitles.count - 1;
    _nextSection = _currentSelectedSection + 1;
    
    if ([self.delegate respondsToSelector:@selector(cascadePickerView:didTapViewAtSection:)]) {
        [self.delegate cascadePickerView:self didTapViewAtSection:indexPath.row];
    }
}

- (__kindof UIScrollView *)dequeueReusableViewAtSection:(NSInteger)section {
    for (UIView *view in _scrollView.subviews) {
        if ([view isKindOfClass:UITableView.class]) {
            if (view.tag == section) {
                return (UITableView *)view;
            }
        }
    }
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(section * self.width, 0, self.width, self.height - _headerView.bottom) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.c2Tag(section).c2BackgroundColor(HEX(0xffffff));
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:CatSimpleTableCell.class
      forCellReuseIdentifier:CatSimpleTableCellString];
    return tableView;
}

@end
