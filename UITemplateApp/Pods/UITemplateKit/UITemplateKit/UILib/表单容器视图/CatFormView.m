//
//  CatFormView.m
//  UITemplateKit
//
//  Created by Shepherd on 2019/7/7.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatFormView.h"
#import "ccs.h"
#import "CatTofuView.h"
#import "CatSideView.h"

@interface CatFormView () <UIScrollViewDelegate,UITextFieldDelegate,UITextViewDelegate> {
@private
    NSInteger _rows;
    NSInteger _currentRow;
    CatSimpleView *_btnView;
    __weak UIButton *_submitButton;
    NSMutableDictionary *_infoDictionary;
    NSMutableDictionary *_requiredDictionary;
}

@property (nonatomic,strong) UIScrollView *scrollView;

@end

@implementation CatFormView

// MARK: - LifeCycle -

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _commonInit];
    }
    return self;
}

- (void)_commonInit {
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self.scrollView cc_kdAdapterWithOffset:CGPointMake(0, 20)];
    
    self.scrollView.delegate = self;
    [self addSubview:self.scrollView];
    
    CGFloat estimatedRowHeight = 44;
    self.estimatedRowHeight = estimatedRowHeight;
    
    self->_btnView = [[CatSimpleView alloc] initWithFrame:CGRectMake(0, 0, self.width, 66)];
    self->_btnView
        .LYSelf
            .n2BackgroundColor(UIColor.whiteColor)
        .LYOneButton
            .n2Text(@"提交")
            .n2TextColor(UIColor.whiteColor).n2BackgroundColor([UIColor blueColor])
            .n2Radius(22)
            .n2H(estimatedRowHeight).n2Left(RH(16)).n2W(WIDTH() - RH(16) * 2);
    _submitButton = self->_btnView.oneButton;
    
    [_submitButton addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboardAction:)]];
    
    _infoDictionary = [NSMutableDictionary dictionary];
    _requiredDictionary = [NSMutableDictionary dictionary];
    _combineScroll = YES;
    _scrollable = YES;
}


+ (instancetype)formViewWithFrame:(CGRect)frame
                submitBtnBgColors:(NSArray *)colors
                     cornerRadius:(CGFloat)radius {
    
    CatFormView *formView = [[self alloc] initWithFrame:frame];
    
    if (radius > 0) {
        formView.submitButton.layer.cornerRadius = radius;
        formView.submitButton.layer.masksToBounds = YES;
    }
    
    if ([colors isKindOfClass:NSArray.class]) {
        if (colors.count == 2) {
            if ([colors.firstObject isKindOfClass:UIImage.class]) {
                UIImage *image = (UIImage *)colors.firstObject;
                [formView.submitButton setBackgroundImage:image forState:UIControlStateNormal];
            }else if ([colors.firstObject isKindOfClass:UIColor.class]) {
                [formView.submitButton cc_setBackgroundColor:colors.firstObject forState:UIControlStateNormal];
            }
            
            if ([colors.lastObject isKindOfClass:UIImage.class]) {
                UIImage *image = (UIImage *)colors.lastObject;
                [formView.submitButton setBackgroundImage:image forState:UIControlStateDisabled];
            }else if ([colors.lastObject isKindOfClass:UIColor.class]) {
                [formView.submitButton cc_setBackgroundColor:colors.lastObject forState:UIControlStateDisabled];
            }
            
             formView.submitButton.enabled = NO;
        }else if (colors.count == 1) {
            if ([colors.lastObject isKindOfClass:UIImage.class]) {
                UIImage *image = (UIImage *)colors.lastObject;
                [formView.submitButton setBackgroundImage:image forState:UIControlStateNormal];
            }else if ([colors.lastObject isKindOfClass:UIColor.class]) {
                [formView.submitButton cc_setBackgroundColor:colors.lastObject forState:UIControlStateNormal];
            }
            
            formView.submitButton.enabled = YES;
        }
    }
    
    
    
    return formView;
}

