//
//  CatSimpleCollectionCell.h
//  UITemplateKit
//
//  Created by ml on 2019/7/3.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CatSimpleView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CatSimpleCollectionCell : UICollectionViewCell

@property (nonatomic,strong,readonly) CatCombineView *sview;

@end

UIKIT_EXTERN NSString *const CatSimpleCollectionCellString;

NS_ASSUME_NONNULL_END
