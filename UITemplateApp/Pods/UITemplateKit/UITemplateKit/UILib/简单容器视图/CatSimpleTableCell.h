//
//  CatSimpleTableCell.h
//  LYCommonUI
//
//  Created by Liuyi on 2019/6/29.
//  Copyright © 2019 Shepherd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CatSimpleView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CatSimpleTableCell : UITableViewCell

@property (nonatomic,strong,readonly) CatCombineView *sview;

@end

UIKIT_EXTERN NSString *const CatSimpleTableCellString;

NS_ASSUME_NONNULL_END
