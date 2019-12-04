//
//  CatSearchLenovoView.m
//  UITemplateKit
//
//  Created by ml on 2019/7/12.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatSearchLenovoView.h"
#import "ccs.h"
#import "CatSearchView.h"
#import "CatSearchTextFieldView.h"
#import "CatSideView.h"

@interface CatSearchLenovoView () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation CatSearchLenovoView

+ (instancetype)getOne {
    CatSearchLenovoView *slview = [[CatSearchLenovoView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(), HEIGHT())];    
    return slview;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview) {
        CGFloat deltaHeight = MAX(STATUS_AND_NAV_BAR_HEIGHT, CGRectGetMaxY(self.searchView.frame));
        self.height = HEIGHT() - deltaHeight;
        _tableView.frame = self.bounds;
    }
}

- (void)didMoveToSuperview {
    if ([self cc_viewController]) {
        [self cc_viewController].automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _commonInit];
    }
    return self;
}

- (void)_commonInit {
    [self addSubview:({
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:CatSimpleTableCell.class forCellReuseIdentifier:CatSimpleTableCellString];
        _tableView;
    })];
    
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

- (void)reloadData {
    if (self.isSingleSearchEnd) { return; }
    [self.tableView reloadData];
}

// MARK: - UITableView -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.keyWords.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CatSimpleTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CatSimpleTableCellString];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(CatSimpleTableCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    id keyWord = self.keyWords[indexPath.row];
    if ([keyWord isKindOfClass:[NSString class]]) {
        cell.sview
            .LYTitleLabel.n2Text(keyWord).n2TextColor(HEX(0x333333)).n2Font(RF(17)).n2Left(RH(16)).n2SizeToFit()
            .LYSepartor.n2BackgroundColor(HEX(0xededed));
    }
    
    if ([self.delegate respondsToSelector:@selector(searchLenovoView:willDisplayCell:keyWord:forIndex:)]) {
        [self.delegate searchLenovoView:self willDisplayCell:cell keyWord:keyWord forIndex:indexPath.row];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(searchLenovoView:didSelectRowAtIndex:)]) {
        [self.delegate searchLenovoView:self didSelectRowAtIndex:indexPath.row];
    }
    _singleSearchEnd = YES;
    CatSearchTextFieldView *tdView = (CatSearchTextFieldView *)self.searchView.td.superview;
    tdView.lastTimeString = nil;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(searchLenovoViewWillBeginDragging:)]) {
        [self.delegate searchLenovoViewWillBeginDragging:self];
    }
}

@end
