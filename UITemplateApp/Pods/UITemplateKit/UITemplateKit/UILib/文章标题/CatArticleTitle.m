//
//  CatArticleTitle.m
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/20.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatArticleTitle.h"

@interface CatArticleTitle ()

@property (nonatomic, readwrite, strong) CatArticleTitleView* articleTitleView;

@end

@implementation CatArticleTitle

- (instancetype)initOn:(UIView *)view origin:(CGPoint)origin title:(NSString *)title imgTagArr:(NSArray<UIImage *> *)imgTagArr name:(NSString *)name personBlock:(PersonBlock)personBlock{
    if (self = [super init]) {
        self.articleTitleView = [[CatArticleTitleView alloc]initWithFrame:CGRectMake(origin.x, origin.y, view.frame.size.width, 0) title:title subTitle:nil imgTagArr:imgTagArr name:name iconUrl:nil iconPlaceholderImg:nil headImgUrl:nil headPlaceholderImg:nil time:nil description:nil indexTagArr:nil theme:CatArticleTitleThemeMultiplyTag isFocused:NO personBlock:personBlock focusBlock:nil indexBlock:nil];
        [view addSubview:_articleTitleView];
    }
    return self;
}

- (instancetype)initOn:(UIView *)view origin:(CGPoint)origin headImgUrl:(nonnull NSString *)headImgUrl headPlaceholder:(nullable UIImage *)headPlaceholder title:(nonnull NSString *)title iconUrl:(nonnull NSString *)iconUrl iconPlaceholder:(nullable UIImage *)iconPlaceholder name:(nonnull NSString *)name time:(nonnull NSString *)time isFocused:(BOOL)isFocused personBlock:(nonnull PersonBlock)personBlock focusBlock:(nonnull FocusBlock)focusBlock{
    if (self = [super init]) {
        self.articleTitleView = [[CatArticleTitleView alloc]initWithFrame:CGRectMake(origin.x, origin.y, view.frame.size.width, 0) title:title subTitle:nil imgTagArr:nil name:name iconUrl:iconUrl iconPlaceholderImg:iconPlaceholder headImgUrl:headImgUrl headPlaceholderImg:headPlaceholder time:time description:nil indexTagArr:nil theme:CatArticleTitleThemeHeadView isFocused:isFocused personBlock:personBlock focusBlock:focusBlock indexBlock:nil];
        [view addSubview:_articleTitleView];
    }
    return self;
}

- (instancetype)initOn:(UIView *)view origin:(CGPoint)origin title:(NSString *)title iconUrl:(NSString *)iconUrl iconPlaceholder:(UIImage *)iconPlaceholder name:(NSString *)name time:(NSString *)time indexTagArr:(NSArray<NSString *> *)indexTagArr personBlock:(PersonBlock)personBlock indexBlock:(IndexBlock)indexBlock{
    if (self = [super init]) {
        self.articleTitleView = [[CatArticleTitleView alloc]initWithFrame:CGRectMake(origin.x, origin.y, view.frame.size.width, 0) title:title subTitle:nil imgTagArr:nil name:name iconUrl:iconUrl iconPlaceholderImg:iconPlaceholder headImgUrl:nil headPlaceholderImg:nil time:time description:nil indexTagArr:indexTagArr theme:CatArticleTitleThemeMultiplyIndex isFocused:NO personBlock:personBlock focusBlock:nil indexBlock:indexBlock];
        [view addSubview:_articleTitleView];
    }
    return self;
}

- (instancetype)initOn:(UIView *)view origin:(CGPoint)origin title:(NSString *)title iconUrl:(NSString *)iconUrl iconPlaceholder:(UIImage *)iconPlaceholder name:(NSString *)name description:(NSString *)description personBlock:(PersonBlock)personBlock focusBlock:(FocusBlock)focusBlock{
    if (self = [super init]) {
        self.articleTitleView = [[CatArticleTitleView alloc]initWithFrame:CGRectMake(origin.x, origin.y, view.frame.size.width, 0) title:title subTitle:nil imgTagArr:nil name:name iconUrl:iconUrl iconPlaceholderImg:iconPlaceholder headImgUrl:nil headPlaceholderImg:nil time:nil description:description indexTagArr:nil theme:CatArticleTitleThemeDescriptionFocus isFocused:NO personBlock:personBlock focusBlock:focusBlock indexBlock:nil];
        [view addSubview:_articleTitleView];
    }
    return self;
}

- (instancetype)initOn:(UIView *)view origin:(CGPoint)origin title:(NSString *)title subTitle:(NSString *)subTitle name:(NSString *)name iconUrl:(NSString *)iconUrl iconPlaceholder:(UIImage *)iconPlaceholder personBlock:(PersonBlock)personBlock{
    if (self = [super init]) {
        self.articleTitleView = [[CatArticleTitleView alloc]initWithFrame:CGRectMake(origin.x, origin.y, view.frame.size.width, 0) title:title subTitle:subTitle imgTagArr:nil name:name iconUrl:iconUrl iconPlaceholderImg:iconPlaceholder headImgUrl:nil headPlaceholderImg:nil time:nil description:nil indexTagArr:nil theme:CatArticleTitleThemeSubtitle isFocused:NO personBlock:personBlock focusBlock:nil indexBlock:nil];
        [view addSubview:_articleTitleView];
    }
    return self;
}

-(instancetype)initOn:(UIView *)view origin:(CGPoint)origin title:(NSString *)title name:(NSString *)name iconUrl:(NSString *)iconUrl iconPlaceholder:(UIImage *)iconPlaceholder time:(NSString *)time personBlock:(PersonBlock)personBlock{
    if (self = [super init]) {
        self.articleTitleView = [[CatArticleTitleView alloc]initWithFrame:CGRectMake(origin.x, origin.y, view.frame.size.width, 0) title:title subTitle:nil imgTagArr:nil name:name iconUrl:iconUrl iconPlaceholderImg:iconPlaceholder headImgUrl:nil headPlaceholderImg:nil time:time description:nil indexTagArr:nil theme:CatArticleTitleThemeNormal isFocused:NO personBlock:personBlock focusBlock:nil indexBlock:nil];
        [view addSubview:_articleTitleView];
    }
    return self;
}
@end
