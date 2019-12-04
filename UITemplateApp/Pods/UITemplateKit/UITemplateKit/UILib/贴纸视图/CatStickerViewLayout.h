//
//  CatStickerViewLayout.h
//  UITemplateKit
//
//  Created by ml on 2019/7/11.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CatStickerViewLayout : NSObject

/// 行间距
@property (nonatomic,assign) CGFloat lineSpacing;
/// 列间距
@property (nonatomic,assign) CGFloat interitemSpacing;
/// 组间距
@property (nonatomic,assign) UIEdgeInsets marginSectionInset;


@end

NS_ASSUME_NONNULL_END
