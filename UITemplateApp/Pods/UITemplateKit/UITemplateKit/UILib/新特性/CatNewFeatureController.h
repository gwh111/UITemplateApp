//
//  CatNewFeatureController.h
//  UITemplateKit
//
//  Created by ml on 2019/7/9.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CatPageControl : UIPageControl

@property (nonatomic, strong) UIImage *currentImage;
@property (nonatomic, strong) UIImage *inactiveImage;

@property (nonatomic, assign) CGSize currentImageSize;
@property (nonatomic, assign) CGSize inactiveImageSize;

@end

@interface CatNewFeatureController : UIViewController

/// 是否添加全屏的手势 默认添加
@property (nonatomic,assign) BOOL fullScreenTrigger;
/// 点击launchButton的回调
@property (nonatomic,copy) void (^completion)(void);
/// 启动按钮
@property (nonatomic,strong,readonly) UIButton *launchButton;
@property (nonatomic,strong) CatPageControl *pageControl;

- (instancetype)initWithImages:(NSArray *)images;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
