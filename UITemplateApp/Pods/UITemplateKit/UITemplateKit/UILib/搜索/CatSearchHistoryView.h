//
//  CatSearchHistoryView.h
//  UITemplateKit
//
//  Created by ml on 2019/8/8.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CatStickerView.h"
#import "CatSearchRecordsModel.h"

NS_ASSUME_NONNULL_BEGIN

@class CatSearchHistoryView,CatSearchView;

@protocol CatSearchHistoryViewDelegate <NSObject>

- (void)historyView:(CatSearchHistoryView *)historyView didSelectAtIndexPath:(NSIndexPath *)indexPath;

- (void)historyView:(CatSearchHistoryView *)historyView clearAction:(UIButton *)sender;

@end

/// 历史搜索记录视图
@interface CatSearchHistoryView : UIView <CatStickerViewDatesource,CatStickerViewDelegate>

/**
 历史搜索内容视图
    头视图垃圾桶图片默认名为 history_search_delete
 
 自定义:
 ..stickerView.headerView.LYIcon.n2Text(@"custom_image_name")
 */
@property (nonatomic,strong) CatStickerView *stickerView;
/** 历史搜索模型 */
@property (nonatomic,strong) CatSearchRecordsModel *record;
@property (nonatomic,weak) id<CatSearchHistoryViewDelegate> delegate;
@property (nonatomic,weak) CatSearchView *searchView;



@end

NS_ASSUME_NONNULL_END
