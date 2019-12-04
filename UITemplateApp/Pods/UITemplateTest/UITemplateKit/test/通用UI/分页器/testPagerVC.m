//
//  testPagerVC.m
//  UITemplateLib
//
//  Created by gwh on 2019/4/24.
//  Copyright © 2019 gwh. All rights reserved.
//

#define NAV_BAR_HEIGHT (44.f)
#define STATUS_AND_NAV_BAR_HEIGHT (STATUS_BAR_HEIGHT + NAV_BAR_HEIGHT)
#define STATUS_BAR_HEIGHT (CGRectGetHeight([UIApplication sharedApplication].statusBarFrame))

#import "testPagerVC.h"
#import "CatPager.h"

@interface testPagerVC ()<CatPagerDelegate>

@property (nonatomic, strong) CatPager* catPager1;
@property (nonatomic, strong) CatPager* catPager2;
@property (nonatomic, strong) CatPager* catPager3;
@property (nonatomic, strong) CatPager* catPager4;
@property (nonatomic, strong) CatPager* catPager5;
@property (nonatomic, strong) CatPager* catPager6;
@property (nonatomic, strong) CatPager* catPager7;


@property (nonatomic, strong) UIScrollView* scrollV1;
@property (nonatomic, strong) UIScrollView* scrollV2;
@property (nonatomic, strong) UIScrollView* scrollV3;
@property (nonatomic, strong) UIScrollView* scrollV4;
@property (nonatomic, strong) UIScrollView* scrollV5;
@property (nonatomic, strong) UIScrollView* scrollV6;
@property (nonatomic, strong) UIScrollView* scrollV7;
@end

@implementation testPagerVC

- (void)cc_viewDidLoad {
    
    UIScrollView *backScrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, WIDTH(), HEIGHT()-STATUS_AND_NAV_BAR_HEIGHT)];
    backScrollV.backgroundColor = RGBA(28, 29, 32, 1);
    [self.view addSubview:backScrollV];
    
    UIView* contentV1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(), RH(100))];
    [backScrollV addSubview:contentV1];
    self.catPager1 = [[CatPager alloc]initOn:contentV1 theme:CatPagerThemeRect itemArr:@[@"蒙奇·D·路飞", @"罗罗诺亚·佐隆", @"文斯莫克·三治", @"托尼托尼·乔巴", @""] selectedIndex:0];
    _catPager1.delegate = self;
    _scrollV1 = [self createScrollView:CGRectMake(0, _catPager1.segment.bottom, WIDTH(), RH(55.0f)) superView:contentV1 count:5];
    _catPager1.contentScrollView = _scrollV1;
    
    UIView* contentV2 = [[UIView alloc]initWithFrame:CGRectMake(0, contentV1.bottom, WIDTH(), RH(100))];
    [backScrollV addSubview:contentV2];
    self.catPager2 = [[CatPager alloc]initOn:contentV2 theme:CatPagerThemeRound itemArr:@[@"蒙奇·D·路飞", @"罗罗诺亚·佐隆", @"文斯莫克·三治", @"托尼托尼·乔巴", @""] selectedIndex:0];
    _catPager2.delegate = self;
    _scrollV2 = [self createScrollView:CGRectMake(0, _catPager2.segment.bottom, WIDTH(), RH(47.0f)) superView:contentV2 count:5];
    _catPager2.contentScrollView = _scrollV2;
    
    UIView* contentV3 = [[UIView alloc]initWithFrame:CGRectMake(0, contentV2.bottom, WIDTH(), RH(100))];
    [backScrollV addSubview:contentV3];
    self.catPager3 = [[CatPager alloc]initOn:contentV3 theme:CatPagerThemeRoundCorner itemArr:@[@"蒙奇·D·路飞", @"罗罗诺亚·佐隆", @"文斯莫克·三治", @"托尼托尼·乔巴", @""] selectedIndex:0];
    _catPager3.delegate = self;
    _scrollV3 = [self createScrollView:CGRectMake(0, _catPager3.segment.bottom, WIDTH(), RH(27.0f)) superView:contentV3 count:5];
    _catPager3.contentScrollView = _scrollV3;
    [_catPager3 updateBottomLine:NO];
    [_catPager3 updateHeight:RH(60)];
    
    UIView* contentV4 = [[UIView alloc]initWithFrame:CGRectMake(0, contentV3.bottom, WIDTH(), RH(100))];
    contentV4.backgroundColor = [UIColor whiteColor];
    [backScrollV addSubview:contentV4];
    self.catPager4 = [[CatPager alloc]initOn:contentV4 theme:CatPagerThemeLine itemArr:@[@"蒙奇", @"DDDDDD", @"路飞"] selectedIndex:0];
    _catPager4.delegate = self;
    _scrollV4 = [self createScrollView:CGRectMake(0, _catPager4.segment.bottom, WIDTH(), RH(55.0f)) superView:contentV4 count:3];
    _catPager4.contentScrollView = _scrollV4;
    [_catPager4 updateSelectedTextColor:RGBA(36, 151, 235, 1) selectedBackColor:[UIColor whiteColor] textColor:RGBA(102, 102, 102, 1) backColor:[UIColor whiteColor] bottomLineColor:RGBA(36, 151, 235, 1)];
    [_catPager4 updateWidth:WIDTH()-RH(160.0f)];
    [_catPager4 updateItemAtIndex:0 tagType:CatPagerCellTagTypeContent content:@"3"];
    [_catPager4 updateItemAtIndex:1 tagType:CatPagerCellTagTypeContent content:@"今日今日今日(20)"];
    [_catPager4 updateItemAtIndex:2 tagType:CatPagerCellTagTypePoint content:nil];
     
    UIView* contentV5 = [[UIView alloc]initWithFrame:CGRectMake(0, contentV4.bottom, WIDTH(), RH(100))];
    [backScrollV addSubview:contentV5];
    self.catPager5 = [[CatPager alloc]initOn:contentV5 theme:CatPagerThemeLineEqual itemArr:@[@"蒙奇", @"D", @"路飞"] selectedIndex:0];
    _catPager5.delegate = self;
    _scrollV5 = [self createScrollView:CGRectMake(0, _catPager5.segment.bottom, WIDTH(), RH(47.0f)) superView:contentV5 count:3];
    _catPager5.contentScrollView = _scrollV5;
    [_catPager5 updateItems:@[@"罗罗诺亚", @"佐隆", @"三治"]];
    [_catPager5 updateSelectedTextColor:[UIColor cyanColor] selectedBackColor:[UIColor orangeColor] textColor:[UIColor blueColor] backColor:[UIColor grayColor] bottomLineColor:[UIColor whiteColor]];
    
    UIView* contentV6 = [[UIView alloc]initWithFrame:CGRectMake(0, contentV5.bottom, WIDTH(), RH(100))];
    [backScrollV addSubview:contentV6];
    self.catPager6 = [[CatPager alloc]initOn:contentV6 theme:CatPagerThemeLineZoom itemArr:@[@"蒙奇", @"D", @"路飞"] selectedIndex:0];
    _catPager6.delegate = self;
    _scrollV6 = [self createScrollView:CGRectMake(0, _catPager6.segment.bottom, WIDTH(), RH(43.0f)) superView:contentV6 count:3];
    _catPager6.contentScrollView = _scrollV6;
    [_catPager2 updateBottomLine:NO];
    [_catPager6 updateItemAtIndex:1 tagType:CatPagerCellTagTypeContent content:@"今日今日今日(20)"];
