//
//  CatSimpleView.m
//  LYCommonUI
//
//  Created by Shepherd on 2019/6/29.
//  Copyright © 2019 Shepherd. All rights reserved.
//

#import "CatSimpleView.h"
#import <objc/message.h>
#import "CatSimpleLayout.h"
#import "UIView+CCWebImage.h"

@interface CatSimpleView () {
@private
   NSString *_action;
}

@end

@implementation CatSimpleView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if ([self.delegate respondsToSelector:NSSelectorFromString(self->_action)]) {
        SEL sel = NSSelectorFromString(self->_action);
        ((void(*)(id, SEL,id))objc_msgSend)(self.delegate,sel,self);
        return;
    }
    
    /// 一种cell
    if ([self.delegate respondsToSelector:@selector(layoutSimpleView:)]){
        [self.delegate layoutSimpleView:self];
    }else {
        /// 多种cell
        if (self.layout) {
            [self.layout layoutSimpleView:self];
        }else {
            // NSLog(@"缺少布局对象");
        }
    }
}

- (void)setLayoutDelegate:(id<CatSimpleViewLayoutDelegate>)delegate
                   action:(SEL)action {
    
    self.delegate = delegate;
    self->_action = NSStringFromSelector(action);
}

- (CatSimpleView *(^)(NSString *))n2Text {
    return ^(NSString *text){
        self->_.c2Text(text);
        return self;
    };
}

- (CatSimpleView *(^)(CGFloat))n2Alpha {
    return ^(CGFloat alpha){
        self->_.c2Alpha(alpha);
        return self;
    };
}

- (CatSimpleView *(^)(BOOL))n2UserInteractionEnabled {
    return ^(BOOL enable) {
        self->_.c2UserInteractionEnabled(enable);
        return self;
    };
}

- (CatSimpleView *(^)(UIColor *))n2BorderColor {
    return ^(UIColor *bdColor) {
        self->_.c2BorderColor(bdColor);
        return self;
    };
}

- (CatSimpleView *(^)(CGFloat))n2BorderWidth {
    return ^(CGFloat border) {
        self->_.c2BorderWidth(border);
        return self;
    };
}

- (CatSimpleView *(^)(CGFloat))n2Tag {
    return ^(CGFloat tag) {
        self->_.c2Tag(tag);
        return self;
    };
}

- (CatSimpleView *(^)(BOOL))n2Hidden {
    return ^(BOOL hidden) {
        self->_.c2Hidden(hidden);
        return self;
    };
}

- (CatSimpleView *(^)(UIFont *))n2Font {
    return ^(UIFont *font) {
        self->_.c2Font(font);
        return self;
    };
}

- (CatSimpleView *(^)(NSString *))n2Placeholder {
    return ^(NSString *placeholder) {
        self->_.c2Placeholder(placeholder);
        return self;
    };
}

- (CatSimpleView *(^)(UIColor *))n2TextColor {
    return ^(UIColor *color) {
        self->_.c2TextColor(color);
        return self;
    };
}

- (CatSimpleView *(^)(CGFloat))n2Radius {
    return ^(CGFloat radius){
        self->_.c2Radius(radius);
        return self;
    };
}

- (CatSimpleView *(^)(UIColor *))n2BackgroundColor {
    return ^(UIColor *bgColor) {
        self->_.c2BackgroundColor(bgColor);
        return self;
    };
}

- (CatSimpleView *(^)(NSAttributedString *))n2AttributedText {
    return ^(NSAttributedString *attrText) {
        self->_.c2AttributedText(attrText);
        return self;
    };
}

- (CatSimpleView *(^)(UIImage *))n2Image {
    return ^(UIImage *image) {
        self->_.c2Image(image);
        return self;
    };
}

- (CatSimpleView *(^)(NSInteger))n2Lines {
    return ^(NSInteger lines) {
        self->_.c2Lines(lines);
        return self;
    };
}

- (CatSimpleView *(^)(void))n2SizeToFit {
    return ^{
        self->_.c2SizeToFit();
        return self;
    };
}

- (CatSimpleView *(^)(UIControlState,UIColor *))n2BtnBackgroundColor {
    return ^(UIControlState state,UIColor *bgColor) {
        self->_.c2BtnBackgroundColor(state,bgColor);
        return self;
    };
}

- (CatSimpleView *(^)(UIControlState,NSString *))n2BtnText {
    return ^(UIControlState state,NSString *text){
        self->_.c2BtnText(state,text);
        return self;
    };
}

