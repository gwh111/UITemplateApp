//
//  CatZoomScrollView.h
//  kk_buluo
//
//  Created by david on 2019/9/24.
//  Copyright © 2019 yaya. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^OneTapCloseBlock)(void);

@interface CatZoomScrollView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic,weak) UIImageView *imageView;
@property (nonatomic,assign) CGFloat currentScale;
@property (nonatomic,copy) OneTapCloseBlock closeBlock;

@end

NS_ASSUME_NONNULL_END
