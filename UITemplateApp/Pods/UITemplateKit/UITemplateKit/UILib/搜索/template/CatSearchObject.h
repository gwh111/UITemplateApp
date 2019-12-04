//
//  CatSearchObject.h
//  UITemplateKit
//
//  Created by ml on 2019/8/5.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CatSearchView.h"
#import "CatSearchHistoryView.h"

NS_ASSUME_NONNULL_BEGIN

@class CatLibSearchMainVC;

/**
    搜索业务基类
 
 定义
    入口页: 点击该页面的某个控件进入搜索界面
    一级主页: 包含联想视图,历史搜索记录,热搜(TODO)等功能的页面 对应控制器为 CatLibSearchMainVC/CatSearchMainVC(TODO)
    二级列表页: 包含联想视图,搜索的结果列表 对应控制器为 CatLibSearchListVC 可根据实际情况继承
 
 Usage:
 
 /// 创建一级主页面控制器
 CatLibSearchMainVC *searchMainVC = [CatLibSearchMainVC new];
 /// 设置搜索业务对象
 searchMainVC.searchObject = CatSearchObject.new;
 [self.navigationController pushViewController:searchMainVC animated:YES];
 /// 弹出键盘
 [searchMainVC.searchView.td becomeFirstResponder];
 
 /// 剩下参考CatSearchObject 根据业务实现对应代理方法
 
 */
@interface CatSearchObject : NSObject <CatSearchViewDelegate,CatSearchLenovoViewDelegate,CatSearchHistoryViewDelegate>

@end

@interface CatSearchObject (TableView) <UITableViewDataSource,UITableViewDelegate>

@end

NS_ASSUME_NONNULL_END