- (CatSimpleView *(^)(UIControlState,UIColor *))n2BtnTextColor {
    return ^(UIControlState state,UIColor *color) {
        self->_.c2BtnTextColor(state,color);
        return self;
    };
}

- (CatSimpleView *(^)(UIControlState,UIImage *))n2BtnImage {
    return ^(UIControlState state,UIImage *image) {
        self->_.c2BtnImage(state,image);
        return self;
    };
}

- (CatSimpleView *(^)(UIControlState,UIImage *))n2BtnBackgroundImage {
    return ^(UIControlState state,UIImage *bgImage){
        self->_.c2BtnBackgroundImage(state,bgImage);
        return self;
    };
}

- (CatSimpleView *(^)(BOOL))n2Enabled {
    return ^(BOOL enabled) {
        self->_.c2Enabled(enabled);
        return self;
    };
}

#pragma mark - Layout -
- (CatSimpleView *(^)(CGFloat))n2Left {
    return ^(CGFloat left){
        self->_.c2Left(left);
        return self;
    };
}

- (CatSimpleView *(^)(CGFloat))n2Right {
    return ^(CGFloat right) {
        self->_.c2Right(right);
        return self;
    };
}

- (CatSimpleView *(^)(CGRect))n2Frame {
    return ^(CGRect frame) {
        self->_.c2Frame(frame);
        return self;
    };
}

- (CatSimpleView *(^)(CGFloat))n2Top {
    return ^(CGFloat top){
        self->_.c2Top(top);
        return self;
    };
}

- (CatSimpleView *(^)(CGFloat))n2Bottom {
    return ^(CGFloat bottom){
        self->_.c2Bottom(bottom);
        return self;
    };
}

- (CatSimpleView * _Nonnull (^)(CGFloat))n2W {
    return ^(CGFloat width){        
        self->_.c2W(width);
        return self;
    };
}

- (CatSimpleView *(^)(CGFloat))n2H {
    return ^(CGFloat height){
        self->_.c2H(height);
        return self;
    };
}

- (CatSimpleView *(^)(CGPoint))n2Center {
    return ^(CGPoint point) {
        self->_.c2Center(point);
        return self;
    };
}

- (CatSimpleView *(^)(CGFloat))n2CenterX {
    return ^(CGFloat centerX) {
        self->_.c2CenterX(centerX);
        return self;
    };
}

- (CatSimpleView *(^)(CGFloat))n2CenterY {
    return ^(CGFloat centerY) {
        self->_.c2CenterY(centerY);
        return self;
    };
}

- (CatSimpleView *(^)(NSTextAlignment))n2TextAlignment {
    return ^(NSTextAlignment align) {
        self->_.c2TextAlignment(align);
        return self;
    };
}

- (CatSimpleView *(^)(UIViewContentMode))n2ContentMode {
    return ^(UIViewContentMode mode) {
        self->_.c2ContentMode(mode);
        return self;
    };
}

#pragma mark - LazyLoad -
- (CatSimpleView *)LYOneView {
    if (!_oneView) {
        [self addSubview:_oneView = [UIView new]];
    }
    self->_ = _oneView;
    return self;
}

- (CatSimpleView *(^)(UIView *))LYAdd {
    return ^(UIView *it){
        [self addSubview:it];
        self->_ = it;
        return self;
    };
}

- (instancetype)LYSelf {
    self->_ = self;
    return self;
}

- (CatSimpleView *)LYBigTitleLabel {
    if (!_bigTitleLabel) {
        [self addSubview:_bigTitleLabel = [UILabel new]];
    }
    _ = _bigTitleLabel;
    return self;
}

- (CatSimpleView *)LYTitleLabel {
    if (!_titleLabel) {
        [self addSubview:_titleLabel = [UILabel new]];
    }
    _ = _titleLabel;
    return self;
}

- (CatSimpleView *)LYDescLabel {
    if (!_descLabel) {
        [self addSubview:_descLabel = [UILabel new]];
    }
    _ = _descLabel;
    return self;
}

- (CatSimpleView *)LYIcon {
    if (!_icon) {
        [self addSubview:_icon = [UIImageView new]];
    }
    _ = _icon;
    return self;
}

- (CatSimpleView *)LYTipIcon {
    if (!_tipIcon) {
        [self addSubview:_tipIcon = [UIImageView new]];
    }
    _ = _tipIcon;
    return self;
}

