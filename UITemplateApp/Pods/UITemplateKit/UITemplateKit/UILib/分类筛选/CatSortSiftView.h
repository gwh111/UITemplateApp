//
//  CatSortSiftView.h
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/16.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CatSortSiftTool.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CatSortSiftTheme) {
    CatSortSiftThemeVerticality,//选择列表纵向
    CatSortSiftThemeHorizontal//选择列表横向
};

@class CatSortSiftView;
@protocol CatSortSiftViewDelegate <NSObject>

@optional
- (void)catSortSiftView:(CatSortSiftView *)catSortSiftView didSelectRowAtSection:(NSInteger)section index:(NSInteger)index;

@end

@interface CatSortSiftView : UIView

@property (nonatomic, weak) id<CatSortSiftViewDelegate>delegate;
/**
 初始化

 @param frame frame
 @param title 大标题
 @param dataArr 数据
 @param theme 选项列表样式
 */
- (instancetype)initWithFrame:(CGRect)frame title:(nullable NSString*)title dataArr:(NSArray<CatSortSiftOutModel*>*)dataArr theme:(CatSortSiftTheme)theme;

/**
 更新数据

 @param dataArr 数据数组
 */
- (void)updateDataArr:(NSArray<CatSortSiftOutModel*>*)dataArr;

@end

NS_ASSUME_NONNULL_END
