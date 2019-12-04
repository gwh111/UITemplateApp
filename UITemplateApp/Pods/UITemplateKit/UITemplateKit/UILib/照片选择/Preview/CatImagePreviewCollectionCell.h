//
//  CatImagePreviewCollectionCell.h
//  kk_buluo
//
//  Created by david on 2019/9/24.
//  Copyright © 2019 yaya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CatZoomScrollView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^OneTapCloseCellBlock)(void);

@interface CatImagePreviewCollectionCell : UICollectionViewCell

@property (nonatomic,weak) CatZoomScrollView *imageScrollView;
@property (nonatomic,strong) UIImage *img;

@property (nonatomic,copy) NSString *imageURL;

@property (nonatomic, copy) OneTapCloseCellBlock closeBlock;
@end

NS_ASSUME_NONNULL_END
