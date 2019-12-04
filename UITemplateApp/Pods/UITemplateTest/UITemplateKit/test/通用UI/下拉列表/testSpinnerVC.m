//
//  testSpinnerVC.m
//  UITemplateLib
//
//  Created by gwh on 2019/4/25.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "testSpinnerVC.h"
#import "CatSpinner.h" 
#import "ccs.h"

@interface testSpinnerVC ()<CatSpinnerDelegate>

@property (nonatomic, strong) CatSpinner *spinner;

@end

@implementation testSpinnerVC

- (void)cc_viewDidLoad {
    NSArray *nameList = @[@"普通", @"更换颜色", @"更换item", @"更换item和图标", @"更换宽度", @"消失弹框"];
    CC_TableView *tableView = ccs.TableView
    .cc_frame(0, 0, WIDTH(), self.cc_displayView.height)
    .cc_addToView(self.cc_displayView);
    [tableView cc_addTextList:nameList withTappedBlock:^(NSUInteger index) {
        
        [self actionWithIndex:index];
    }];
}

- (void)actionWithIndex:(NSUInteger)index {
    if (index == 0) {
        [self clickLeftTop];
    }
    if (index == 1) {
        [self clickLeftTop];
        [self clickChangeColor];
    }
    if (index == 2) {
        [self clickLeftTop];
        [self clickChangeItem];
    }
    if (index == 3) {
        [self clickLeftTop];
        [self clickChangeIconAndItem];
    }
    if (index == 4) {
        [self clickLeftTop];
        [self clickChangeWidth];
    }
    if (index == 5) {
        [self clickLeftTop];
        [self clickClosePopView];
    }
}

- (void)clickLeftTop {
    
    self.spinner =  [[CatSpinner alloc] initOn:self.cc_displayView originPoint:CGPointMake(50, 0) iconArr:@[@"组 11", @"组 12", @"组 13"] itemArr:@[@"蒙奇·D·路飞", @"罗罗诺亚·佐隆", @"托尼托尼·乔巴",@"蒙奇·D·路飞", @"罗罗诺亚·佐隆", @"托尼托尼·乔巴",@"蒙奇·D·路飞", @"罗罗诺亚·佐隆", @"托尼托尼·乔巴",@"蒙奇·D·路飞", @"罗罗诺亚·佐隆", @"托尼托尼·乔巴",@"蒙奇·D·路飞", @"罗罗诺亚·佐隆", @"托尼托尼·乔巴",@"蒙奇·D·路飞", @"罗罗诺亚·佐隆", @"托尼托尼·乔巴",@"蒙奇·D·路飞", @"罗罗诺亚·佐隆", @"托尼托尼·乔巴",@"蒙奇·D·路飞", @"罗罗诺亚·佐隆", @"托尼托尼·乔巴",@"蒙奇·D·路飞", @"罗罗诺亚·佐隆", @"托尼托尼·乔巴",@"蒙奇·D·路飞", @"罗罗诺亚·佐隆", @"托尼托尼·乔巴",@"蒙奇·D·路飞", @"罗罗诺亚·佐隆", @"托尼托尼·乔巴",@"蒙奇·D·路飞", @"罗罗诺亚·佐隆", @"托尼托尼·乔巴",@"蒙奇·D·路飞", @"罗罗诺亚·佐隆", @"托尼托尼·乔巴",@"蒙奇·D·路飞", @"罗罗诺亚·佐隆", @"托尼托尼·乔巴"]];
    _spinner.csDelegate = self;
    [_spinner popUp];
    [_spinner updateWidth:WIDTH()/2];
    if (@available(iOS 11.0, *)) {
        [_spinner updateShapeCornerMask:kCALayerMinXMaxYCorner|kCALayerMaxXMaxYCorner cornerRadius:RH(16)];
    } 
//    self.spinner.csList.backgroundColor=RGBA(0, 0, 0, 0.6);
    //    [_spinner updateItems:@[@"xxxdddddddd", @"yyy"]];
    //    [_spinner updateIcons:@[@"chrome", @"firefox", @"safari"] items:@[@"xxx", @"yyy", @"zzz"]];
    //    [_spinner updateTextColor:[UIColor whiteColor] backColor:[UIColor blackColor]];
}

- (void)clickChangeColor {
    [_spinner updateTextColor:[UIColor whiteColor] backColor:[UIColor blackColor]];
}

- (void)clickChangeItem {
    [_spinner updateItems:@[@"xxxdddddddd", @"yyy"]];
}

- (void)clickChangeIconAndItem {
    [_spinner updateIcons:@[@"组 11", @"组 12", @"组 13"] items:@[@"xxx", @"yyy", @"zzz"]];
}

- (void)clickChangeWidth {
    [_spinner updateWidth:300];
}

- (void)clickClosePopView {
    [_spinner dismissCatSpinnerList];
}

- (void)initViews {
    self.view.backgroundColor = RGBA(238, 238, 238, 1);
}

#pragma mark - public

#pragma mark - notification

#pragma mark - delegate
- (void)catSpinner:(CatSpinner *)catSpinner didSelectRowAtIndex:(NSInteger)index itemName:(NSString *)itemName {
    NSLog(@"点击了%ld---%@", index, itemName);
    
}
#pragma mark - property


@end
