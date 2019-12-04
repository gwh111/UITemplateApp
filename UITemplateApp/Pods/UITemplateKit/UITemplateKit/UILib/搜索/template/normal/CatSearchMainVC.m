//
//  CatSearchMainVC.m
//  UITemplateKit
//
//  Created by Shepherd on 2019/7/28.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatSearchMainVC.h"
#import "ccs.h"
#import "CatSimpleView.h"

@interface CatSearchMainVC () <CatSearchViewDelegate> {
    UIColor *_originNavigationColor;
}

@property (nonatomic,strong) CatSearchView *searchView;

@end

@implementation CatSearchMainVC

- (instancetype)init {
    if (self = [super init]) {
        _hidesBackButton = YES;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    if (!self.parentView) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        
        CGFloat left = 0;
        if (self.hidesBackButton) {
            self.navigationItem.hidesBackButton = YES;
        }else {
            if (self.navigationItem.backBarButtonItem) {
                left = self.navigationItem.backBarButtonItem.width;
            }else if (self.navigationItem.leftBarButtonItem) {
                left = self.navigationItem.backBarButtonItem.width;
            }else {
                /// navigationBar > _UINavigationBarContentView > _UIButtonBarButton
                /**
                 <_UIButtonBarButton: 0x7fc970602540; frame = (0 0; 69 44); layer = <CALayer: 0x600000e24d00>>
                 */
                left = 69;
            }
        }
        
        _searchView = [[CatSearchView alloc] initWithFrame:CGRectMake(left, 4, WIDTH() - left, 36) delegate:self];
        
        self.navigationController.navigationBar.barTintColor = UIColor.whiteColor;
        
    } else {
        _searchView = [[CatSearchView alloc] initWithFrame:self.parentView.bounds delegate:self];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.parentView) {
        [self.navigationController.navigationBar addSubview:_searchView];
    }else {
        [self.parentView addSubview:_searchView];
    }
    [_searchView.td becomeFirstResponder];
    
    [self _fixup:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_searchView removeFromSuperview];
}

- (void)_fixup:(BOOL)isDidAppear {
    if (isDidAppear) {
        self.navigationController.navigationBar.shadowImage = nil;
        self.navigationController.navigationBar.barTintColor = _originNavigationColor;
    }else {
        self.navigationController.navigationBar.shadowImage = [UIImage new];
        _originNavigationColor = self.navigationController.navigationBar.barTintColor;
        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    }
}

- (void)searchViewDidCancel:(CatSearchView *)searchView {
    if (searchView.td.isEditing) {
        [searchView.td resignFirstResponder];
    }
    if ([self.searchDelegate respondsToSelector:@selector(searchViewDidCancel:)]) {
        [self.searchDelegate searchViewDidCancel:searchView];
    }else {
        /// 无返回按钮
        if (self.navigationController && self.hidesBackButton) {
            [self.navigationController popViewControllerAnimated:NO];
            [self.searchView removeFromSuperview];
        }
    }
}

- (CGFloat)searchView:(CatSearchView *)searchView viewKey:(CatSearchViewKey)key {
    if ([key isEqualToString:CatSearchViewKeyNormalLeft]) {
        if (searchView.left != 0) {
            return 0;
        }
    }else if ([key isEqualToString:CatSearchViewKeyOriginWidth]) {
        if (searchView.left != 0) {
            return [searchView searchViewKey:CatSearchViewKeyOriginWidth] + RH(16);
        }
    }else if ([key isEqualToString:CatSearchViewKeyEnlargeWidth]) {
        if (searchView.left != 0) {
            return [searchView searchViewKey:CatSearchViewKeyEnlargeWidth] + RH(16);
        }
    }
    return CatSearchViewKeyAuto;
}

@end
