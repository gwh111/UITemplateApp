//
//  CatPersonSelectView.h
//  UITemplateLib
//
//  Created by ml on 2019/5/28.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CatPersonSelectView,CatPersonSelectCell,CatPersonSelectSectionHeaderView;

typedef NS_ENUM(NSInteger,CatPersonSelectViewType) {
    CatPersonSelectViewTypeSingle,
    CatPersonSelectViewTypeMultiple
};

typedef NS_ENUM(NSInteger,CatSortListHeadMode) {
    CatSortListHeadModeNone,
    CatSortListHeadModeContact, /// 通讯录
};

typedef NSString * CatPersonSelectStringKey NS_TYPED_ENUM;

UIKIT_EXTERN CatPersonSelectStringKey const CatPersonSelectTitleString;
UIKIT_EXTERN CatPersonSelectStringKey const CatPersonSelectImageString;
UIKIT_EXTERN CatPersonSelectStringKey const CatPersonSelectCategroyString;

/// 辅助视图的section
UIKIT_EXTERN CGFloat const CatPersonSelectExtraCellTag;

@protocol CatPersonSelectDatesource <NSObject>

- (NSString *)cat_diffIdentifier;

@optional
+ (NSDictionary <CatPersonSelectStringKey,id>*)cat_mapper;

@end

@protocol CatPersonSelectViewDelegate <NSObject>

/**
 加载图片

 @param selectView 人员选取视图对象
 @param imageView 图片对象
 @param urlString 图片网络地址
 @param indexPath 索引
 */
- (void)catPersonSelectView:(CatPersonSelectView *)selectView
                  imageView:(UIImageView *)imageView
                  urlString:(NSString *)urlString
                  indexPath:(NSIndexPath *)indexPath;

@optional

- (void)catPersonSelectView:(CatPersonSelectView *)pickerView
            willDisplayCell:(CatPersonSelectCell *)cell
          forRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 是否可点击

 @param selectView 人员选取视图对象
 @param indexPath 索引
 @return 是否可点击
 */
- (BOOL)catPersonSelectView:(CatPersonSelectView *)selectView
 shouldSelectRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 点击回调

 @param selectView 人员选取视图对象
 @param item 模型对象
 @param indexPath 索引
 */
- (void)catPersonSelectView:(CatPersonSelectView *)selectView
                       item:(nullable id<CatPersonSelectDatesource>)item
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 提供cell的高度

 @param selectView 人员选取视图对象
 @param indexPath 当前索引
 @return 自定义子视图的高度
 */
- (CGFloat)catPersonSelectView:(CatPersonSelectView *)selectView
       heightForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 若要使用自定义的cell
 1. 通过UITableView注册cell
 2. 实现该代理方法

 @param selectView 人员选取视图对象
 @param indexPath 当前索引
 @return 自定义cell
 */
- (CatPersonSelectCell *)catPersonSelectView:(CatPersonSelectView *)selectView
                 customCellforRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 全局组视图
 用于描述控件:比如通讯录

 @param selectView 人员选取视图对象
 @param sortHeaderView 全局组视图引用
 */
- (void)catPersonSelectView:(CatPersonSelectView *)selectView
       customSortHeaderView:(CatPersonSelectSectionHeaderView *)sortHeaderView;
/**
 组视图

 @param selectView 人员选取视图对象
 @param sectionHeaderView 原组视图引用
 @param section 第几组
 */
- (void)catPersonSelectView:(CatPersonSelectView *)selectView
          customSectionView:(CatPersonSelectSectionHeaderView *)sectionHeaderView
     viewForHeaderInSection:(NSInteger)section;

/// 自定义组视图高度
- (CGFloat)catPersonSelectView:(CatPersonSelectView *)selectView
      heightForHeaderInSection:(NSInteger)section;

@end

@interface CatPersonSelectSectionHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong,readonly) UILabel *titleLabel;

@end

@interface CatPersonSelectCell : UITableViewCell

@property (nonatomic,readonly) UIButton *checkBoxButton;
@property (nonatomic,readonly) UIImageView *iconView;
@property (nonatomic,readonly) UILabel *nameLabel;
@property (nonatomic,readonly) UIView *separator;

@end
// #warning TODO 修改 CatSortListView 定位应该为有序列表 而不是人员选取
@interface CatPersonSelectView : UIView

/// 选择完成后的回调
@property (nonatomic,copy) void (^completionHandler)(NSArray <id<CatPersonSelectDatesource>>*persons);

/// 初始化使用/选中后再次进入显示已选择的人员
@property (nonatomic,copy) NSArray <id<CatPersonSelectDatesource>> *defaultSelectPersons;

/// 自定义选中按钮样式 firstObject:normal lastObject:selected
@property (nonatomic,strong) NSArray <UIImage *> *checkBoxImages;

/// 名称换行模式
@property (nonatomic,assign) NSLineBreakMode lineBreakMode;

@property (nonatomic,assign) CatSortListHeadMode headMode;
/**
 子视图顺序
    searchView
    catPersonSelectView:customSortHeaderView: 返回的全局组视图
    extraView
    extraTitles
 */
@property (nonatomic,strong,readonly) UIView *headerView;

@property (nonatomic,copy) NSArray *extraTitles;
@property (nonatomic,copy) NSPointerArray *extraCells;

/// 扩展视图
@property (nonatomic,strong) UIView *extraView;

/// TODO 用于存放搜索视图
@property (nonatomic,strong) UIView *searchView;

/// unuse
@property (nonatomic,strong) UIView *footerView;

@property (nonatomic,strong,readonly) UITableView *tableView;

/// 完成按钮
@property (nonatomic,strong) UIButton *doneButton;

/// 达到最大人数时,点击代理方法依然会回调,用于提供toast弹窗的机会 默认100人
@property (nonatomic,assign) NSInteger maxCount;

- (instancetype)initWithType:(CatPersonSelectViewType)type
                    delegate:(id<CatPersonSelectViewDelegate>)delegate;

- (void)setItems:(NSArray <id<CatPersonSelectDatesource>>*)items;

- (void)reloadData;

/**
 通过indexPath从有序列表中找到对应的模型

 @param indexPath 索引
 @return 模型
 */
- (id<CatPersonSelectDatesource>)searchModelWithIndexPath:(NSIndexPath *)indexPath;

/**
 已选择人员,页面未消失前有效

 @return 已选择人员数组
 */
- (NSArray *)selectPersons;

@end

@interface CatPersonSelectVC : UIViewController

@property (nonatomic,strong,readonly) CatPersonSelectView *pickerView;
@property (nonatomic,strong,readonly) UIButton *completedButton;

+ (instancetype)controllerWithPickerView:(CatPersonSelectView *)pickerView;

@end



/**
 点击返回按钮触发该通知
 */
UIKIT_EXTERN NSNotificationName const CatPersonSelectWillDisappearNotification;
/**
 点击完成按钮触发该通知
 */
UIKIT_EXTERN NSNotificationName const CatPersonSelectDoneNotification;
/**
 若还有其它页面进行人员选取要同步到该页面,请发送该通知
 sender.object = @[新选择的成员...];
 */
UIKIT_EXTERN NSNotificationName const CatPersonSelectIncrementalPersonsNotification;

NS_ASSUME_NONNULL_END
