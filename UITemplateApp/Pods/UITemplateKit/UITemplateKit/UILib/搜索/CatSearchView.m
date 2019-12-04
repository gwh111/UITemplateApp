//
//  CatSearchView.m
//  UITemplateKit
//
//  Created by ml on 2019/7/12.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatSearchView.h"
#import "CatSearchTextFieldView.h"
#import "ccs.h"
#import "CatSideView.h"

@interface NSString (CatSearchView)

- (NSString *)cat_initialsiLowercaseString;

@end

@implementation NSString (CatSearchView)

- (NSString *)cat_initialsiLowercaseString {
    NSString *temp = @"";
    for(int i = 0; i < [self length]; i++)
    {
        if (i == 0) {
            temp = [temp stringByAppendingString:[self substringWithRange:NSMakeRange(i, 1)].lowercaseString];
        }else {
            temp = [temp stringByAppendingString:[self substringWithRange:NSMakeRange(i, 1)]];
        }
    }
    return temp;
}

@end

@interface  CatSearchView () <UITextFieldDelegate> {
    NSDictionary *_viewKeys;
    CGFloat _originTop;
}

@property (nonatomic,assign) CGFloat normalLeft;
@property (nonatomic,assign) CGFloat normalRight;
@property (nonatomic,assign) CGFloat editingRight;
@property (nonatomic,assign) CGFloat originWidth;
@property (nonatomic,assign) CGFloat enlargeWidth;

@property (nonatomic,strong,readonly) CatSearchTextFieldView *tdView;
@property (nonatomic,weak) id<CatSearchViewDelegate> delegate;

@end

@implementation CatSearchView

- (instancetype)initWithFrame:(CGRect)frame
                     delegate:(id<CatSearchViewDelegate>)delegate {
    if (self = [super initWithFrame:frame]) {
        self.delegate = delegate;
        [self _commonInit];
    }
    return self;
}

- (void)_commonInit {
    [self refreshLayout];
}