- (CatSimpleView *)LYAccessoryIcon {
    if (!_accessoryIcon) {
        [self addSubview:_accessoryIcon = [UIImageView new]];
    }
    _ = _accessoryIcon;
    return self;
}

- (CatSimpleView *)LYDateLabel {
    if (!_dateLabel) {
        [self addSubview:_dateLabel = [UILabel new]];
    }
    _ = _dateLabel;
    return self;
}

- (CatSimpleView *)LYSepartor {
    if (!_separator) {
        [self addSubview:_separator = [UIView new]];     
    }
    _ = _separator;
    return self;
}

- (CatSimpleView *)LYSingleLineField {
    if (!_singleLineField) {
        [self addSubview:_singleLineField = [UITextField new]];
    }
    _ = _singleLineField;
    return self;
}

- (CatSimpleView *)LYMultiLineField {
    if (!_multiLineField) {
        [self addSubview:_multiLineField = [UITextView new]];
    }
    _ = _multiLineField;
    return self;
}

- (CatSimpleView *)LYOneButton {
    if (!_oneButton) {
        [self addSubview:_oneButton = [UIButton new]];
    }
     _ = _oneButton;
    return self;
}

- (CatSimpleView *)LYCancelButton {
    if (!_cancelButton) {
        [self addSubview:_cancelButton = [UIButton new]];
    }
    _ = _cancelButton;
    return self;
}

- (CatSimpleView *)LYCloseButton {
    if (!_closeButton) {
        [self addSubview:_closeButton = [UIButton new]];
    }
    _ = _closeButton;
    return self;
}

@end

@implementation UIView (CatSimpleView)

#pragma mark - UIView -

- (UIView *(^)(UIColor *))c2BackgroundColor {
    return ^(UIColor *bgColor) {
        if ([self isKindOfClass:[UIButton class]]) {
            self.c2BtnBackgroundColor(UIControlStateNormal,bgColor);
        }else if ([self respondsToSelector:@selector(setBackgroundColor:)]){
            SEL sel = @selector(setBackgroundColor:);
            ((void(*)(id, SEL,id))objc_msgSend)(self, sel,bgColor);
        }
        return self;
    };
}

- (UIView *(^)(CGFloat))c2Radius {
    return ^(CGFloat radius){
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = radius;
        return self;
    };
}

- (UIView *(^)(BOOL))c2UserInteractionEnabled {
    return ^(BOOL enable) {
        self.userInteractionEnabled = enable;
        return self;
    };
}

- (UIView *(^)(UIColor *))c2BorderColor {
    return ^(UIColor *bdColor) {
        self.layer.borderColor = bdColor.CGColor;
        return self;
    };
}

- (UIView *(^)(CGFloat))c2BorderWidth {
    return ^(CGFloat border) {
        self.layer.borderWidth = border;
        return self;
    };
}

- (UIView *(^)(BOOL))c2Hidden {
    return ^(BOOL hidden) {
        self.layer.hidden = hidden;
        return self;
    };
}

- (UIView *(^)(CGFloat))c2Alpha {
    return ^(CGFloat alpha){
        self.alpha = alpha;
        return self;
    };
}

- (UIView *(^)(CGFloat))c2Tag {
    return ^(CGFloat tag) {
        self.tag = tag;
        return self;
    };
}

- (UIView *(^)(UIViewContentMode))c2ContentMode {
    return ^(UIViewContentMode mode) {
        self.contentMode = mode;
        return self;
    };
}

#pragma mark - RW View -

- (UIView *(^)(NSString *))c2Text {
    return ^(NSString *text){
        if ([self isKindOfClass:[UIButton class]]) {
            [((UIButton *)self) setTitle:text forState:UIControlStateNormal];
        }else if ([self isKindOfClass:[UIImageView class]]) {
            if([text hasPrefix:@"http"]) {
                [((UIImageView *)self) cc_setImageWithURL:[NSURL URLWithString:text] placeholderImage:self.catPlaceholderImage];
            }else if ([text hasPrefix:@"file"]){
                ((UIImageView *)self).image = [UIImage imageWithContentsOfFile:text];
            }else {
                ((UIImageView *)self).image = [UIImage imageNamed:text];
            }
        }else if ([self respondsToSelector:@selector(setText:)]){
            SEL sel = @selector(setText:);
            ((void(*)(id, SEL,id))objc_msgSend)(self, sel,text);
        }
        
        return self;
    };
}

