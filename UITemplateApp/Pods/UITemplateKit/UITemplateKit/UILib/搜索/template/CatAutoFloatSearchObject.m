//
//  CatAutoFloatSearchObject.m
//  UITemplateKit
//
//  Created by ml on 2019/8/5.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatAutoFloatSearchObject.h"
#import "CatLibSearchMainVC.h"
#import "CatLibSearchListVC.h"
#import "CatSideView.h"

@implementation CatAutoFloatSearchObject

- (void)searchLenovoView:(CatSearchLenovoView *)lenoveView didSelectRowAtIndex:(NSInteger)index {
    if ([[UIView cc_currentViewController] isKindOfClass:CatLibSearchMainVC.class]) {
        /// 跳转到列表页
        CatLibSearchMainVC *vc = (CatLibSearchMainVC *)[UIView cc_currentViewController];
        
        /// 设置搜索词
        vc.searchView.td.text = lenoveView.keyWords[index];
        CatLibSearchListVC *listVC = [[CatLibSearchListVC alloc] initWithKeyWord:lenoveView.keyWords[index]];
        listVC.title = @"自动上浮";
        
        /// 禁止搜索控件自动调整
        listVC.searchView.category = CatSearchViewCategoryAutoHide;
        
        /// 设置业务搜索对象
        listVC.searchObject = self;
        
        /// 列表表单控件设置
        listVC.tableView.dataSource = self;
        listVC.tableView.delegate = self;
        listVC.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [vc.navigationController pushViewController:listVC animated:YES];
    }else if([[UIView cc_currentViewController] isKindOfClass:CatLibSearchListVC.class]){
        /// 二级列表页点击操作
        lenoveView.searchView.td.text = lenoveView.keyWords[index];
    }
    
}

@end