- (void)refreshLayout {
    self.backgroundColor = [UIColor clearColor];
    
    _viewKeys = @{
                  CatSearchViewKeyNormalLeft:   @(RH(16)),
                  CatSearchViewKeyNormalRight:  @(RH(16)),
                  CatSearchViewKeyEditingRight: @(RH(8)),
                  CatSearchViewKeyOriginWidth:  @(self.width - RH(16) * 2),
                  CatSearchViewKeyEnlargeWidth: @(self.width - RH(16) - RH(50)),
                  };
    
    _normalLeft   = [[_viewKeys objectForKey:CatSearchViewKeyNormalLeft] doubleValue];
    _normalRight  = [[_viewKeys objectForKey:CatSearchViewKeyNormalRight] doubleValue];
    _editingRight = [[_viewKeys objectForKey:CatSearchViewKeyEditingRight] doubleValue];
    _originWidth  = [[_viewKeys objectForKey:CatSearchViewKeyOriginWidth] doubleValue];
    _enlargeWidth = [[_viewKeys objectForKey:CatSearchViewKeyEnlargeWidth] doubleValue];
    
    if ([self.delegate respondsToSelector:@selector(searchView:viewKey:)]) {
        for (CatSearchViewKey key in _viewKeys.allKeys) {
            CGFloat value = [self.delegate searchView:self viewKey:key];
            if (value == CatSearchViewKeyAuto) {
                NSString *methodName = [NSString stringWithFormat:@"_%@",[[key componentsSeparatedByString:@"CatSearchViewKey"].lastObject cat_initialsiLowercaseString]];
                [self setValue:_viewKeys[key] forKey:methodName];
                continue;
            }
            NSString *methodName = [NSString stringWithFormat:@"_%@",[[key componentsSeparatedByString:@"CatSearchViewKey"].lastObject cat_initialsiLowercaseString]];
            [self setValue:@(value) forKey:methodName];
        }
    }
    
    if (!_tdView) {
        _tdView = [[CatSearchTextFieldView alloc] initWithFrame:self.bounds];
        _tdView.backgroundColor = [UIColor clearColor];
        _tdView.singleLineField.leftViewMode = UITextFieldViewModeAlways;
        _tdView.singleLineField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _tdView.singleLineField.delegate = self;
        _tdView.singleLineField.returnKeyType = UIReturnKeySearch;
        _tdView.singleLineField.enablesReturnKeyAutomatically = YES;
        [_tdView.singleLineField addTarget:self action:@selector(searchTextChangedAction:) forControlEvents:UIControlEventEditingChanged];
    }else {
        _tdView.frame = self.bounds;
    }
    _tdView
        .LYSingleLineField
            .n2BackgroundColor(HEX(0xF7F7F7))
            .n2Radius(self.height * 0.5)
            .n2H(_tdView.height)
            .n2Left(_normalLeft).n2W(_originWidth);
    
    UIImage *leftImage = [UIImage imageNamed:@"common_gray_search"];
    if (leftImage) {
        UIImageView *searchIcon = [[UIImageView alloc] initWithImage:leftImage];
        searchIcon.contentMode = UIViewContentModeScaleAspectFit;
        searchIcon.frame = CGRectMake(0, 0, 30, 14);
        _tdView.singleLineField.leftView = searchIcon;
    }else {
        _tdView.singleLineField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, RH(26), self.height)];
    }
    _td = _tdView.singleLineField;
    if (!(_td.placeholder || _td.attributedPlaceholder)) {
        _td.c2Placeholder(@"输入关键词进行搜索");
    }
    [self addSubview:_tdView];
    
    [self _plusCancelButton];
    
    
    if (self.rightItems.count > 0) {
        for (int i = 0; i < self.rightItems.count; ++i) {
            [self addSubview:((UIView *)self.rightItems[i]).c2H(self.height).c2CenterY(_tdView.centerY)];
        }
        
        [self _adjustWhenhaveItems:self.state == CatSearchViewStateEditing];
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview) {
        if (!(self.option & CatSearchViewOptionLock)) {
            [self _setState:_state animated:YES];
        }
        
        if (self->_originTop == 0) {
            self->_originTop = self.top;
        }
        
        [self _plusCancelButton];
        if (self.rightItems.count > 0) {
            for (int i = 0; i < self.rightItems.count; ++i) {
                UIView *view = ((UIView *)self.rightItems[i]).c2H(self.height).c2CenterY(_tdView.centerY);
                [self addSubview:view];
            }
        }
    }
}
- (void)clearLenovoView {
    if (self.lenovoView.superview) {
        self.lenovoView.keyWords = @[];
        [self.lenovoView reloadData];
        [self.lenovoView.cc_sideView dismissViewAnimated:NO];
        [self.lenovoView removeFromSuperview];
    }
}

- (void)clearLenovoWithSearchView {
    self.td.text = @"";
    [self clearLenovoView];
}

