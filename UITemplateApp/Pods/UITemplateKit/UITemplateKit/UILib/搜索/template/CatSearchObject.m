//
//  SearchXXObject.m
//  UITemplateKit
//
//  Created by ml on 2019/8/5.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatSearchObject.h"
#import "CatSearchListObject.h"
#import "CatSideView.h"
#import "CatLibSearchMainVC.h"
#import "CatLibSearchListVC.h"

@implementation CatSearchObject

// MARK: - CatSearchViewDelegate -
- (void)searchViewDidChanged:(CatSearchView *)searchView value:(NSString *)value {
//    if ([ccs function_isEmpty:value]) {
//        [searchView clearLenovoView];
//        return;
//    }
//
//    int count = arc4random() % 10;
//    NSMutableArray *keyWords = @[].mutableCopy;
//    for (int i = 0; i < count; ++i) {
//        NSString *lenovoKeyword = [NSString stringWithFormat:@"联想词%d",i];
//        [keyWords addObject:lenovoKeyword];
//    }
//    [searchView scriptWithLenovoViewKeywords:keyWords lenovoeDelegate:self];
}

- (BOOL)searchViewShouldReturn:(CatSearchView *)searchView {
    CatLibSearchMainVC *vc = (CatLibSearchMainVC *)[UIView cc_currentViewController];
    
    // 是否保存搜索历史记录
    if(vc.existedHistory) {
        [vc.historyView.record saveWithKeyword:searchView.td.text];
    }
    
    // 跳转到列表页
    CatLibSearchListVC *listVC = [[CatLibSearchListVC alloc] initWithKeyWord:searchView.td.text];
    
    [vc.navigationController pushViewController:listVC
                                       animated:YES];
    
    // 设置业务对象
    CatSearchListObject *searcher = CatSearchListObject.new;
    searcher.mainVC = vc;
    listVC.searchObject = searcher;

// 一直显示取消按钮 && 不存在返回按钮
//    listVC.alwaysShowCancel = YES;
//    listVC.hasBackButton = NO;
    
    return YES;
}

- (void)searchViewDidCancel:(CatSearchView *)searchView {
    // 取消编辑状态
    if (searchView.td.isEditing) {
        [searchView.td resignFirstResponder];
    }
    
    CatLibSearchMainVC *vc = (CatLibSearchMainVC *)[UIView cc_currentViewController];
//    if (vc.hasBackButton) {
//        vc.cat_navigationBarView.backButton.hidden = NO;
//        searchView.frame = CGRectMake(30, STATUS_BAR_HEIGHT + 4, WIDTH() - 30 , 36);
//        [searchView refreshLayout];
//        [searchView setState:CatSearchViewStateNormal animated:YES];
//    }
     
    // 移除联想视图
    [searchView.lenovoView.cc_sideView dismissViewAnimated:NO];
    [searchView.lenovoView removeFromSuperview];
     
    // 主页面: 无返回按钮,pop到上一级页面
    if(vc.navigationController && !vc.hasBackButton) {
        [vc.navigationController popViewControllerAnimated:NO];
        [searchView removeFromSuperview];
    }
}

- (void)searchViewDidBeginEditing:(CatSearchView *)searchView {
    /// 进入编辑状态
    if (!searchView.lenovoView.superview) {
        CatLibSearchMainVC *vc = (CatLibSearchMainVC *)[UIView cc_currentViewController];
        if ([vc isKindOfClass:CatLibSearchMainVC.class]) {
            if (vc.hasBackButton) {
                vc.cat_navigationBarView.backButton.hidden = YES;
                searchView.frame = CGRectMake(0, STATUS_BAR_HEIGHT + 4, WIDTH() , 36);
                [searchView refreshLayout];
            }
            [searchView setState:CatSearchViewStateEditing animated:YES];
        }
    }
}

- (void)searchViewDidEndEditing:(CatSearchView *)searchView {
    /// 取消编辑状态
    if (!searchView.lenovoView.superview) {
        [searchView setState:CatSearchViewStateNormal animated:YES];
    }
}