+ (CGRect)formRect {
    return CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, WIDTH(), HEIGHT() - STATUS_AND_NAV_BAR_HEIGHT);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
}


// MARK: - Public -
- (void)reloadData {
    CGFloat minY = 0;
    if (self.formHeaderView) {
        [self.scrollView addSubview:self.formHeaderView];
        minY = self.formHeaderView.height;
    }
    if ([self.datasource respondsToSelector:@selector(rowsInFormView)]) {
        _rows = [self.datasource rowsInFormView];
    }
    
    if (_rows > 0) {
        
        for (int i = 0; i < _rows; ++i) {
            if ([self.datasource respondsToSelector:@selector(formView:atRow:)]) {
                CatSimpleView *sview = [self.datasource formView:self atRow:i];
                NSParameterAssert(sview);
                
                sview.top = minY;
                if (!(sview.height > 0)) {
                    sview.height = self.estimatedRowHeight;
                }
                sview.width = self.width;
                
                BOOL editable = YES;
                BOOL canSelect = NO;
                
                CatFormSubType subType = CatFormSubTypeCustom;
                if ([sview isKindOfClass:[CatSingleLineView class]]) {
                    editable = ((CatSingleLineView *)sview).editable;
                    subType = CatFormSubTypeSingle;
                }else if ([sview isKindOfClass:[CatMultiLineView class]]) {
                    subType = CatFormSubTypeMulti;
                    editable = ((CatSingleLineView *)sview).editable;
                }else if ([sview isKindOfClass:[CatTofuView class]]){
                    subType = CatFormSubTypeTofu;
                }
                
                minY += sview.height;
                [self.scrollView addSubview:sview];
                
                if ([self.delegate respondsToSelector:@selector(formView:shouldEditableAtRow:)]) {
                    editable = [self.delegate formView:self shouldEditableAtRow:i];
                    if (editable) {
                        if (subType == CatFormSubTypeSingle) {
                            ((CatSingleLineView *)sview).editable = YES;
                        } else if (subType == CatFormSubTypeMulti){
                            ((CatMultiLineView *)sview).editable = YES;
                        }
                    }
                }
                
                if (editable == NO) {
                    if (subType == CatFormSubTypeSingle) {
                        ((CatSingleLineView *)sview).editable = NO;
                    }else if (subType == CatFormSubTypeMulti){
                        ((CatMultiLineView *)sview).editable = NO;
                    }
                    canSelect = YES;
                }
                
                [sview removeGestureRecognizer:sview.gestureRecognizers.lastObject];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
                tap.enabled = NO;
                [sview addGestureRecognizer:tap];
                
                if ([self.delegate respondsToSelector:@selector(formView:shouldSelectAtRow:)]) {
                    canSelect = [self.delegate formView:self shouldSelectAtRow:i];
                }
                
                if (canSelect) {
                    tap.enabled = YES;
                }
                
                /// 若被锁定则隐藏accessoryIcon
                if (editable == NO && canSelect == NO) {
                    if (subType == CatFormSubTypeSingle) {
                        ((CatSingleLineView *)sview).accessoryIcon.hidden = YES;
                    }
                }
            }
        }
        
        _submitButton.top = 11;
        _btnView.height = _submitButton.height + 22;
        
        if([self.datasource respondsToSelector:@selector(formView:customSubmitView:)]) {
            [self.datasource formView:self customSubmitView:self->_btnView];
        }
        if (_combineScroll == NO) {
            [self addSubview:self->_btnView];
            self.scrollView.height -= self->_btnView.height;
            _btnView.top = self.scrollView.height;
        }else {                    
            _btnView.top = minY + self.submitTopSpacing;
            [self.scrollView addSubview:self->_btnView];
        }
        minY += self->_btnView.height;
    }
    
    if (self.formFooterView) {
        [self.scrollView addSubview:_formFooterView];
        _formFooterView.top = minY;
        minY += _formFooterView.height;
    }
    
    _scrollView.contentSize = CGSizeMake(self.width, minY + _scrollable);
    if(_scrollable) {
        _scrollView.contentSize = CGSizeMake(self.width, MAX(minY,self.height) + _scrollable);
    }
}

