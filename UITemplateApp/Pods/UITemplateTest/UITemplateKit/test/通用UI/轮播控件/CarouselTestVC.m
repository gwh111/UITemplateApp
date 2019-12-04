//
//  CarouselTestVC.m
//  UITemplateKit
//
//  Created by 路飞 on 2019/8/16.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CarouselTestVC.h"
#import "CatCarouselView.h"
#import "CarouselTestV.h"

@interface CarouselTestVC ()

@end

@implementation CarouselTestVC

- (void)cc_viewDidLoad {
    
    CatCarouselView *carouselVV=[[CatCarouselView alloc]initWithFrame:CGRectMake(RH(16), RH(100), WIDTH()-RH(32), RH(80)) subViewClass:@"CarouselTestV" propertyName:@"title" theme:CatCarouselThemeVertical tapBlock:^(NSInteger index, id  _Nonnull data) {
        NSLog(@"点击--------------%ld,------%@", index, data);
    }];
    [self.view addSubview:carouselVV];
    
    carouselVV.dataArr=@[@"蒙奇·D·路飞", @"罗罗诺亚·佐罗", @"托尼托尼·乔巴", @"God·乌索普", @"文斯莫克·三治"];
    
    CatCarouselView *carouselVH=[[CatCarouselView alloc]initWithFrame:CGRectMake(RH(16), RH(300), WIDTH()-RH(32), RH(80)) subViewClass:@"CarouselTestV" propertyName:@"title" theme:CatCarouselThemeHorizontal tapBlock:^(NSInteger index, id  _Nonnull data) {
        NSLog(@"点击--------------%ld,------%@", index, data);
    }];
    [self.view addSubview:carouselVH];
    
    carouselVH.dataArr=@[@"我啊...", @"突然往左滑了一下", @"又往左滑了一下", @"然后呢..."];
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