- (void)_plusCancelButton {
    if ([self.delegate respondsToSelector:@selector(searchViewDidCancel:)]) {
        if (!_cancelButton) {
            CGRect frame = CGRectMake(_normalLeft + (_state == CatSearchViewStateEditing ? (_enlargeWidth + _editingRight) : (_originWidth + _normalRight)) , 0, 0, 0);
            _cancelButton = [UIButton new];
            _cancelButton
                .c2Text(@"取消")
                .c2Font(RF(15)).c2TextColor(HEX(0x333333))
                .c2Frame(frame).c2SizeToFit().c2H(self.height).c2CenterY(_tdView.centerY);
            [_cancelButton addTarget:self
                              action:@selector(cancelAction:)
                    forControlEvents:UIControlEventTouchUpInside];
        }
        [self addSubview:_cancelButton];
        CGRect frame = CGRectMake(_normalLeft + (_state == CatSearchViewStateEditing ? (_enlargeWidth + _editingRight) : (_originWidth + _normalRight)) , 0, 0, 0);
        _cancelButton.c2Frame(frame).c2SizeToFit().c2H(self.height).c2CenterY(_tdView.centerY);
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (!(self.option & CatSearchViewOptionLock)) {
        [self _setState:CatSearchViewStateEditing animated:YES];
    }
    
    if (self.category == CatSearchViewCategoryAutoHide) {
        if (self.customNavView == nil) {
            UIViewController *vc = [UIView cc_currentViewController];
            if (vc.navigationController) {
                [vc.navigationController setNavigationBarHidden:YES animated:YES];
            }
            [UIView animateWithDuration:0.33 animations:^{
               self.top = STATUS_BAR_HEIGHT + 4;
            }];
        }else {
            [UIView animateWithDuration:0.33 animations:^{
                self.customNavView.bottom = 0;
                self.top = STATUS_BAR_HEIGHT + 4;
            }];
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(searchViewDidBeginEditing:)]) {
        [self.delegate searchViewDidBeginEditing:self];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (!(self.option & CatSearchViewOptionLock)) {
        [self _setState:CatSearchViewStateNormal animated:YES];
    }
    
    if (self.category == CatSearchViewCategoryAutoHide) {
        if(self.customNavView == nil) {
            UIViewController *vc = [UIView cc_currentViewController];
            if (vc.navigationController) {
                [vc.navigationController setNavigationBarHidden:NO animated:YES];
            }
        }else {
            [UIView animateWithDuration:0.33 animations:^{
                self.customNavView.top = 0;
                self.top = self->_originTop;
            }];
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(searchViewDidEndEditing:)]) {
        [self.delegate searchViewDidEndEditing:self];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    BOOL rs = YES;
    if ([self.delegate respondsToSelector:@selector(searchViewShouldReturn:)]) {
        rs = [self.delegate searchViewShouldReturn:self];
    }
    /// 避免下次输入lastTimeString不触发代理事件
    _tdView.lastTimeString = nil;
    return rs;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(searchViewDidClear:)]) {
        return [self.delegate searchViewDidClear:self];
    }
    return YES;
}

- (void)searchTextChangedAction:(UITextField *)sender {
    CatSearchTextFieldView *sfView = (CatSearchTextFieldView *)sender.superview;
    if ([sender.text isEqualToString:sfView.lastTimeString]) {
        return;
    }
    
    sfView.lastTimeString = sender.text;
    if ([self.delegate respondsToSelector:@selector(searchViewDidChanged:value:)]) {
        [self.delegate searchViewDidChanged:self value:sender.text];
    }
}

- (void)cancelAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(searchViewDidCancel:)]) {
        [self.delegate searchViewDidCancel:self];
    }
}

- (void)setLenovoView:(CatSearchLenovoView *)lenovoView {
    _lenovoView = lenovoView;
    if (!_lenovoView.searchView) {
        _lenovoView.searchView = self;
    }
}

- (CGFloat)searchViewKey:(CatSearchViewKey)key {
    return [[_viewKeys objectForKey:key] doubleValue];
}

//- (void)setState:(CatSearchViewState)state {
//    [self _setState:state animated:NO];
//}

- (void)setState:(CatSearchViewState)state animated:(BOOL)animated {
    [self _setState:state animated:animated];
}

