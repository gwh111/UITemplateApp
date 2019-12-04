//
//  testSortSiftVC.m
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/16.
//  Copyright © 2019 gwh. All rights reserved.
//

#define NAV_BAR_HEIGHT (44.f)
#define STATUS_AND_NAV_BAR_HEIGHT (STATUS_BAR_HEIGHT + NAV_BAR_HEIGHT)
#define STATUS_BAR_HEIGHT (CGRectGetHeight([UIApplication sharedApplication].statusBarFrame))

#import "testSortSiftVC.h"
#import "CatSortSift.h"
#import "CatSortSiftPop.h"

@interface testSortSiftVC ()<CatSortSiftPopDelegate>
@property (nonatomic, strong) CatSortSift* sortSift1;
@property (nonatomic, strong) CatSortSift* sortSift2;
@property (nonatomic, strong) CatSortSiftPop *pop;
@property (nonatomic, strong) NSArray* array1;
@end

@implementation testSortSiftVC

#pragma mark - lifeCycle
- (void)cc_viewDidLoad {
    [self initDatas];
    [self initNav];
    [self initViews];
}

#pragma mark - network

#pragma mark - private
- (void)initDatas {
    NSArray* titleArr = @[@"沙发",@"茶几",@"柜架",@"灯具",@"家纺",@"床具",@"卫浴",@"其他"];
    NSArray* imageArr = @[@"http://ww2.sinaimg.cn/large/8fb941ebjw1dmoir25799j.jpg",
                          @"http://p1.qhimgs4.com/t0175e4cb83bebdccfe.jpg",
                          @"http://ww2.sinaimg.cn/large/9e531b2bgw1fb8tgnf5qaj218g0p0agh.jpg",
                          @"http://hiphotos.baidu.com/doc/pic/item/caef76094b36acaff61b37c576d98d1001e99c14.jpg",
                          @"http://tx.haiqq.com/uploads/allimg/170502/0216101961-8.jpg",
                          @"http://ww2.sinaimg.cn/large/bf7007e6jw1eue831w6tuj20sg0lc0xm.jpg"];
    NSMutableArray* muaOutArr = [[NSMutableArray alloc]init];
    for (int i = 0; i < titleArr.count; i++) {
        CatSortSiftOutModel* outModel = [[CatSortSiftOutModel alloc]init];
        outModel.headTitle = titleArr[i];
        if (i == 0) {
            outModel.select = YES;
        }else{
            outModel.select = NO;
        }
        NSMutableArray* muaInArr = [[NSMutableArray alloc]init];
        for (int j = 0; j < imageArr.count; j++) {
            CatSortSiftInModel* inModel = [[CatSortSiftInModel alloc]init];
            inModel.title = [NSString stringWithFormat:@"%d人%@", j, titleArr[i]];
            inModel.imgUrl = imageArr[j];
            [muaInArr addObject:inModel];
        }
        outModel.inDataArr = [muaInArr copy];
        [muaOutArr addObject:outModel];
    }
    self.array1 = [muaOutArr copy];
    
    self.pop=[[CatSortSiftPop alloc]initWithTitle:@"POP demo" leftSelectImage:[UIImage imageNamed:@"pop_filter"] rightSelectImage:[UIImage imageNamed:@"pop_check"] leftSelectIndex:0 rightSelectIndex:-1 array:@[@{@"name":@"Luffy",@"array":@[@"1", @"2", @"3"]},@{@"name":@"Nami",@"array":@[@"1", @"2", @"3"]},@{@"name":@"Zoro",@"array":@[@"1", @"2", @"3"]},@{@"name":@"SanJi",@"array":@[@"1", @"2", @"3"]}]];
    _pop.delegate=self;
    
}
- (void)initNav {
    
    CC_Button *popBtn = ccs.Button;
    popBtn.frame = CGRectMake(WIDTH()-RH(48), STATUS_BAR_HEIGHT, RH(48), 40);
    [popBtn setTitle:@"POP" forState:UIControlStateNormal];
    [popBtn setTitleColor:UIColor.darkGrayColor forState:UIControlStateNormal];
    [self.cc_navigationBar addSubview:popBtn];
    WS(weakSelf)
    [popBtn cc_tappedInterval:0.1 withBlock:^(id  _Nonnull view) {
        SS(strongSelf)
        [strongSelf.pop popUpCatSortSiftPopView];
    }];
}
-(void)initViews{
    self.view.backgroundColor = [UIColor whiteColor];
    self.sortSift1 = [[CatSortSift alloc]initOn:self.view frame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, WIDTH(), (HEIGHT()-STATUS_AND_NAV_BAR_HEIGHT)/2.0) title:@"全作品" dataArr:@[] theme:CatSortSiftThemeVerticality];
    [_sortSift1 updateDataArr:_array1];
    
    self.sortSift2 = [[CatSortSift alloc]initOn:self.view frame:CGRectMake(0, _sortSift1.sortSiftView.bottom, WIDTH(), (HEIGHT()-STATUS_AND_NAV_BAR_HEIGHT)/2.0) title:nil dataArr:@[] theme:CatSortSiftThemeHorizontal];
    [_sortSift2 updateDataArr:_array1];
}
#pragma mark - public

#pragma mark - notification

#pragma mark - delegate
- (void)catSortSiftPopSelect:(CatSortSiftPop *)catSortSiftPop leftIndex:(NSInteger)leftIndex {
    if (leftIndex==1) {
        [catSortSiftPop updateLeftSelectIndex:leftIndex rightSelectIndex:0 rightArr:@[@"我", @"变", @"了"]];
    }else if (leftIndex==2){
        [catSortSiftPop updateLeftSelectIndex:leftIndex rightSelectIndex:0 rightArr:@[@"我", @"也", @"变", @"了"]];
    }
}

- (void)catSortSiftPopSelect:(CatSortSiftPop *)catSortSiftPop leftIndex:(NSInteger)leftIndex rightIndex:(NSInteger)rightIndex {
    
}
#pragma mark - property



@end
