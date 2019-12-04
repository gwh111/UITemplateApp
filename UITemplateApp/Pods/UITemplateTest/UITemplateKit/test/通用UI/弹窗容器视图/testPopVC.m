//
//  testPopVC.m
//  UITemplateKit
//
//  Created by ml on 2019/8/9.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "testPopVC.h"
#import "CatPopView.h"
#import "CatSimpleView.h"

@interface testPopVC ()

@end

@implementation testPopVC

- (void)cc_viewDidLoad {
    
    NSArray *nameList = @[@"无", @"渐变", @"从上往下", @"从下往上", @"斜入", @"缩小消失", @"CatStrongAlert"];
    CC_TableView *tableView = ccs.TableView
    .cc_frame(0, 0, WIDTH(), self.cc_displayView.height)
    .cc_addToView(self.cc_displayView);
    [tableView cc_addTextList:nameList withTappedBlock:^(NSUInteger index) {
        
        [self actionWithIndex:index];
    }];
}

- (void)actionWithIndex:(NSUInteger)index {
    CatSimpleView *sview = [[CatSimpleView alloc] initWithFrame:CGRectMake(RH(16), 100, WIDTH() - 2 * RH(16), RH(260))];
    sview
        .LYIcon
            .n2Text(@"home_subsequent_notifcation")
            .n2Left(RH(19)).n2Top(RH(26)).n2W(RH(17)).n2H(RH(18))
        .LYTitleLabel
            .n2Text(@"消息标题")
            .n2TextColor(HEX(0x333333)).n2Font(RF(17))
            .n2Left(RH(41)).n2Top(RH(30)).n2SizeToFit()
        .LYDescLabel
            .n2Text(@"消息内容")
            .n2Font(RF(17)).n2Left(RH(41))
            .n2Top(RH(58)).n2SizeToFit();
    if (index == 0) {
        [sview.cc_popView showWithAnimation:CatPopAnimationStyleNone];
    }
    if(index == 1) {
        [sview.cc_popView showWithAnimation:CatPopAnimationStyleFadeInOut];
    }
    if(index == 2) {
        [sview.cc_popView showWithAnimation:CatPopAnimationStyleSlideVerTop];
    }
    if(index == 3) {
        [sview.cc_popView showWithAnimation:CatPopAnimationStyleSlideVerBottom];
    }
    if(index == 4) {
        [sview.cc_popView showWithAnimation:CatPopAnimationStyleSlideAngleBounce];
    }
    if(index == 5) {
        CatPopView *popView = sview.cc_popView;
        popView.dismissPoint = sview.center;
        popView.outStyle = CatPopAnimationStyleDismissSlideInToPointAndScale;
        [popView showWithAnimation:CatPopAnimationStyleSlideVerBottom];
    }
    if (index == 6) {
        /// 类似CatStrongAlert 放大缩小效果
        [sview.cc_popView showWithAnimation:CatPopAnimationStyleScale];
    }
}
@end
