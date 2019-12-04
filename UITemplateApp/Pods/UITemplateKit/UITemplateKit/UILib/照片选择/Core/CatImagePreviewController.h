//
//  CatImagePreviewController.h
//  UITemplateKit
//
//  Created by ml on 2019/11/6.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface CatImagePreviewController : UIViewController

@property (nonatomic,assign) NSUInteger currentIndex;

/// 已选择的资源
@property (nonatomic,strong) NSMutableArray *selectedPhotoAssets;

/// 预览图尺寸
@property (nonatomic,assign) CGSize previewSize;

/// 是否单选
/// 单选时,目前滑动即要改变已选择的资源
/// 多选时,不改变已选择的资源
@property (nonatomic,assign) BOOL single;

+ (instancetype)controllerWithAssets:(PHFetchResult<PHAsset *>*)assets completion:(void (^)(UIButton *sender))completion;

- (void)presentFromRootViewController:(UIViewController *)rootViewController;

@end

NS_ASSUME_NONNULL_END
