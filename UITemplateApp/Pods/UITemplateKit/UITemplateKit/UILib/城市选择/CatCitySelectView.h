//
//  CatCitySelectView.h
//  UITemplateKit
//
//  Created by 路飞 on 2019/5/28.
//  Copyright © 2019 路飞. All rights reserved.
//

#define kCatCitySelectViewHeight RH(232.0f)
#define kCatCitySelectViewBtnW RH(60.0f)
#define kCatCitySelectViewBtnH RH(40.0f)

#import <UIKit/UIKit.h>
#import "ccs.h"

NS_ASSUME_NONNULL_BEGIN

@class CatCitySelectView;
@protocol CatCitySelectViewDelegate <NSObject>
@optional

/**
 取消
 
 @param citySelectView 城市选择器
 */
- (void)catCitySelectViewCancel:(CatCitySelectView*)citySelectView;

/**
 确认
 
 @param citySelectView 城市选择器
 @param selectProvince 省名
 @param selectCity 城市名
 @param selectDistrict 地区名
 */
- (void)catCitySelectViewConfirm:(CatCitySelectView*)citySelectView selectProvince:(NSString*)selectProvince selectCity:(NSString*)selectCity selectDistrict:(NSString*)selectDistrict;

@end

@interface CatCitySelectView : UIView

@property (nonatomic, weak) id<CatCitySelectViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