- (CatMultiLineView *)multiLineViewWithIndex:(NSInteger)index {
    for (UIView *sview in self.scrollView.subviews) {
        if ([sview isKindOfClass:[CatMultiLineView class]]) {
            if (sview.tag == index) {
                return (CatMultiLineView *)sview;
            }
        }
    }
    return nil;
}

- (CatSingleLineView *)singleLineViewWithIndex:(NSInteger)index {
    for (UIView *sview in self.scrollView.subviews) {
        if ([sview isKindOfClass:[CatSingleLineView class]]) {
            if (sview.tag == index) {
                return (CatSingleLineView *)sview;
            }
        }
    }
    return nil;
}

- (CatTofuView *)tofuViewWithIndex:(NSInteger)index {
    for (UIView *sview in self.scrollView.subviews) {
        if ([sview isKindOfClass:CatTofuView.class]) {
            if (sview.tag == index) {
                return (CatTofuView *)sview;
            }
        }
    }
    return nil;
}

- (__kindof CatSimpleView *)formSubviewForIndex:(NSInteger)index {
    for (UIView *sview in self.scrollView.subviews) {
        if ([sview isEqual:self.formHeaderView]) {
            continue;
        }
        
        if ([sview isEqual:self.formFooterView]) {
            continue;
        }
        
        if ([sview isKindOfClass:[CatSimpleView class]]) {
            if (sview.tag == index) {
                return (CatSimpleView *)sview;
            }
        }
    }
    return nil;
}

- (__kindof CatSimpleView *)dequeueReusableViewWithSubType:(CatFormSubType)subType
                                                     atRow:(NSInteger)row {
    if (subType == CatFormSubTypeSingle) {
        CatSimpleView *sview = [self dequeueReusableSingleLineViewWithIndex:row];
        if (!sview.singleLineField.delegate) {
            sview.singleLineField.delegate = self;
        }
        NSArray *actions = [sview.singleLineField actionsForTarget:self forControlEvent:UIControlEventEditingChanged];
        BOOL isExisted = NO;
        for (NSString *action in actions) {
            if ([action isEqualToString:@"singleLineEditingChangedAction:"]) {
                isExisted = YES;
                break;
            }
        }
        if (isExisted == NO) {
            [sview.singleLineField addTarget:self action:@selector(singleLineEditingChangedAction:) forControlEvents:UIControlEventEditingChanged];
        }
        return sview;
    }else if (subType == CatFormSubTypeMulti) {
        CatMultiLineView *sview = [self dequeueReusableMultiLineViewWithIndex:row];
        if (!sview.multiLineField.delegate) {
            sview.multiLineField.delegate = self;
        }
        return sview;
    }else if (subType == CatFormSubTypeTofu) {
        CatTofuView *sview = [self dequeueReusableTofuViewWithIndex:row];
        return sview;
    }
    
    for (CatSimpleView *view in self.scrollView.subviews) {
        if ([view isMemberOfClass:[CatSimpleView class]] && view.tag == row) {
            return view;
        }
    }
    
    CatSimpleView *sview = [CatSimpleView new];
    sview.tag = row;
    return sview;
}

- (void)allowSubmitTest {    
    [self _submit];
}

- (void)sendEditingChangedActionWithModel:(id)model {    
    if ([self.delegate respondsToSelector:@selector(formView:editingChangedView:value:atRow:)]) {
        CatFormSubview *formSubview = [self formSubviewForIndex:self.currentRow];
        [self.delegate formView:self editingChangedView:formSubview value:model atRow:self.currentRow];
    }
}

- (void)setFormKey:(NSString *)key forValue:(NSString *)value optional:(BOOL)optional {
    if (optional) {
        if ([ccs function_isEmpty:value]) {
            [_infoDictionary removeObjectForKey:key];
        }else {
            [_infoDictionary setObject:value forKey:key];
        }
    }else {
        if ([ccs function_isEmpty:value]) {
            [_requiredDictionary removeObjectForKey:key];
        }else {
            [_requiredDictionary setObject:value forKey:key];
        }
        [self _submit];
    }
}

