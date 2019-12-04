//
//  CatSearchListObject.m
//  UITemplateKit
//
//  Created by ml on 2019/8/26.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatSearchListObject.h"
#import "CatSideView.h"
#import "CatLibSearchMainVC.h"
#import "CatLibSearchListVC.h"

@implementation CatSearchListObject

// MARK: - CatSearchViewDelegate -
- (void)searchViewDidChanged:(CatSearchView *)searchView value:(NSString *)value {
//    if ([ccs function_isEmpty:value]) {
//        if (searchView.td.isEditing) {
//            [searchView scriptWithLenovoViewKeywords:@[] lenovoeDelegate:self];
//        }else {
//            [searchView clearLenovoView];
//        }
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
    // 是否保存搜索历史记录
    if(self.mainVC.existedHistory) {
        [self.mainVC.historyView.record saveWithKeyword:searchView.td.text];
    }
    
    // 进入详情页...
    
    return YES;
}

- (void)searchViewDidBeginEditing:(CatSearchView *)searchView {
    // 列表页内容非空
    if (searchView.td.text) {
        [self searchViewDidChanged:searchView value:searchView.td.text];
    }
    
    if (!searchView.lenovoView.superview) {
        CatLibSearchListVC *vc = (CatLibSearchListVC *)[UIView cc_currentViewController];
        if (vc.hasBackButton) {
            vc.cat_navigationBarView.backButton.hidden = YES;
            searchView.frame = CGRectMake(0, STATUS_BAR_HEIGHT + 4, WIDTH() , 36);
            [searchView refreshLayout];
        }
        [searchView setState:CatSearchViewStateEditing animated:YES];
    }
}

- (void)searchViewDidEndEditing:(CatSearchView *)searchView {
    /// 取消编辑状态
    if (!searchView.lenovoView.superview) {
        [searchView setState:CatSearchViewStateNormal animated:YES];
    }
}

- (void)searchViewDidCancel:(CatSearchView *)searchView {
    CatLibSearchListVC *vc = (CatLibSearchListVC *)[UIView cc_currentViewController];
    
    // 当存在返回按钮时,对搜索视图进行调整
    if (vc.hasBackButton) {
        vc.cat_navigationBarView.backButton.hidden = NO;
        searchView.frame = CGRectMake(30, STATUS_BAR_HEIGHT + 4, WIDTH() - 30, 36);
        [searchView refreshLayout];
    }
    
    // 取消编辑状态
    if (searchView.td.isEditing) {
        [searchView.td resignFirstResponder];
    }
    
    // 自定义行为...
//    if (searchView.td.isEditing == NO) {
//        [vc.navigationController popToRootViewControllerAnimated:YES];
//    }
    
}



// MARK: - CatSearchLenovoViewDelegate -
- (void)searchLenovoView:(CatSearchLenovoView *)lenoveView didSelectRowAtIndex:(NSInteger)index {
    /**
     // 设置搜索栏内容
     lenoveView.searchView.td.text = lenoveView.keyWords[index];
     // 进入详情页
     // ...
     */
}



@end
