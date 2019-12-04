//
//  testDefaultPopVC.m
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/13.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "testDefaultPopVC.h"
#import "CatDefaultPop.h"

@interface testDefaultPopVC ()<CatDefaultPopDelegate>

@property (nonatomic, strong) CatDefaultPop* pop;

@end

@implementation testDefaultPopVC

- (void)cc_viewDidLoad {
    NSArray *nameList = @[@"弹窗"];
    CC_TableView *tableView = ccs.TableView
    .cc_frame(0, 0, WIDTH(), self.cc_displayView.height)
    .cc_addToView(self.cc_displayView);
    [tableView cc_addTextList:nameList withTappedBlock:^(NSUInteger index) {
        
        [self actionWithIndex:index];
    }];
}

- (void)actionWithIndex:(NSUInteger)index {
    if (index == 0) {
        [self clickToPop];
    }
}

#pragma mark - public
- (void)clickToPop {
    self.pop = [[CatDefaultPop alloc]initWithTitle:@"提示" content:@"你将退出，是否确定？" cancelTitle:@"取消" confirmTitle:@"确认"];
    _pop.delegate = self;
    [_pop popUpCatDefaultPopView];
    [self clickToChange];
}

- (void)clickToChange {
//    [_pop updateCancelColor:[UIColor redColor] confirmColor:[UIColor greenColor]];
}

#pragma mark - notification

#pragma mark - delegate
- (void)catDefaultPopCancel:(CatDefaultPop *)defaultPop{
    
}

- (void)catDefaultPopConfirm:(CatDefaultPop *)defaultPop{
    
}

#pragma mark - property

@end