- (UIView *(^)(UIColor *))c2TextColor {
    return ^(UIColor *color) {
        if ([self respondsToSelector:@selector(setTextColor:)]){
            SEL sel = @selector(setTextColor:);
            ((void(*)(id, SEL,id))objc_msgSend)(self, sel,color);
        }else if([self isKindOfClass:[UIButton class]]) {
            [((UIButton *)self) setTitleColor:color forState:UIControlStateNormal];
        }
        return self;
    };
}

- (UIView *(^)(NSAttributedString *))c2AttributedText {
    return ^(NSAttributedString *attrText) {
        if ([self isKindOfClass:[UIButton class]]) {
            [((UIButton *)self) setAttributedTitle:attrText forState:UIControlStateNormal];
        } else if ([self respondsToSelector:@selector(setAttributedText:)]){
            SEL sel = @selector(setAttributedText:);
            ((void(*)(id, SEL,id))objc_msgSend)(self, sel,attrText);
        }
        return self;
    };
}

- (UIView *(^)(UIFont *))c2Font {
    return ^(UIFont *font) {
        if ([self isKindOfClass:[UIButton class]]) {
            ((UIButton *)self).titleLabel.font = font;
        }else if([self respondsToSelector:@selector(setFont:)]) {
            SEL sel = @selector(setFont:);
            ((void(*)(id, SEL,id))objc_msgSend)(self, sel,font);
        }
        return self;
    };
}

- (UIView *(^)(NSString *))c2Placeholder {
    return ^(NSString *placeholder) {
        if ([self respondsToSelector:@selector(setPlaceholder:)]){
            SEL sel = @selector(setPlaceholder:);
            ((void(*)(id, SEL,id))objc_msgSend)(self, sel,placeholder);
        }
        return self;
    };
}

- (UIView *(^)(NSTextAlignment))c2TextAlignment {
    return ^(NSTextAlignment align) {
        if ([self isKindOfClass:[UIButton class]]) {
            ((UIButton *)self).titleLabel.textAlignment = align;
        }else if ([self respondsToSelector:@selector(setTextAlignment:)]){
            SEL sel = @selector(setTextAlignment:);
            ((void(*)(id, SEL,NSTextAlignment))objc_msgSend)(self, sel,align);
        }
        return self;
    };
}

- (UIView *(^)(NSInteger))c2Lines {
    return ^(NSInteger lines) {
        if ([self isKindOfClass:[UIButton class]]) {
            ((UIButton *)self).titleLabel.numberOfLines = lines;
        }else if ([self respondsToSelector:@selector(setNumberOfLines:)]) {
            SEL sel = @selector(setNumberOfLines:);
            ((void(*)(id, SEL,NSInteger))objc_msgSend)(self, sel,lines);
        }
        return self;
    };
}

- (UIView *(^)(UIImage *))c2Image {
    return ^(UIImage *image) {
        if ([self isKindOfClass:[UIButton class]]) {
            [((UIButton *)self) setImage:image forState:UIControlStateNormal];
        }else if ([self respondsToSelector:@selector(setImage:)]) {
            SEL sel = @selector(setImage:);
            ((void(*)(id, SEL,id))objc_msgSend)(self, sel,image);
        }
        return self;
    };
}

- (UIView *(^)(UIView *))c2Superview {
    return ^(UIView *sview) {
        [sview addSubview:self];
        return self;
    };
}

#pragma mark - UIButton -

- (UIView *(^)(BOOL))c2Enabled {
    return ^(BOOL enabled) {
        if ([self respondsToSelector:@selector(setEnabled:)]) {
            SEL sel = @selector(setEnabled:);
            ((void(*)(id, SEL,BOOL))objc_msgSend)(self, sel,enabled);
        }
        return self;
    };
}

- (UIView *(^)(UIControlState,UIColor *))c2BtnBackgroundColor {
    return ^(UIControlState state,UIColor *bgColor) {
        CGRect rect = {CGPointZero,{1,1}};
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, [bgColor CGColor]);
        CGContextFillRect(context, rect);
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        if ([self respondsToSelector:@selector(setBackgroundImage:forState:)]){
            SEL sel = @selector(setBackgroundImage:forState:);
            ((void(*)(id, SEL,id,UIControlState))objc_msgSend)(self, sel,image,state);
        }
        return self;
    };
}