- (BOOL)searchViewDidClear:(CatSearchView *)searchView {
    [searchView.lenovoView.cc_sideView dismissViewAnimated:NO];
    [searchView.lenovoView removeFromSuperview];
    return YES;
}

// MARK: - CatSearchLenovoViewDelegate -
- (void)searchLenovoView:(CatSearchLenovoView *)lenoveView willDisplayCell:(CatSimpleTableCell *)cell keyWord:(id)keyWord forIndex:(NSInteger)index {
    /**
    // 联想列表样式
    cell.sview
        .LYIcon.n2Left(RH(16)).n2Top(10).n2Image(DEFAULT_IMG(CGSizeMake(30, 30))).n2SizeToFit()
        .LYTitleLabel.n2CenterY(cell.contentView.centerY).n2Left(RH(56))
        .LYSepartor.n2H(0.5).n2Left(RH(16)).n2W(WIDTH() - 2 * RH(16)).n2Top(cell.sview.height - 0.5)
    ;
     */
}

- (void)searchLenovoView:(CatSearchLenovoView *)lenoveView didSelectRowAtIndex:(NSInteger)index {
    /**
    /// 跳转到列表页
    CatLibSearchMainVC *vc = (CatLibSearchMainVC *)[UIView cc_currentViewController];
    
    /// 设置搜索词
    vc.searchView.td.text = lenoveView.keyWords[index];
    
    /// 保存历史搜索记录
    [vc.historyView.record saveWithKeyword:lenoveView.keyWords[index]];
    
    CatLibSearchListVC *listVC = [[CatLibSearchListVC alloc] initWithKeyWord:lenoveView.keyWords[index]];
    
    /// 附加功能按钮
    UIButton *btn = [UIButton new];
    btn.c2Text(@"消息").c2TextColor(HEX(0x333333)).c2Font(RF(15)).c2SizeToFit();
    listVC.searchView.rightItems = @[btn];
    
    /// 设置业务搜索对象
    listVC.searchObject = self;
    
    /// 列表表单控件设置
    listVC.tableView.dataSource = self;
    listVC.tableView.delegate = self;
    listVC.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    /// [可选]重新设置tableView的frame
    
    /// [可选]重新设置返回按钮/导航栏样式
    listVC.viewDidLoadHandler = ^{
        
    };
    
    [vc.navigationController pushViewController:listVC animated:YES];
    */
}

- (void)searchLenovoViewWillBeginDragging:(CatSearchLenovoView *)lenovoView {
    [lenovoView.searchView.td resignFirstResponder];
}

// MARK: - CatSearchHistoryViewDelegate -
- (void)historyView:(CatSearchHistoryView *)historyView didSelectAtIndexPath:(NSIndexPath *)indexPath {
    historyView.searchView.td.text = [historyView.stickerView stickerViewForIndexPath:indexPath].oneButton.titleLabel.text;
    [self searchViewShouldReturn:historyView.searchView];
}

- (void)historyView:(CatSearchHistoryView *)historyView clearAction:(UIButton *)sender {
    [historyView.record removeAllKeywords];
    [historyView.stickerView reloadData];
    [historyView.stickerView.headerView removeFromSuperview];
}

@end

@implementation CatSearchObject (TableView)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    /**
    return arc4random() % 15;
     */
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [CatSimpleTableCell new];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(CatSimpleTableCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    /**
     
    cell.sview
        .LYIcon.n2Left(RH(16)).n2Top(10).n2Image(DEFAULT_IMG(CGSizeMake(30, 30))).n2SizeToFit()
        .LYTitleLabel.n2Text(@"这是内容").n2Font(RF(15)).n2SizeToFit().n2CenterY(cell.contentView.centerY).n2Left(RH(56))
        .LYSepartor.n2H(0.5).n2Left(RH(16)).n2W(WIDTH() - 2 * RH(16)).n2Top(cell.contentView.height - 0.5).n2BackgroundColor(HEX(0xededed));
     */
}

@end
