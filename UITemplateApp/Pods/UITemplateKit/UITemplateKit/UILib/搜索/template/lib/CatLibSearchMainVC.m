//
//  CatLibSearchMainVC.m
//  UITemplateKit
//
//  Created by Shepherd on 2019/8/4.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatLibSearchMainVC.h"
#import "CatLibSearchListVC.h"
#import "CatSideView.h"

@interface CatLibSearchMainVC () <CatSearchViewDelegate,CatSearchHistoryViewDelegate> {
    CatSearchHistoryView *_historyView;
}

@end

@implementation CatLibSearchMainVC
// MARK: - LifeCycle -
- (instancetype)init {
    if (self = [super init]) {
        _searchView = [[CatSearchView alloc] initWithFrame:CGRectZero delegate:self];
        _searchView.option = CatSearchViewOptionLock;
        _existedHistory = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    [self initViews];
    
    !self.viewDidLoadHandler ? : self.viewDidLoadHandler();
}

- (void)initNav {
    self.view.backgroundColor = UIColor.whiteColor;
    if (self.title) {
        self.catNavBarTitle = self.title;
    }
    [self setCatNavigationBarWhite];
    self.cat_navigationBarView.backgroundColor = [UIColor clearColor];
    self.cat_navigationBarView.backButton.hidden = !self.hasBackButton;
}

- (void)initViews {
    CGFloat x = self.hasBackButton ? 30 : 0;
    _searchView.frame = CGRectMake(x, STATUS_BAR_HEIGHT + 4, WIDTH() - x, 36);
    _searchView.c2Superview(self.cat_navigationBarView);
    [_searchView refreshLayout];
    
    if (_existedHistory) {
        _historyView = [[CatSearchHistoryView alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, WIDTH(), 100)];
        if(_historyFileName) {
            _historyView.record = [[CatSearchRecordsModel alloc] initWithName:_historyFileName];
        }
        _historyView.delegate = self;
        _historyView.searchView = self.searchView;
        _historyView.c2Superview(self.view);
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_existedHistory) {
        [_historyView.stickerView reloadData];
        _historyView.height = _historyView.stickerView.height;
    }
    
    if (_hideKeyboard == NO) {
        [_searchView.td becomeFirstResponder];
    }
}

// MARK: - CatSearchHistoryViewDelegate -
- (void)historyView:(CatSearchHistoryView *)historyView didSelectAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.searchObject respondsToSelector:@selector(historyView:didSelectAtIndexPath:)]) {
        [self.searchObject historyView:historyView didSelectAtIndexPath:indexPath];
    }
}

- (void)historyView:(CatSearchHistoryView *)historyView clearAction:(UIButton *)sender {
    if ([self.searchObject respondsToSelector:@selector(historyView:clearAction:)]) {
        [self.searchObject historyView:historyView clearAction:sender];
    }
}

// MARK: - CatSearchViewDelegate -
- (void)searchViewDidCancel:(CatSearchView *)searchView {
    if ([self.searchObject respondsToSelector:@selector(searchViewDidCancel:)]) {
        [self.searchObject searchViewDidCancel:searchView];
    }
}

- (BOOL)searchViewDidClear:(CatSearchView *)searchView {
    if ([self.searchObject respondsToSelector:@selector(searchViewDidClear:)]) {
        return [self.searchObject searchViewDidClear:searchView];
    }
    
    return YES;
}

- (BOOL)searchViewShouldReturn:(CatSearchView *)searchView {
    if ([self.searchObject respondsToSelector:@selector(searchViewShouldReturn:)]) {
        return [self.searchObject searchViewShouldReturn:searchView];
    }else {
        if(_existedHistory) {
            [_historyView.record saveWithKeyword:searchView.td.text];
        }
    }
    
    return YES;
}

- (void)searchViewDidBeginEditing:(CatSearchView *)searchView {
    if([self.searchObject respondsToSelector:@selector(searchViewDidBeginEditing:)]) {
        [self.searchObject searchViewDidBeginEditing:searchView];
    }
}

- (void)searchViewDidEndEditing:(CatSearchView *)searchView {
    if ([self.searchObject respondsToSelector:@selector(searchViewDidEndEditing:)]) {
        [self.searchObject searchViewDidEndEditing:searchView];
    }
}

- (void)searchViewDidChanged:(CatSearchView *)searchView value:(NSString *)value {
    if ([self.searchObject respondsToSelector:@selector(searchViewDidChanged:value:)]) {
        [self.searchObject searchViewDidChanged:searchView value:value];
    }
}

- (CGFloat)searchView:(CatSearchView *)searchView viewKey:(CatSearchViewKey)key {
    if ([key isEqualToString:CatSearchViewKeyNormalLeft]) {
        if (self.hasBackButton) {
            // 存在返回按钮 _tdView与searchView不留间距
            if (searchView.td.isEditing == NO) {
                return 0;
            }else {
                return RH(16);
            }
        }
    }
    
    if ([key isEqualToString:CatSearchViewKeyOriginWidth]) {
        if(self.alwaysShowCancel && self.hasBackButton == NO) {
            return WIDTH() - RH(16) - RH(50) - RH(8);
        }
        
        if (self.hasBackButton) {
            // 存在返回按钮 searchView.left = 30; 默认状态下:_tdView 右边留RH(16)
            if (searchView.td.isEditing == NO) {
                return WIDTH() - 30 - RH(16);
            }
        }
    }
    
    if ([key isEqualToString:CatSearchViewKeyEnlargeWidth]) {
        if(self.alwaysShowCancel && self.hasBackButton == NO) {
            return WIDTH() - RH(16) - RH(50);
        }
        
        if (self.hasBackButton) {
            // 存在返回按钮 searchView.left = 30; 编辑状态下:_tdView 右边再留 31 + RH(8)
            if (searchView.td.isEditing == NO) {
                return WIDTH() - 30 - RH(16) - 31 - RH(8);
            }
        }
    }
    
    return CatSearchViewKeyAuto;
}

@end
