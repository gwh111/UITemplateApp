//
//  CatLibSearchMainVC.h
//  UITemplateKit
//
//  Created by Shepherd on 2019/8/4.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatBaseVC.h"
#import "CatSearchView.h"
#import "CatSearchObject.h"
#import "CatSearchHistoryView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CatLibSearchMainVC : CatBaseVC

/** 搜索业务对象 */
@property (nonatomic,strong) CatSearchObject *searchObject;
/** 搜索视图容器对象 */
@property (nonatomic,strong,readonly) CatSearchView *searchView;
/** 进入页面是否显示键盘 默认显示(NO) */
@property (nonatomic,assign) BOOL hideKeyboard;

/** 是否有返回按钮 默认无(NO) */
@property (nonatomic,assign) BOOL hasBackButton;
/** 取消按钮一直显示 */
@property (nonatomic,assign) BOOL alwaysShowCancel;

/** 历史搜索记录视图 */
@property (nonatomic,strong,readonly) CatSearchHistoryView *historyView;
/** 是否记录搜索历史 默认YES */
@property (nonatomic,assign,getter=isExistedHistory) BOOL existedHistory;
/** 历史搜索记录本地的文件名 默认是_cat_history,存在多个搜索记录,要设置该值 */
@property (nonatomic,copy) NSString *historyFileName;

/** viewDidLoad回调 */
@property (nonatomic,copy) void (^viewDidLoadHandler)(void);

@end

NS_ASSUME_NONNULL_END
