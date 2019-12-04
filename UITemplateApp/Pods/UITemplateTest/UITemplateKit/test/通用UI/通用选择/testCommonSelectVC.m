//
//  testCommonSelectVC.m
//  UITemplateKit
//
//  Created by 路飞 on 2019/5/31.
//  Copyright © 2019 路飞. All rights reserved.
//

#import "testCommonSelectVC.h"
#import "CatCommonSelect.h"

@interface testCommonSelectVC ()<CatCommonSelectDelegate>

@property (nonatomic, strong) CatCommonSelect* commonSelect;

@end

@implementation testCommonSelectVC

- (void)cc_viewDidLoad {
    
    NSArray *nameList = @[@"城市选择"];
    CC_TableView *tableView = ccs.TableView
    .cc_frame(0, 0, WIDTH(), self.cc_displayView.height)
    .cc_addToView(self.cc_displayView);
    [tableView cc_addTextList:nameList withTappedBlock:^(NSUInteger index) {
        
        [self actionWithIndex:index];
    }];
}

- (void)actionWithIndex:(NSUInteger)index {
    if (index == 0) {
        self.commonSelect = [[CatCommonSelect alloc]initWithCancelTitle:@"取消" confirmTitle:@"确认" dataArr:@[@"男", @"女", @"未知"]];
        self.commonSelect.selectIndex = 2;
        self.commonSelect.delegate = self;
        [self.commonSelect popUpCatCommonSelectView];
    }
}

- (CC_Button *)createBtn:(CGRect)rect title:(NSString *)title block:(void(^)(UIButton *button))block {
    
    CC_Button *btn = ccs.Button;
    btn.frame = rect;
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:title forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn cc_tappedInterval:0.1 withBlock:block];
    return btn;
}

#pragma mark - delegate

- (void)catCommonSelectCancel:(CatCommonSelect *)commonSelect {
    
}

- (void)catCommonSelectConfirm:(CatCommonSelect *)commonSelect selectData:(NSString *)selectData {
    NSLog(@"你选择了---------%@", selectData);
}

@end