// MARK: - Internal -

- (void)_submit {
    BOOL canSubmit = NO;
    if ([self.delegate respondsToSelector:@selector(formViewShouldSubmit:required:info:)]) {
        canSubmit = [self.delegate formViewShouldSubmit:self required:_requiredDictionary info:_infoDictionary];
    }
    
    if (canSubmit) {
        self.submitButton.enabled = YES;
    }else {
        self.submitButton.enabled = NO;
    }
}

- (void)submitAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(formView:submit:required:info:)]) {
        [self.delegate formView:self submit:self.submitButton required:self.requiredDictionary info:self.infoDictionary];
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview) {
        [self reloadData];
    }
}

- (CatSingleLineView *)dequeueReusableSingleLineViewWithIndex:(NSInteger)index {
    CatSingleLineView *s = [self singleLineViewWithIndex:index];
    if (s == nil) {
        s = [CatSingleLineView new];
        s.tag = index;
    }
    return s;
}

- (CatMultiLineView *)dequeueReusableMultiLineViewWithIndex:(NSInteger)index {
    CatMultiLineView *s = [self multiLineViewWithIndex:index];
    if (s == nil) {
        s = [CatMultiLineView new];
        s.tag = index;
    }
    return s;
}

- (CatTofuView *)dequeueReusableTofuViewWithIndex:(NSInteger)index {
    CatTofuView *s = [self tofuViewWithIndex:index];
    if (s == nil) {
        s = [CatTofuView new];
        s.tag = index;
    }
    return s;
}

- (void)hideKeyboardAction:(UITapGestureRecognizer *)sender {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (void)tapAction:(UITapGestureRecognizer *)sender {
    _currentRow = sender.view.tag;
    
    [self changeReturnKey];
    
    if ([self.delegate respondsToSelector:@selector(formView:didSelectAtRow:)]) {
        [self.delegate formView:self didSelectAtRow:sender.view.tag];
    }
}

/// 写法待优化
- (void)changeReturnKey {
    CatFormSubview *curNode = [self formSubviewForIndex:self.currentRow];
    
    if ([self nextInputView:YES]) {
        if ([curNode isKindOfClass:CatSingleLineView.class]) {
            CatSingleLineView *sview = (CatSingleLineView *)curNode;
            sview.singleLineField.returnKeyType = UIReturnKeyNext;
        }
    }
    
    else {
        if ([curNode isKindOfClass:CatSingleLineView.class]) {
            CatSingleLineView *sview = (CatSingleLineView *)curNode;
            sview.singleLineField.returnKeyType = UIReturnKeyDefault;
        }
    }
}

- (nullable __kindof CatFormSubview *)nextInputView:(BOOL)needEditable {
    NSUInteger next = self.currentRow + 1;
    CatFormSubview *nextSubview = [self formSubviewForIndex:next];
    /// 遍历查找 找到下一项(可编辑)?的单行/多行
    while (nextSubview) {
        if ([nextSubview isKindOfClass:CatSingleLineView.class] ||
            [nextSubview isKindOfClass:CatMultiLineView.class]) {
            if (needEditable) {
                if ([nextSubview respondsToSelector:@selector(isEditable)] && [[nextSubview valueForKey:@"isEditable"] boolValue]) {
                    break;
                }
            }else {
                break;
            }
        }
        nextSubview = [self formSubviewForIndex:next++];
    }
    
    return nextSubview;
}

// MARK: - UIScrollViewDelegate -
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [scrollView endEditing:YES];
}

// MARK: - UITextFieldDelegate -
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    _currentRow = textField.superview.tag;
    
    [self changeReturnKey];
    
    if ([self.delegate respondsToSelector:@selector(formView:didSelectAtRow:)]) {
        [self.delegate formView:self didSelectAtRow:textField.superview.tag];
    }
}

