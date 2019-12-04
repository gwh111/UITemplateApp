//
//  testSideViewVC.m
//  UITemplateKit
//
//  Created by ml on 2019/7/4.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "testSideViewVC.h"
#import "CatSideView.h"
#import "CatSimpleView.h"
#import <Masonry/Masonry.h>
#import "CatCommonSelectView.h"

@interface testSideViewVC () <CatSimpleViewLayoutDelegate,CatCommonSelectViewDelegate>

@end

@implementation testSideViewVC

- (void)cc_viewDidLoad {
    
    NSArray *nameList = @[@"上", @"左", @"下", @"右"];
    CC_TableView *tableView = ccs.TableView
    .cc_frame(0, 0, WIDTH(), self.cc_displayView.height)
    .cc_addToView(self.cc_displayView);
    [tableView cc_addTextList:nameList withTappedBlock:^(NSUInteger index) {
        
        [self actionWithIndex:index];
    }];
}

- (void)actionWithIndex:(NSUInteger)index {
    if (index == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20, STATUS_BAR_HEIGHT, WIDTH() - 40, HEIGHT() * 0.2 - 40)];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        UILabel *titleLabel = [UILabel new];
        titleLabel.text = @"这是一条通知";
        titleLabel.textColor = HEX(0xff0000);
        [titleLabel sizeToFit];
        [view addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(view);
        }];
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jump2TargetAction:)]];
        
        [view.cc_sideView.nextPercent(0.2).nextRadius(10) showWithDirection:CatSideViewDirectionTop];
    }
    if (index == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20, STATUS_BAR_HEIGHT, WIDTH() - 40, HEIGHT() * 0.2 - 40)];
        view.backgroundColor = [UIColor blueColor];
        [view.cc_sideView.nextPercent(0.6) showWithDirection:CatSideViewDirectionLeft];
    }
    if (index == 2) {
        CatCommonSelectView *selectView = [[CatCommonSelectView alloc] initWithCancelTitle:@"取消"
                                                                              confirmTitle:@"确定"
                                                                                   dataArr:@[@"A",@"B",@"C",@"D",@"E",@"F",@"G"]
                                                                        selectContentColor:nil
                                                                      unSelectContentColor:nil
                                                                            selectBarColor:nil
                                                                               selectIndex:0];
        selectView.delegate = self;
        selectView.top = 0;
        [selectView.cc_sideView.nextRadius(10) showWithDirection:CatSideViewDirectionBottom];
    }
    if (index == 3) {
        CatSimpleView *view = [[CatSimpleView alloc] initWithFrame:CGRectMake(20, STATUS_BAR_HEIGHT, WIDTH() - 40, HEIGHT() * 0.2 - 40)];
        view.backgroundColor = [UIColor blueColor];
        [view.cc_sideView.nextPercent(0.7) showWithDirection:CatSideViewDirectionRight];
    }
}

- (void)jump2TargetAction:(UITapGestureRecognizer *)sender {
    NSLog(@"%s",__func__);
    [sender.view.cc_sideView dismissViewAnimated:YES];
}

- (void)layoutSimpleView:(CatSimpleView *)simpleView {
    [simpleView.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(simpleView);
    }];
}

- (void)catCommonSelectViewCancel:(CatCommonSelectView *)commonSelectView {
    [commonSelectView.cc_sideView dismissViewAnimated:YES];
}

- (void)catCommonSelectViewConfirm:(CatCommonSelectView *)commonSelectView selectData:(NSString *)selectData {
    [commonSelectView.cc_sideView dismissViewAnimated:YES];
}

@end
