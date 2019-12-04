//
//  CatSimpleView.h
//  LYCommonUI
//
//  Created by Liuyi on 2019/6/29.
//  Copyright © 2019 Shepherd. All rights reserved.
//

#import "CC_UIKit.h"
#import "CatSimpleLayout.h"

NS_ASSUME_NONNULL_BEGIN

#define DEFAULT_IMG(SIZE) [UIView cat_createImageWithSize:SIZE]
#define CAT_CELL(SUFFIX) [@"CatSimpleCell" stringByAppendingString:SUFFIX]

@interface CatSimpleView : CC_View {
    
@public
    __weak UIView *_;
}

@property (nonatomic,weak) id<CatSimpleViewLayoutDelegate> delegate;
@property (nonatomic,strong) CatSimpleLayout *layout;
@property (nonatomic,copy) NSString *identifier;

@property (nonatomic,strong) UIView *oneView;
@property (nonatomic,strong) UILabel *bigTitleLabel;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *descLabel;
@property (nonatomic,strong) UIImageView *icon;
@property (nonatomic,strong) UIImageView *tipIcon;
@property (nonatomic,strong) UIImageView *accessoryIcon;
@property (nonatomic,strong) UILabel *dateLabel;
@property (nonatomic,strong) UIView *separator;
@property (nonatomic,strong) UITextField *singleLineField;
@property (nonatomic,strong) UITextView *multiLineField;
@property (nonatomic,strong) UIButton *oneButton;
@property (nonatomic,strong) UIButton *cancelButton;
@property (nonatomic,strong) UIButton *closeButton;

/// 设置网络图片占位图
@property (nonatomic,strong) UIImage *placeholderImage;

///-------------------------------
/// @name Create
///-------------------------------

- (instancetype)LYSelf;
- (CatSimpleView *)LYOneView;
- (CatSimpleView *)LYBigTitleLabel;
- (CatSimpleView *)LYTitleLabel;
- (CatSimpleView *)LYDescLabel;
- (CatSimpleView *)LYIcon;
- (CatSimpleView *)LYTipIcon;
- (CatSimpleView *)LYAccessoryIcon;
- (CatSimpleView *)LYDateLabel;
- (CatSimpleView *)LYSepartor;
- (CatSimpleView *)LYSingleLineField;
- (CatSimpleView *)LYMultiLineField;
- (CatSimpleView *)LYOneButton;
- (CatSimpleView *)LYCloseButton;
- (CatSimpleView *)LYCancelButton;
- (CatSimpleView *(^)(UIView *))LYAdd;

- (CatSimpleView *(^)(NSString *))n2Text;
- (CatSimpleView *(^)(UIColor *))n2TextColor;
- (CatSimpleView *(^)(UIColor *))n2BackgroundColor;
- (CatSimpleView *(^)(CGFloat))n2Radius;
- (CatSimpleView *(^)(NSAttributedString *))n2AttributedText;
- (CatSimpleView *(^)(UIFont *))n2Font;
- (CatSimpleView *(^)(UIImage *))n2Image;
- (CatSimpleView *(^)(NSString *))n2Placeholder;
- (CatSimpleView *(^)(BOOL))n2UserInteractionEnabled;
- (CatSimpleView *(^)(CGFloat))n2BorderWidth;
- (CatSimpleView *(^)(UIColor *))n2BorderColor;
- (CatSimpleView *(^)(BOOL))n2Hidden;
- (CatSimpleView *(^)(CGFloat))n2Alpha;
- (CatSimpleView *(^)(CGFloat))n2Tag;
- (CatSimpleView *(^)(NSTextAlignment))n2TextAlignment;
- (CatSimpleView *(^)(NSInteger))n2Lines;
- (CatSimpleView *(^)(BOOL))n2Enabled;
- (CatSimpleView *(^)(UIViewContentMode))n2ContentMode;

///-------------------------------
/// @name Size Setter
///-------------------------------

