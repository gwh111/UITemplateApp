//
//  CatCascadePickerHeaderView.h
//  UITemplateKit
//
//  Created by ml on 2019/8/13.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CatSimpleView.h"
#import "CatStickerView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CatCascadePickerHeaderView : UIView

@property (nonatomic,strong,readonly) CatSimpleView *titleView;
@property (nonatomic,strong,readonly) CatStickerView *sectionView;


@end

NS_ASSUME_NONNULL_END
