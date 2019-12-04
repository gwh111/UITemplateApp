//
//  testStrongAlertVC.m
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/7.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "testStrongAlertVC.h"
#import "CatStrongAlert.h"
#import "ccs.h"

@interface testStrongAlertVC ()<CatStrongAlertDelegate>

@property (nonatomic, strong) CatStrongAlert* alert1;
@property (nonatomic, strong) CatStrongAlert* alert2;
@property (nonatomic, strong) CatStrongAlert* alert3;
@property (nonatomic, strong) CatStrongAlert* alert4;
@property (nonatomic, strong) CatStrongAlert* alert5;
@property (nonatomic, strong) CatStrongAlert* alert6;

@end

@implementation testStrongAlertVC

- (void)cc_viewDidLoad {
    NSArray *nameList = @[@"更新-横", @"更新-竖", @"微博", @"VIP", @"鼓励-竖", @"鼓励-横"];
    CC_TableView *tableView = ccs.TableView
    .cc_frame(0, 0, WIDTH(), self.cc_displayView.height)
    .cc_addToView(self.cc_displayView);
    [tableView cc_addTextList:nameList withTappedBlock:^(NSUInteger index) {
        
        [self actionWithIndex:index];
    }];
}

- (void)actionWithIndex:(NSUInteger)index {
    if (index == 0) {
        self.alert1 = [[CatStrongAlert alloc]initWithTitle:@"发现新版本\nV1.2.0" content:@"1.在个人设置中可以选择界面语言；\n\n2.增加了热点推荐；\n\n3.细节优化，进一步提升用户体验\n\n2.增加了热点推荐；\n\n3.细节优化，进一步提升用户体验\n\n2.增加了热点推荐；\n\n3.细节优化，进一步提升用户体验" bgImage:[UIImage imageNamed:@"OnePiece4"] cancelTitle:@"以后再说" confirmTitle:@"马上升级" type:CatStrongAlertUpdateHorizontal isShowCancel:YES];
        [self.alert1 popUpCatAlertStrongView];
    }
    if (index == 1) {
        self.alert2 = [[CatStrongAlert alloc]initWithTitle:@"更多精彩，尽在最新版" content:@"获取最新版本，与官方交流互动，加入用户体验计划。我们期待您的真实反馈。" bgImage:[UIImage imageNamed:@"OnePiece1"] cancelTitle:@"以后再说" confirmTitle:@"升级" type:CatStrongAlertUpdateVerticality isShowCancel:YES];
        [self.alert2 popUpCatAlertStrongView];
    }
    if (index == 2) {
        self.alert3 = [[CatStrongAlert alloc]initWithTitle:@"更多精彩，尽在微博" content:@"关注我们的新浪微博，加入用户体验计划。\n我们期待您的真实反馈。" bgImage:[UIImage imageNamed:@"OnePiece"] cancelTitle:@"不，谢谢" confirmTitle:@"前往微博"];
        [self.alert3 popUpCatAlertStrongView];
    }
    if (index == 3) {
        self.alert6 = [[CatStrongAlert alloc]initWithTitle:@"lv10wdy" content:@"恭喜您成为初级会员，可享受专属特权" bgImage:[UIImage imageNamed:@"OnePiece2"] ticketImage:[UIImage imageNamed:@"ticket"] ticketName:@"10元代金券" cancelTitle:@"关闭" confirmTitle:@"我的特权"];
        [self.alert6 popUpCatAlertStrongView];
    }
    if (index == 4) {
        self.alert5 = [[CatStrongAlert alloc]initWithTitle:@"撒娇求鼓励喵~" bgImage:[UIImage imageNamed:@"OnePiece5"] cancelTitle:@"残忍拒绝" confirmTitle:@"鼓励一下" type:CatStrongAlertCheerUpVerticality];
        [self.alert5 popUpCatAlertStrongView];
    }
    if (index == 5) {
        self.alert4 = [[CatStrongAlert alloc]initWithTitle:@"您的鼓励，我们前进的动力" bgImage:[UIImage imageNamed:@"OnePiece6"] cancelTitle:@"我要吐槽" confirmTitle:@"鼓励一下" type:CatStrongAlertCheerUpHorizontal];
        [self.alert4 popUpCatAlertStrongView];
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

#pragma mark - delegates
- (void)catStrongAlertCancel:(CatStrongAlert *)alertView{
    
}

- (void)catStrongAlertConfirm:(CatStrongAlert *)alertView{
    
}

- (void)catStrongAlertClose:(CatStrongAlert *)alertView{
    
}

@end
