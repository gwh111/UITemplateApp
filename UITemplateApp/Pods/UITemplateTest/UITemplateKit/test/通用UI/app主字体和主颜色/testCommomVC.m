//
//  testCommomVC.m
//  bench_ios
//
//  Created by gwh on 2019/4/23.
//  Copyright © 2019 apple. All rights reserved.
//

#import "testCommomVC.h"
#import "ccs.h"

@interface testCommomVC ()

@end

@implementation testCommomVC

- (void)cc_viewWillLoad {
    
    ccs.Label
    .cc_frame(0, 0, RH(200), RH(40))
    .cc_font(RF(14))
    .cc_addToView(self);
    
    //设置主色调和辅助色调

    float step = RH(10);
    float width = RH(320);
    float height = RH(40);
    
    UILabel *l = ccs.Label
    .cc_frame(10, 100, 200, 40)
    .cc_backgroundColor(UIColor.brownColor)
    .cc_text(@"普通 不放大")
    .cc_addToView(self);
    
    UILabel *l2 = ccs.Label
    .cc_frame(RH(10), l.bottom + step, RH(200), height)
    .cc_backgroundColor(UIColor.greenColor)
    .cc_text(@"自适应大小")
    .cc_addToView(self);
    
    UILabel *l3 = ccs.Label
    .cc_frame(RH(10), l2.bottom + step, width, height)
    .cc_textColor([ccs appStandard:HEADLINE_COLOR])
    .cc_font([ccs appStandard:HEADLINE_FONT])
    .cc_text(@"app通用默认字体-大标题")
    .cc_addToView(self);
    
    UILabel *l4 = ccs.Label
    .cc_frame(RH(10), l3.bottom + step, width, height)
    .cc_textColor([ccs appStandard:TITLE_COLOR])
    .cc_font([ccs appStandard:TITLE_FONT])
    .cc_text(@"app通用默认字体-标题（详情内容）")
    .cc_addToView(self);
    
    UILabel *l5 = ccs.Label
    .cc_frame(RH(10), l4.bottom + step, width, height)
    .cc_textColor([ccs appStandard:CONTENT_COLOR])
    .cc_font([ccs appStandard:CONTENT_FONT])
    .cc_text(@"app通用默认字体-内容")
    .cc_addToView(self);
    
    UILabel *l6 = ccs.Label
    .cc_frame(RH(10), l5.bottom + step, width, height)
    .cc_textColor([ccs appStandard:DATE_COLOR])
    .cc_font([ccs appStandard:DATE_FONT])
    .cc_text(@"app通用默认字体-日期")
    .cc_addToView(self);
    
    UILabel *l7 = ccs.Label
    .cc_frame(RH(10), l6.bottom + step, width, height)
    .cc_textColor(UIColor.whiteColor)
    .cc_backgroundColor([ccs appStandard:MASTER_COLOR])
    .cc_font([ccs appStandard:CONTENT_FONT])
    .cc_text(@"主色调")
    .cc_addToView(self);
    
    UILabel *l8 = ccs.Label
    .cc_frame(RH(10), l7.bottom + step, width, height)
    .cc_textColor(UIColor.whiteColor)
    .cc_backgroundColor([ccs appStandard:AUXILIARY_COLOR])
    .cc_font([ccs appStandard:CONTENT_FONT])
    .cc_text(@"辅色调")
    .cc_addToView(self);
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