#pragma mark - Internal -
- (void)_setState:(CatSearchViewState)state animated:(BOOL)animated {
    @synchronized (self) {
        if (state == CatSearchViewStateEditing) {
            CGFloat enlargeWidth = self->_normalLeft + self->_enlargeWidth + self->_editingRight;
            [self _adjustWhenhaveItems:YES];
            if (animated) {
                [UIView animateWithDuration:0.33 animations:^{
                    self.cancelButton.left = enlargeWidth;
                    self.td.width = self->_enlargeWidth;
                    self.tdView.width = enlargeWidth;
                }];
            }else {
                self.cancelButton.left = enlargeWidth;
                self.td.width = self->_enlargeWidth;
                self.tdView.width = enlargeWidth;
            }
        }else if (state == CatSearchViewStateNormal){
            CGFloat originWidth = self->_normalLeft + self->_originWidth + self->_normalRight;
            if (animated) {
                [UIView animateWithDuration:0.33 animations:^{
                    self.cancelButton.left = originWidth;
                    self.td.width = self->_originWidth;
                    self.tdView.width = originWidth;
                    [self _adjustWhenhaveItems:NO];
                }];
            }else {
                self.cancelButton.left = originWidth;
                self.td.width = self->_originWidth;
                self.tdView.width = originWidth;
                [self _adjustWhenhaveItems:NO];
            }
        }
        _state = state;
    }
}

- (void)_adjustWhenhaveItems:(BOOL)isEdit {
    if (isEdit) {
        for (int i = 0; i < self.rightItems.count; ++i) {
            UIView *view = self.rightItems[i];
            view.hidden = YES;
        }
    }else {
        if ([self _rightItemsWiidth] > 0) {
            self.td.width = self->_originWidth - [self _rightItemsWiidth];
            self.tdView.width = self->_originWidth - [self _rightItemsWiidth];
            for (int i = 0; i < self.rightItems.count; ++i) {
                UIView *view = self.rightItems[i];
                if (i == 0) {
                    view.c2Left(self.td.right + RH(10)).c2Hidden(NO);
                }else {
                    view.c2Left(self.td.right + ((UIView *)self.rightItems[i-1]).width + RH(10)).c2Hidden(NO);
                }
            }
        }
    }
}

- (CGFloat)_rightItemsWiidth {
    CGFloat width = 0;
    if (self.rightItems.count > 0) {
        for (int i = 0; i < self.rightItems.count; ++i) {
            UIView *view = self.rightItems[i];
            width += view.width;
        }
    }
    return width;
}

@end

@implementation CatSearchView (Script)

- (void)scriptWithLenovoViewKeywords:(nullable NSArray *)keyWords lenovoeDelegate:(id<CatSearchLenovoViewDelegate>)searchLenovoDelegate {
    if (keyWords) {
        [self.lenovoView.cc_sideView dismissViewAnimated:NO];
        [self.lenovoView removeFromSuperview];
        
        CatSearchLenovoView *lenovoView = [CatSearchLenovoView getOne];
        lenovoView.delegate = searchLenovoDelegate;
        self.lenovoView = lenovoView;
        
        CatSideView *sv = self.lenovoView.cc_sideView.nextAnimated(NO).nextParentView([UIView cc_currentViewController].view);
        sv.deltaOffset = CGPointMake(0, self.bottom);
        sv.option = CatSideViewBehaviorOptionForceDismiss;
        [sv showWithDirection:CatSideViewDirectionTop];
        [sv.coverView removeFromSuperview];
        
        self.lenovoView.keyWords = keyWords;
        [self.lenovoView reloadData];
    }else {
        [self clearLenovoView];
    }
}

@end

CatSearchViewKey const CatSearchViewKeyNormalLeft = @"CatSearchViewKeyNormalLeft";
CatSearchViewKey const CatSearchViewKeyNormalRight = @"CatSearchViewKeyNormalRight";
CatSearchViewKey const CatSearchViewKeyEditingRight = @"CatSearchViewKeyEditingRight";
CatSearchViewKey const CatSearchViewKeyOriginWidth = @"CatSearchViewKeyOriginWidth";
CatSearchViewKey const CatSearchViewKeyEnlargeWidth = @"CatSearchViewKeyEnlargeWidth";
CGFloat CatSearchViewKeyAuto = -1;

NSNotificationName const CatSearchDidSelectRowNotification = @"CatSearchDidSelectRowNotification";