//    [_catPager6 updateWidth:WIDTH()/2];
//    [_catPager6 updateHeight:30];
    
    
    [_catPager6 updateCatPagerThemeLineSize:CGSizeMake(RH(20.0f), RH(4.0f))];
//    [_catPager6 updateCatPagerThemeLineZoom:RF(14.0f)];//所有字体一样大了
    [_catPager6 updateSelectedTextColor:RGBA(36, 151, 235, 1) selectedBackColor:[UIColor whiteColor] textColor:RGBA(190, 190, 190, 1) backColor:[UIColor whiteColor] bottomLineColor:RGBA(36, 151, 235, 1)];
    [_catPager6 updateItems:@[@"六一",@"六二", @"六三"]];
    
    UIView* contentV7 = [[UIView alloc]initWithFrame:CGRectMake(0, contentV6.bottom, WIDTH(), RH(100))];
    [backScrollV addSubview:contentV7];
    self.catPager7 = [[CatPager alloc]initOn:contentV7 theme:CatPagerThemeSegmentRound itemArr:@[@"蒙奇", @"D", @"路飞"] selectedIndex:0];
    _catPager7.delegate = self;
    self.scrollV7 = [self createScrollView:CGRectMake(0, _catPager7.segment.bottom+RH(8.0f), WIDTH(), RH(27.0f)) superView:contentV7 count:3];
    _catPager7.contentScrollView = _scrollV7;
    
    [_catPager7 updateWidth:WIDTH()/2];
        [_catPager7 updateHeight:RH(50)];
        [_catPager7 updatePadding:2];
        backScrollV.contentSize = CGSizeMake(WIDTH(), contentV7.bottom);
    }
-(void)dealloc{
        
}

-(UIScrollView*)createScrollView:(CGRect)rect superView:(UIView*)superView count:(NSInteger)count{
    
    UIScrollView* scrollView = [[UIScrollView alloc]initWithFrame:rect];
    [superView addSubview:scrollView];
    
    for (NSInteger i = 0; i < count; i++) {
        UIView* v = [[UIView alloc]initWithFrame:CGRectMake(i*rect.size.width, 0, rect.size.width, rect.size.height)];
        v.backgroundColor = RGBA(random()%255, random()%255, random()%255, 1);
        [scrollView addSubview:v];
    }
    
    scrollView.contentSize = CGSizeMake(rect.size.width*count, rect.size.height);
    scrollView.pagingEnabled = YES;
    return scrollView;
}

#pragma mark - delegate
-(void)catPager:(CatPager *)catPager didSelectRowAtIndex:(NSInteger)index{
    if (catPager == _catPager1) {
        [_scrollV1 setContentOffset:CGPointMake(WIDTH()*index, 0) animated:YES];
    }else if (catPager == _catPager2) {
        [_scrollV2 setContentOffset:CGPointMake(WIDTH()*index, 0) animated:YES];
    }else if (catPager == _catPager3) {
        [_scrollV3 setContentOffset:CGPointMake(WIDTH()*index, 0) animated:YES];
    }else if (catPager == _catPager4) {
        [_scrollV4 setContentOffset:CGPointMake(WIDTH()*index, 0) animated:YES];
    }else if (catPager == _catPager5) {
        [_scrollV5 setContentOffset:CGPointMake(WIDTH()*index, 0) animated:YES];
    }else if (catPager == _catPager6) {
        [_scrollV6 setContentOffset:CGPointMake(WIDTH()*index, 0) animated:YES];
    }else if (catPager == _catPager7) {
        [_scrollV7 setContentOffset:CGPointMake(WIDTH()*index, 0) animated:YES];
    }
}
@end
