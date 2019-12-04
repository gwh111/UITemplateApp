//
//  CatCarouselView.h
//  Patient
//
//  Created by 路飞 on 2019/8/16.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CatCarouselTheme) {
    CatCarouselThemeHorizontal,//水平
    CatCarouselThemeVertical,//垂直
};

typedef void(^CatCarouselTapBlock)(NSInteger index, id data);
/**
 轮播scrollView-垂直轮播
 */
@interface CatCarouselView : UIScrollView

/**
 间隔时间
 */
@property (nonatomic, assign) CGFloat interval;

/**
 数据
 */
@property (nonatomic, copy) NSArray *dataArr;

/**
 初始化

 @param frame frame
 @param subViewClass 内容视图类名
 @param propertyName 视图类数据源属性名
 @param tapBlock 点击回调
 @return 实例
 */
- (instancetype)initWithFrame:(CGRect)frame subViewClass:(NSString *)subViewClass propertyName:(NSString *)propertyName tapBlock:(CatCarouselTapBlock)tapBlock DEPRECATED_MSG_ATTRIBUTE("Use Method 'initWithFrame:subViewClass:propertyName:tapBlock:theme:' Instead");

/**
初始化

 @param frame frame
 @param subViewClass 内容视图类名
 @param propertyName 视图类数据源属性名
 @parm theme 滚动方向
 @param tapBlock 点击回调
 @return 实例
*/
- (instancetype)initWithFrame:(CGRect)frame subViewClass:(NSString *)subViewClass propertyName:(NSString *)propertyName theme:(CatCarouselTheme)theme tapBlock:(CatCarouselTapBlock)tapBlock;
/**
 结束定时器
 */
- (void)timerStart;

/**
 开始定时器
 */
- (void)timerStop;

@end

NS_ASSUME_NONNULL_END
