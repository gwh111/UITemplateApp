//
//  testCitySelectVC.m
//  UITemplateKit
//
//  Created by 路飞 on 2019/5/28.
//  Copyright © 2019 路飞. All rights reserved.
//

#import "testCitySelectVC.h"
#import "CatCitySelect.h"

@interface testCitySelectVC ()<CatCitySelectDelegate>

@property (nonatomic, strong) CatCitySelect* citySelect1;

@end

@implementation testCitySelectVC

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
        self.citySelect1 = [[CatCitySelect alloc]init];
        self.citySelect1.delegate = self;
        [self.citySelect1 popUpCatCitySelectView];
    }
}

- (CC_Button *)createBtn:(CGRect)rect title:(NSString *)title block:(void(^)(UIButton *button))block {
    
    CC_Button* btn = [[CC_Button alloc]initWithFrame:rect];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:title forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn cc_tappedInterval:0.1 withBlock:block];
    return btn;
}
#pragma mark - public

#pragma mark - notification

#pragma mark - delegate
- (void)catCitySelectCancel:(CatCitySelect *)citySelect {
    CCLOG(@"取消");
}

- (void)catCitySelectConfirm:(CatCitySelect *)citySelect selectProvince:(NSString *)selectProvince selectCity:(NSString *)selectCity selectDistrict:(NSString *)selectDistrict {
    CCLOG(@"所选城市%@-%@-%@-%@", selectProvince, selectCity, selectDistrict, citySelect);
}
#pragma mark - property

@end
