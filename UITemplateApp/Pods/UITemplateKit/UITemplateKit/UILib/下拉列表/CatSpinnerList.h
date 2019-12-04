//
//  CatSpinnerList.h
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/5.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CatSpinnerTool.h"

@interface CatSpinnerTableViewCell : UITableViewCell

@property (nonatomic, strong) CatSpinnerModel* model; 

+(instancetype)createCatSpinnerTableViewCellWithTableView:(UITableView*)tableView;

@end

NS_ASSUME_NONNULL_BEGIN
@class catSpinnerList;
@protocol CatSpinnerListDelegate <NSObject>

@optional
- (void)catSpinnerList:(CatSpinnerList *)catSpinnerList didSelectRowAtIndex:(NSInteger)index itemName:(NSString *)itemName;
- (void)dismissCatSpinnerList:(CatSpinnerList *)catSpinnerList;

@end

//下拉列表
@interface CatSpinnerList : UITableView

//图片数组
@property (nonatomic, strong) NSArray* iconArr;
//内容数组
@property (nonatomic, strong) NSArray* itemArr;

@property (nonatomic, weak) id<CatSpinnerListDelegate>cslDelegate;
/**
 创建下拉列表

 @param originPoint 下拉列表左上角位置
 @param iconArr 图片数组
 @param itemArr 内容数组
 @return 实例
 */
- (instancetype)initWithOriginPoint:(CGPoint)originPoint iconArr:(nullable NSArray<NSString *> *)iconArr itemArr:(NSArray<NSString *> *)itemArr;

/**
 *  设置宽度 默认自适应
 */
- (void)updateWidth:(float)width;

/**
 更新文字颜色及背景色

 @param textColor 文字颜色
 @param backColor 背景颜色  
 */
-(void)updateTextColor:(UIColor *)textColor backColor:(UIColor *)backColor;

/**
 *  设置列表名称 没有图标情况
 items   列表名称数组
 */
- (void)updateItems:(NSArray *)items;

/**
 *  设置图标和列表名称
 icons   图标名称数组
 items   列表名称数组
 */
- (void)updateIcons:(nullable NSArray *)icons items:(NSArray *)items;
@end

NS_ASSUME_NONNULL_END
