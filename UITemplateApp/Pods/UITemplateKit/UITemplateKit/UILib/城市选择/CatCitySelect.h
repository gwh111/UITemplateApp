//
//  CatCitySelect.h
//  UITemplateKit
//
//  Created by 路飞 on 2019/5/28.
//  Copyright © 2019 路飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CatCitySelectView.h"

NS_ASSUME_NONNULL_BEGIN

@class CatCitySelect;
@protocol CatCitySelectDelegate <NSObject>
@optional

/**
 取消

 @param citySelect 城市选择器
 */
- (void)catCitySelectCancel:(CatCitySelect*)citySelect;

/**
 确认

 @param citySelect 城市选择器
 @param selectProvince 省名
 @param selectCity 城市名
 @param selectDistrict 地区名
 */
- (void)catCitySelectConfirm:(CatCitySelect*)citySelect selectProvince:(NSString*)selectProvince selectCity:(NSString*)selectCity selectDistrict:(NSString*)selectDistrict;

@end

@interface CatCitySelect : NSObject

@property (nonatomic, weak) id<CatCitySelectDelegate>delegate;

/**
 弹出城市选择控件
 */
- (void)popUpCatCitySelectView;


/**
 收起城市选择控件
 */
-(void)dismissCatCitySelectView;
@end

NS_ASSUME_NONNULL_END
