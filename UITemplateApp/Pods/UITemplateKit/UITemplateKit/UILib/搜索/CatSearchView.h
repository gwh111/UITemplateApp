//
//  CatSearchView.h
//  UITemplateKit
//
//  Created by ml on 2019/7/12.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CatSearchLenovoView.h"

NS_ASSUME_NONNULL_BEGIN

@class CatSearchView;

typedef NSString * CatSearchViewKey NS_TYPED_ENUM;

/// 指定预留给左侧的间距(比如返回按钮) RH(16) 右边同样预留RH(16)
UIKIT_EXTERN CatSearchViewKey const CatSearchViewKeyNormalLeft;
/// 非编辑状态下textField与取消按钮的间距 RH(16)
UIKIT_EXTERN CatSearchViewKey const CatSearchViewKeyNormalRight;
/// 编辑状态下textField与取消按钮的间距 RH(8)
UIKIT_EXTERN CatSearchViewKey const CatSearchViewKeyEditingRight;
/// 非编辑状态textField的宽度 屏幕宽度 - RH(16) * 2
UIKIT_EXTERN CatSearchViewKey const CatSearchViewKeyOriginWidth;
/// 编辑状态下textField的宽度 屏幕宽度 - RH(16) - RH(50)
UIKIT_EXTERN CatSearchViewKey const CatSearchViewKeyEnlargeWidth;
/// searchView:viewKey:代理方法中,若不修改原值,直接返回该值
UIKIT_EXTERN CGFloat CatSearchViewKeyAuto;

typedef NS_ENUM(NSInteger,CatSearchViewCategory) {
    CatSearchViewCategoryNone,
    CatSearchViewCategoryAutoHide,
};

typedef NS_ENUM(NSInteger,CatSearchViewState) {
    CatSearchViewStateNormal,
    CatSearchViewStateEditing, /// 该状态会调整textField的宽度以显示取消按钮
};

typedef NS_OPTIONS(NSInteger, CatSearchViewOption) {
    CatSearchViewOptionNone = 1 << 0,
    CatSearchViewOptionLock = 1 << 1,  /// 禁止自动调整UITextField的宽度
};

@protocol CatSearchViewDelegate <NSObject>

@optional
- (void)searchViewDidChanged:(CatSearchView *)searchView
                       value:(NSString *)value;

- (void)searchViewDidBeginEditing:(CatSearchView *)searchView;
- (void)searchViewDidEndEditing:(CatSearchView *)searchView;

/**
 点击搜索按钮

 @param searchView 搜索视图
 @return 是否可以搜索
 */
- (BOOL)searchViewShouldReturn:(CatSearchView *)searchView;

/**
 点击取消按钮的回调

 @param searchView 搜索视图
 @note 若代理未实现该方法,则不创建取消按钮
 */
- (void)searchViewDidCancel:(CatSearchView *)searchView;

/**
 点击清除按钮的回调
 */
- (BOOL)searchViewDidClear:(CatSearchView *)searchView;

/**
 自定义搜索视图位置

 @param searchView 搜索视图
 @param key 预定义的key
 @return 该key的值
 */
- (CGFloat)searchView:(CatSearchView *)searchView viewKey:(CatSearchViewKey)key;

@end

@interface CatSearchView : UIView

@property (nonatomic,assign) CatSearchViewCategory category;
@property (nonatomic,assign) CatSearchViewState state;
@property (nonatomic,assign) CatSearchViewOption option;
/** 搜索联想视图 */
@property (nonatomic,strong) CatSearchLenovoView *lenovoView;
/** 自定义导航栏条件下的导航栏视图对象 TODO */
@property (nonatomic,weak) UIView *customNavView;

/** 左边放大镜 默认图片名 common_gray_search */
@property (nonatomic,strong,readonly) UITextField *td;
/** 取消按钮 */
@property (nonatomic,strong,readonly) UIButton *cancelButton;
/** 右侧功能控件集合  */
@property (nonatomic,copy) NSArray *rightItems;

- (instancetype)initWithFrame:(CGRect)frame
                     delegate:(id<CatSearchViewDelegate>)delegate;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (CGFloat)searchViewKey:(CatSearchViewKey)key;

- (void)setState:(CatSearchViewState)state animated:(BOOL)animated;

/** 刷新搜索控件布局 */
- (void)refreshLayout;

/** 清空联想视图 */
- (void)clearLenovoView;
/** 清空联想视图和搜索视图内容 */
- (void)clearLenovoWithSearchView;

@end

@interface CatSearchView (Script)

/**
 联想视图处理方法

 @param keyWords 关键字数组
 @param searchLenovoDelegate 联想视图代理对象
 @note keyWords = nil时移除联想视图
 */
- (void)scriptWithLenovoViewKeywords:(nullable NSArray *)keyWords
                     lenovoeDelegate:(id<CatSearchLenovoViewDelegate>)searchLenovoDelegate;

@end

UIKIT_EXTERN NSNotificationName const CatSearchDidSelectRowNotification;

NS_ASSUME_NONNULL_END
