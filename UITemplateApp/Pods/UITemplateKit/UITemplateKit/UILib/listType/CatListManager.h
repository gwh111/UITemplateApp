//
//  YCDataSource.h
//  UITemplateLib
//
//  Created by yichen on 2019/5/28.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CatListCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CatListManagerProtocol <NSObject>

@optional
-(void)didTouchCellContent:(CatListCell *)cell withType:(CatCellContentClickType)clickType withIndexPath:(NSIndexPath *)index withInfo:(NSInteger)info;

-(void)didTouchCellContent:(CatListCell *)cell withType:(CatCellContentClickType)clickType withModel:(id)model withInfo:(NSInteger)info;

@end

typedef void (^CellConfigureBefore)(CatListCell * cell, id model, NSIndexPath * indexPath);
typedef float (^CellHeightConfigure)(id model , NSIndexPath * indexPath);
typedef void (^CellClickConfigure)(id model , NSIndexPath * indexPath);

@interface CatListManager : NSObject<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak)id<CatListManagerProtocol> delegate;
/**
 创建数据源管理对象 自适应行高

 @param identifier reuseid
 @param before cellConfigure
 */
- (id)initWithIdentifier:(NSString *)identifier configureBlock:(CellConfigureBefore)before clickConfigure:(CellClickConfigure _Nullable)click;

/**
 创建数据源管理对象 手动配置行高

 @param identifier reuseid
 @param before cellConfigure
 @param height logic of cellHeight
 @param click logic of cellClicked
 */
- (id)initWithIdentifier:(NSString *)identifier configureBlock:(CellConfigureBefore)before heightConfigure:(CellHeightConfigure _Nullable)height clickConfigure:(CellClickConfigure _Nullable)click;

/**
 添加模型数组

 @param datas modelArray
 */
- (void)addDataArray:(NSArray *)datas;

/**
 清空模型数组
 */
- (void)clearDataArray;

@end

NS_ASSUME_NONNULL_END
