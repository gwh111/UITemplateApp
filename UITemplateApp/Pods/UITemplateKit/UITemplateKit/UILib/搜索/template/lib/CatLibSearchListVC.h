//
//  CatLibSearchListVC.h
//  UITemplateKit
//
//  Created by Shepherd on 2019/8/4.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatBaseVC.h"
#import "CatSearchView.h"
#import "CatSearchObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface CatLibSearchListVC : CatBaseVC

/** 搜索视图容器对象 */
@property (nonatomic,strong,readonly) CatSearchView *searchView;
/** 搜索业务对象 */
@property (nonatomic,strong) CatSearchObject *searchObject;
/** 是否存在返回按钮 默认存在(YES) */
@property (nonatomic,assign) BOOL hasBackButton;
/** 取消按钮一直显示 */
@property (nonatomic,assign) BOOL alwaysShowCancel;

/** viewDidLoad回调 */
@property (nonatomic,copy) void (^viewDidLoadHandler)(void);
@property (nonatomic,copy) void (^viewWillAppearHandler)(void);
/** 搜索结果列表视图 frame:CGRectMake(0, 导航栏高度, 屏幕宽, 屏幕高 - 导航栏) */
@property (nonatomic,strong,readonly) UITableView *tableView;

- (instancetype)initWithKeyWord:(NSString *)keyWord;

@end

NS_ASSUME_NONNULL_END