- (void)singleLineEditingChangedAction:(UITextField *)sender {
    CatSingleLineView *singLineView = [self singleLineViewWithIndex:sender.superview.tag];
    if ([sender.text isEqualToString:singLineView.lastTimeString]) {
        return;
    }
    
    if(sender.text.length > singLineView.maxCount) {
        sender.text = [sender.text substringWithRange:NSMakeRange(0, singLineView.maxCount)];
    }
    
    singLineView.lastTimeString = sender.text;
    
    if ([self.delegate respondsToSelector:@selector(formView:editingChangedView:value:atRow:)]) {
        [self.delegate formView:self editingChangedView:(CatSimpleView *)sender.superview value:sender.text atRow:sender.superview.tag];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    CatFormSubview *nextSubview = [self nextInputView:YES];
    if (nextSubview) {
        if ([nextSubview isKindOfClass:CatSingleLineView.class]) {
            if ([nextSubview respondsToSelector:@selector(isEditable)] && [[nextSubview valueForKey:@"isEditable"] boolValue] ) {
                [((CatSingleLineView *)nextSubview).singleLineField becomeFirstResponder];
#warning Relax
//                [self.scrollView cc_replay];
            }
            /**
            else {
                UITapGestureRecognizer *tap = nextSubview.gestureRecognizers.lastObject;
                if (tap.enabled) {
                    [textField resignFirstResponder];
                    [self tapAction:nextSubview.gestureRecognizers.lastObject];
                }
            }
             */
        }else if ([nextSubview isKindOfClass:CatMultiLineView.class]) {
            [((CatMultiLineView *)nextSubview).multiLineField becomeFirstResponder];
            #warning Relax
//            [self.scrollView cc_replay];
        }
    }
    
//    else {
//        [textField resignFirstResponder];
//    }
    
    return YES;
}

// MARK: - UITextViewDelegate -
- (void)textViewDidBeginEditing:(UITextView *)textView {
    _currentRow = textView.superview.tag;
    
    CatMultiLineView *multiLineView = [self multiLineViewWithIndex:textView.superview.tag];    
    multiLineView.inputPlaceholderLabel.hidden = YES;
    
    [self changeReturnKey];
    
    if ([self.delegate respondsToSelector:@selector(formView:didSelectAtRow:)]) {
        [self.delegate formView:self didSelectAtRow:textView.superview.tag];
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    CatMultiLineView *multiLineView = [self multiLineViewWithIndex:textView.superview.tag];
    if ([textView.text isEqualToString:multiLineView.lastTimeString]) {
        return;
    }
    
    if(textView.text.length > multiLineView.maxCount) {
        textView.text = [textView.text substringWithRange:NSMakeRange(0, multiLineView.maxCount)];
    }
    
    multiLineView.lastTimeString = textView.text;
    
    if ([self.delegate respondsToSelector:@selector(formView:editingChangedView:value:atRow:)]) {
        [self.delegate formView:self editingChangedView:(CatSimpleView *)textView.superview value:textView.text atRow:textView.superview.tag];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    CatMultiLineView *multiLineView = [self multiLineViewWithIndex:textView.superview.tag];
    if ([ccs function_isEmpty:textView.text]) {
        multiLineView.inputPlaceholderLabel.hidden = NO;
    }
}

@end

@implementation CatFormView (CCDeprecated)

- (void)setFormKey:(NSString *)key forValue:(NSString *)value {
    if ([[self formSubviewForIndex:_currentRow] respondsToSelector:@selector(optional)]) {
        [self setFormKey:key forValue:value optional:((CatSingleLineView *)[self formSubviewForIndex:_currentRow]).optional];
    }else {
        [self setFormKey:key forValue:value optional:NO];
    }
}

@end

@implementation UIView (CatFormView)

- (nullable CatFormView *)cc_formView {
    UIView *nR = (UIView *)self.nextResponder;
    while (nR) {
        if ([nR isKindOfClass:CatFormView.class]) {
            return (CatFormView *)nR;
        }
        nR = (UIView *)nR.nextResponder;
    }
    
    return nil;
}

@end