- (UIView *(^)(UIControlState,NSString *))c2BtnText {
    return ^(UIControlState state,NSString *text){
        if ([self respondsToSelector:@selector(setTitle:forState:)]){
            SEL sel = @selector(setTitle:forState:);
            ((void(*)(id, SEL,id,UIControlState))objc_msgSend)(self, sel,text,state);
        }
        return self;
    };
}

- (UIView *(^)(UIControlState,UIColor *))c2BtnTextColor {
    return ^(UIControlState state,UIColor *color) {
        if ([self respondsToSelector:@selector(setTitleColor:forState:)]){
            SEL sel = @selector(setTitleColor:forState:);
            ((void(*)(id, SEL,id,UIControlState))objc_msgSend)(self, sel,color,state);
        }
        return self;
    };
}

- (UIView *(^)(UIControlState,UIImage *))c2BtnImage {
    return ^(UIControlState state,UIImage *image) {
        if ([self respondsToSelector:@selector(setImage:forState:)]){
            SEL sel = @selector(setImage:forState:);
            ((void(*)(id, SEL,id,UIControlState))objc_msgSend)(self, sel,image,state);
        }
        return self;
    };
}

- (UIView *(^)(UIControlState,UIImage *))c2BtnBackgroundImage  {
    return ^(UIControlState state,UIImage *bgImage){
        if ([self respondsToSelector:@selector(setBackgroundImage:forState:)]){
            SEL sel = @selector(setBackgroundImage:forState:);
            ((void(*)(id, SEL,id,UIControlState))objc_msgSend)(self, sel,bgImage,state);
        }
        return self;
    };
}

#pragma mark - UIViewGeometry -

- (UIView *(^)(CGRect))c2Frame {
    return ^(CGRect frame) {
        self.frame = frame;
        return self;
    };
}

- (UIView *(^)(void))c2SizeToFit {
    return ^{
        [self sizeToFit];
        return self;
    };
}

- (UIView *(^)(CGFloat))c2W {
    return ^(CGFloat width){
        [self _setFrameKey:2 withValue:width];
        return self;
    };
}

- (UIView *(^)(CGFloat))c2H {
    return ^(CGFloat height){
        [self _setFrameKey:3 withValue:height];
        return self;
    };
}

- (UIView *(^)(CGFloat))c2Top {
    return ^(CGFloat top){
        [self _setFrameKey:1 withValue:top];
        return self;
    };
}

- (UIView *(^)(CGFloat))c2Left {
    return ^(CGFloat left){
        [self _setFrameKey:0 withValue:left];
        return self;
    };
}

- (UIView *(^)(CGFloat))c2Bottom {
    return ^(CGFloat bottom){
        [self _setFrameKey:1 withValue:self.superview.height - bottom - self.height];
        return self;
    };
}

- (UIView *(^)(CGFloat))c2Right {
    return ^(CGFloat right) {
        [self _setFrameKey:0 withValue:self.superview.width - right - self.width];
        return self;
    };
}

- (UIView *(^)(CGPoint))c2Center {
    return ^(CGPoint point) {
        self.center = point;
        return self;
    };
}

- (UIView *(^)(CGFloat))c2CenterX {
    return ^(CGFloat centerX) {
        self.centerX = centerX;
        return self;
    };
}

- (UIView *(^)(CGFloat))c2CenterY {
    return ^(CGFloat centerY) {
        self.centerY = centerY;
        return self;
    };
}

#pragma mark -
- (UIImage *)catPlaceholderImage {
    return objc_getAssociatedObject(self, @selector(catPlaceholderImage));
}

- (void)setCatPlaceholderImage:(UIImage *)placeholderImage {
    objc_setAssociatedObject(self, @selector(catPlaceholderImage), placeholderImage, OBJC_ASSOCIATION_RETAIN);
}

- (void)_setFrameKey:(int)key withValue:(CGFloat)value {
    CGRect frame = self.frame;
    if (key == 0) {
        frame.origin.x = value;
    }
    
    if (key == 1) {
        frame.origin.y = value;
    }
    
    if (key == 2) {
        frame.size.width = value;
    }
    
    if (key == 3) {
        frame.size.height = value;
    }
    
    self.frame = frame;
}

@end

@implementation UIView (CatPlaceholder)

+ (UIImage *)cat_createImageWithSize:(CGSize)size {
    return [self cat_createImageWithSize:size color:[UIColor groupTableViewBackgroundColor]];
}

+ (UIImage *)cat_createImageWithSize:(CGSize)size
                              color:(UIColor *)color {
    CGRect rect = {CGPointZero,size};
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
