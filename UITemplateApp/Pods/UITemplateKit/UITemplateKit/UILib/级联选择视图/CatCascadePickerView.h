//
//  CatCascadePickerView.h
//  UITemplateKit
//
//  Created by ml on 2019/8/13.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CatSimpleTableCell.h"
#import "CatCascadePickerHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

@class CatCascadePickerView;
@protocol CatCascadePickerViewDelegate <NSObject>

/**
 是否有下一级菜单,若有则调用代理方法

 根据 pickerView.currentSelectedSection 来判断
 
 @param pickerView 级联选择视图
 @return 是否有下一级菜单
 */
- (BOOL)nextLevel:(CatCascadePickerView *)pickerView;

- (NSInteger)cascadePickerView:(CatCascadePickerView *)pickerView
         numberOfRowsInSection:(NSInteger)section;


/**
 设置每一行的内容

 @param cascadePickerView 级联选择视图
 @param indexPath 索引
 @return 内容
 */
- (NSString *)cascadePickerView:(CatCascadePickerView *)cascadePickerView
         titleForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional

/**
 可在此处自定义每一行的样式
 
 @param cascadePickerView 选择视图
 @param tableView 对应组的tableView
 @param cell cell
 @param indexPath 索引
 @note cell.sview.titleLabel 存放内容
 */
- (void)cascadePickerView:(CatCascadePickerView *)cascadePickerView
                tableView:(UITableView *)tableView
          willDisplayCell:(CatSimpleTableCell *)cell
        forRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)cascadePickerView:(CatCascadePickerView *)cascadePickerView
  didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)cascadePickerView:(CatCascadePickerView *)cascadePickerView
      didTapViewAtSection:(NSInteger)section;

@end

// #warning In development...
@interface CatCascadePickerView : UIView

@property (nonatomic,strong,readonly) CatCascadePickerHeaderView *headerView;
@property (nonatomic,strong,readonly) UIScrollView *scrollView;

@property (nonatomic,weak) id<CatCascadePickerViewDelegate> delegate;

/** 当前处在哪一组 */
@property (nonatomic,assign,readonly) NSInteger currentSelectedSection;
@property (nonatomic,assign,readonly) NSInteger nextSection;

- (void)reloadDataWithSection:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END