- (CatSimpleView *(^)(CGRect))n2Frame;
- (CatSimpleView *(^)(CGFloat))n2W;
- (CatSimpleView *(^)(CGFloat))n2H;
- (CatSimpleView *(^)(void))n2SizeToFit;
- (CatSimpleView *(^)(CGFloat))n2Top;
- (CatSimpleView *(^)(CGFloat))n2Left;
- (CatSimpleView *(^)(CGFloat))n2Bottom;
- (CatSimpleView *(^)(CGFloat))n2Right;
- (CatSimpleView *(^)(CGPoint))n2Center;
- (CatSimpleView *(^)(CGFloat))n2CenterX;
- (CatSimpleView *(^)(CGFloat))n2CenterY;

///-------------------------------
/// @name UIButton Setter
///-------------------------------

- (CatSimpleView *(^)(UIControlState,UIColor *))n2BtnBackgroundColor;
- (CatSimpleView *(^)(UIControlState,NSString *))n2BtnText;
- (CatSimpleView *(^)(UIControlState,UIColor *))n2BtnTextColor;
- (CatSimpleView *(^)(UIControlState,UIImage *))n2BtnImage;
- (CatSimpleView *(^)(UIControlState,UIImage *))n2BtnBackgroundImage;

/**
 指定调用delegate的action方法进行布局

 @param delegate 代理对象
 @param action SEL方法
 */
- (void)setLayoutDelegate:(id<CatSimpleViewLayoutDelegate>)delegate action:(SEL)action;

@end

typedef CatSimpleView CatCombineView;


@interface UIView (CatSimpleView)

@property (nonatomic,strong) UIImage *catPlaceholderImage;

- (UIView *(^)(UIView *))c2Superview;
- (UIView *(^)(UIColor *))c2BackgroundColor;
- (UIView *(^)(CGFloat))c2Radius;
- (UIView *(^)(BOOL))c2UserInteractionEnabled;
- (UIView *(^)(UIColor *))c2BorderColor;
- (UIView *(^)(CGFloat))c2BorderWidth;
- (UIView *(^)(BOOL))c2Hidden;
- (UIView *(^)(CGFloat))c2Alpha;
- (UIView *(^)(CGFloat))c2Tag;
- (UIView *(^)(UIViewContentMode))c2ContentMode;

- (UIView *(^)(NSString *))c2Text;
- (UIView *(^)(UIColor *))c2TextColor;
- (UIView *(^)(NSAttributedString *))c2AttributedText;
- (UIView *(^)(UIFont *))c2Font;
- (UIView *(^)(NSString *))c2Placeholder;
- (UIView *(^)(NSTextAlignment))c2TextAlignment;
- (UIView *(^)(NSInteger))c2Lines;

- (UIView *(^)(UIImage *))c2Image;

- (UIView *(^)(BOOL))c2Enabled;
- (UIView *(^)(UIControlState,UIColor *))c2BtnBackgroundColor;
- (UIView *(^)(UIControlState,NSString *))c2BtnText;
- (UIView *(^)(UIControlState,UIColor *))c2BtnTextColor;
- (UIView *(^)(UIControlState,UIImage *))c2BtnImage;
- (UIView *(^)(UIControlState,UIImage *))c2BtnBackgroundImage;

///-------------------------------
/// @name Size Setter
///-------------------------------

- (UIView *(^)(CGRect))c2Frame;
- (UIView *(^)(void))c2SizeToFit;
- (UIView *(^)(CGFloat))c2W;
- (UIView *(^)(CGFloat))c2H;

/**
 上边距 = 参数值
 */
- (UIView *(^)(CGFloat))c2Top;

/**
 左边距 = 参数值
 */
- (UIView *(^)(CGFloat))c2Left;

/**
 上边距 = (容器视图高度 - 参数值 - 子视图高度)
 */
- (UIView *(^)(CGFloat))c2Bottom;

/**
 左边距 = (容器视图宽度 - 参数值 - 子视图宽度)
 */
- (UIView *(^)(CGFloat))c2Right;

- (UIView *(^)(CGPoint))c2Center;
- (UIView *(^)(CGFloat))c2CenterX;
- (UIView *(^)(CGFloat))c2CenterY;

@end

@interface UIView (CatPlaceholder)

+ (UIImage *)cat_createImageWithSize:(CGSize)size;
+ (UIImage *)cat_createImageWithSize:(CGSize)size color:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
