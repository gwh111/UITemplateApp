//
//  CatLibSearchListVC.m
//  UITemplateKit
//
//  Created by Shepherd on 2019/8/4.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatLibSearchListVC.h"
#import "CatSideView.h"

@interface CatLibSearchListVC () <CatSearchViewDelegate> {
    UITableView *_tableView;
}

@end

@implementation CatLibSearchListVC

// MARK: - LifeCycle -
- (instancetype)initWithKeyWord:(NSString *)keyWord{
    if (self = [super init]) {
        if (!_searchView) {
            _searchView = [[CatSearchView alloc] initWithFrame:CGRectZero delegate:self];
        }
        _hasBackButton = YES;
        _searchView.td.text = keyWord;
        if (!_tableView) {
            _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, WIDTH(), HEIGHT() - STATUS_AND_NAV_BAR_HEIGHT) style:UITableViewStylePlain];
        }
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    [self initViews];
    
    !self.viewDidLoadHandler ? : self.viewDidLoadHandler();
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    !self.viewWillAppearHandler ? : self.viewWillAppearHandler();
}

- (void)initNav {
    self.view.backgroundColor = UIColor.whiteColor;
    [self setCatNavigationBarWhite];
    if (self.title) {
        self.catNavBarTitle = self.title;
    }
    self.cat_navigationBarView.backgroundColor = [UIColor clearColor];
    self.cat_navigationBarView.backButton.hidden = !self.hasBackButton;
}

- (void)initViews {
    if (_searchView.category == CatSearchViewCategoryNone) {
        CGFloat x = self.hasBackButton ? 30 : 0;
        _searchView.frame = CGRectMake(x, STATUS_BAR_HEIGHT + 4, WIDTH() - x, 36);
        _searchView.c2Superview(self.cat_navigationBarView);
    }else if (_searchView.category == CatSearchViewCategoryAutoHide) {
        _searchView.frame = CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT + 4, WIDTH(), 36);
        _searchView.c2Superview(self.view);
        _searchView.customNavView = self.cat_navigationBarView;
    }
    [_searchView refreshLayout];
    _tableView.c2Superview(self.view);
    _tableView.top = MAX(_searchView.bottom,STATUS_AND_NAV_BAR_HEIGHT);
}

// MARK: - CatSearchViewDelegate -
- (void)searchViewDidCancel:(CatSearchView *)searchView {
    if ([self.searchObject respondsToSelector:@selector(searchViewDidCancel:)]) {
        [self.searchObject searchViewDidCancel:searchView];
    }
}

- (BOOL)searchViewShouldReturn:(CatSearchView *)searchView {
    if ([self.searchObject respondsToSelector:@selector(searchViewShouldReturn:)]) {
        return [self.searchObject searchViewShouldReturn:searchView];
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
            if (searchView.td.isEditing == NO) {
                return WIDTH() - 30 - RH(16) - 31 - RH(8);
            }
        }
    }
    
    return CatSearchViewKeyAuto;
}

@end
