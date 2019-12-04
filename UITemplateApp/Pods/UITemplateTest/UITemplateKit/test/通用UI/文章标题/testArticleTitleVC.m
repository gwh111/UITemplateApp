//
//  testArticleTitleVC.m
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/20.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#define NAV_BAR_HEIGHT (44.f)
#define STATUS_AND_NAV_BAR_HEIGHT (STATUS_BAR_HEIGHT + NAV_BAR_HEIGHT)
#define STATUS_BAR_HEIGHT (CGRectGetHeight([UIApplication sharedApplication].statusBarFrame))

#import "testArticleTitleVC.h"
#import "CatArticleTitle.h"

@interface testArticleTitleVC ()

@property (nonatomic, strong) CatArticleTitle* artileTitle1;
@property (nonatomic, strong) CatArticleTitle* artileTitle2;
@property (nonatomic, strong) CatArticleTitle* artileTitle3;
@property (nonatomic, strong) CatArticleTitle* artileTitle4;
@property (nonatomic, strong) CatArticleTitle* artileTitle5;
@property (nonatomic, strong) CatArticleTitle* artileTitle6;

@end

@implementation testArticleTitleVC

#pragma mark - lifeCycle
- (void)cc_viewDidLoad {
    [self initDatas];
    [self initNav];
    [self initViews];
}

#pragma mark - network

#pragma mark - private
-(void)initDatas{
    
}
-(void)initNav{
    
}
-(void)initViews{
    UIScrollView* scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, WIDTH(), HEIGHT()-STATUS_AND_NAV_BAR_HEIGHT)];
    scrollView.backgroundColor = RGBA(238, 238, 238, 1);
    [self.view addSubview:scrollView];
    
    self.artileTitle1 = [[CatArticleTitle alloc]initOn:scrollView origin:CGPointMake(0, 0) title:@"这是一个很长的标题不然会不好看，而且那些文章的标题本来也没一个短的" imgTagArr:@[[UIImage imageNamed:@"subject_show"],[UIImage imageNamed:@"subject_top_icon"], [UIImage imageNamed:@"subject_transmit_icon"]] name:@"超人的电话亭" personBlock:^(NSString * _Nonnull name) {
        //点击头像了
        NSLog(@"点击了头像");
    }];
    self.artileTitle2 = [[CatArticleTitle alloc]initOn:scrollView origin:CGPointMake(0, _artileTitle1.articleTitleView.bottom+10) headImgUrl:@"http://p1.qhimgs4.com/t0175e4cb83bebdccfe.jpg" headPlaceholder:nil title:@"这儿是一个很长的标题不然会不好看，而且那些文章的标题本来也没一个短的" iconUrl:@"http://ww2.sinaimg.cn/large/9e531b2bgw1fb8tgnf5qaj218g0p0agh.jpg" iconPlaceholder:nil name:@"超人的电话亭" time:@"4小时前" isFocused:NO personBlock:^(NSString * _Nonnull name) {
        //点击头像了
        NSLog(@"点击了头像");
    } focusBlock:^(UIButton * _Nonnull focusBtn) {
        //点击关注了
        NSLog(@"点击了关注-------------%@", focusBtn.isSelected?@"已关注":@"未关注");
    }];
    self.artileTitle3 = [[CatArticleTitle alloc]initOn:scrollView origin:CGPointMake(0, _artileTitle2.articleTitleView.bottom+10) title:@"这是一个稍微有点长的标题" iconUrl:@"http://ww2.sinaimg.cn/large/9e531b2bgw1fb8tgnf5qaj218g0p0agh.jpg" iconPlaceholder:nil name:@"超人的电话亭" time:@"2018-07-03" indexTagArr:@[@"读书", @"思想", @"自媒体", @"写作"] personBlock:^(NSString * _Nonnull name) {
        //点击头像了
        NSLog(@"点击了头像");
    } indexBlock:^(NSString * _Nonnull tagName, NSInteger index) {
        //点击头像了
        NSLog(@"点击了tag-------------%@", tagName);
    }];
    self.artileTitle4 = [[CatArticleTitle alloc]initOn:scrollView origin:CGPointMake(0, _artileTitle3.articleTitleView.bottom+10) title:@"#这儿是一个很长的标题不然会不好看，而且那些文章的标题本来也没一个短的" iconUrl:@"http://ww2.sinaimg.cn/large/9e531b2bgw1fb8tgnf5qaj218g0p0agh.jpg" iconPlaceholder:nil name:@"超人的电话亭" description:@"设计，生活" personBlock:^(NSString * _Nonnull name) {
        //点击头像了
        NSLog(@"点击了头像");
    } focusBlock:^(UIButton * _Nonnull focusBtn) {
        //点击关注了
        NSLog(@"点击了关注-------------%@", focusBtn.isSelected?@"已关注":@"未关注");
    }];
    self.artileTitle5 = [[CatArticleTitle alloc]initOn:scrollView origin:CGPointMake(0, _artileTitle4.articleTitleView.bottom+10) title:@"#这儿是一个很长的标题不然会不好看，而且那些文章的标题本来也没一个短的" subTitle:@"这是一个小小的副标题" name:@"超人的电话亭" iconUrl:@"http://ww2.sinaimg.cn/large/9e531b2bgw1fb8tgnf5qaj218g0p0agh.jpg" iconPlaceholder:nil personBlock:^(NSString * _Nonnull name) {
        //点击头像了
        NSLog(@"点击了头像");
    }];
    self.artileTitle6 = [[CatArticleTitle alloc]initOn:scrollView origin:CGPointMake(0, _artileTitle5.articleTitleView.bottom+10) title:@"#这儿是一个很长的标题不然会不好看，而且那些文章的标题本来也没一个短的" name:@"超人的电话亭" iconUrl:@"http://ww2.sinaimg.cn/large/9e531b2bgw1fb8tgnf5qaj218g0p0agh.jpg" iconPlaceholder:nil time:@"2018-7-3 22:38" personBlock:^(NSString * _Nonnull name) {
        //点击头像了
        NSLog(@"点击了头像");
    }];
    
    scrollView.contentSize = CGSizeMake(WIDTH(), _artileTitle6.articleTitleView.bottom+100);
}
#pragma mark - public

#pragma mark - notification

#pragma mark - delegate

#pragma mark - property


@end
