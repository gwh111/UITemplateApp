//
//  CatPickerPhotoController.h
//  Patient
//
//  Created by ml on 2019/6/14.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CatPreviewToolView.h"
#import "CatFakeNavView.h"
#import "CatImagePreviewController.h"

NS_ASSUME_NONNULL_BEGIN

#define CatTakePhoneImages(SELF,CHECK,UNCHECK,TAKEPHOTO) \
    SELF.checkImage = [UIImage imageNamed:CHECK]; \
    SELF.uncheckImage = [UIImage imageNamed:UNCHECK]; \
    SELF.takePhotoImage = [UIImage imageNamed:TAKEPHOTO]

@class CatTakePhotoCell,CatPickerPhotoController;

typedef NS_ENUM(NSInteger,CatPickerPhotoMode) {
    CatPickerPhotoModeSingle,
    CatPickerPhotoModeMultiple
};

@protocol CatPickerPhotoControllerDelegate <NSObject>

/**
 完成选择的图片

 @param controller CatPickerPhotoController 对象
 @param images 选择的图片数组
 @param assets 资源
 @param isSelectOriginPhoto 是否选择原图
 @param ids 已选择的图片资源的id 
 
 */
- (void)catPickerPhotoController:(CatPickerPhotoController *)controller
       didFinishPickingWithItems:(NSArray<UIImage *> *)images
                          assets:(NSArray *)assets
             isSelectOriginPhoto:(BOOL)isSelectOriginPhoto
                             ids:(NSArray *)ids;

- (void)catPickerPhotoController:(CatPickerPhotoController *)controller
       didFinishPickingWithItems:(NSArray<UIImage *> *)images DEPRECATED_MSG_ATTRIBUTE("Using catPickerPhotoController:didFinishPickingWithItems:assets:isSelectOriginPhoto:ids:");

@optional
/**
 完成选择是已选中的图片的id数组
 
 @param controller CatPickerPhotoController 对象
 @param ids 图片id数组
 */
- (void)catPickerPhotoController:(CatPickerPhotoController *)controller
         didFinishPickingWithIds:(NSArray *)ids DEPRECATED_MSG_ATTRIBUTE("Using catPickerPhotoController:didFinishPickingWithItems:assets:isSelectOriginPhoto:ids:");;

/**
 点击时的回调
 
 已到最大时若要弹窗,在该方法操作
 
 @param controller CatPickerPhotoController 对象
 @param indexPath 索引
 @param isMax 是否达到最大可选数目
 */
- (void)catPickerPhotoController:(CatPickerPhotoController *)controller
        didSelectItemAtIndexPath:(NSIndexPath *)indexPath
                           isMax:(BOOL)isMax;

@end

@interface CatPickerPhotoController : UIViewController

@property (nonatomic,weak) id<CatPickerPhotoControllerDelegate> delegate;

/// 默认多选
@property (nonatomic,assign) CatPickerPhotoMode mode;

@property (nonatomic,strong,readonly) CatFakeNavView *navView;

/// 底部工具视图
@property (nonatomic,strong,readonly) CatPreviewToolView *senderView;

/// 返回按钮
@property (nonatomic,strong,readonly) UIButton *backButton;

/// 自定义拍照图片
@property (nonatomic,strong) UIImage *takePhotoImage;

/// 选中时的图片
@property (nonatomic,strong) UIImage *checkImage;

/// 未选中的图片
@property (nonatomic,strong) UIImage *uncheckImage;

/// 最大选择数量 默认9张
@property (nonatomic,assign) NSInteger maxCount;

/// 默认选中的图片ids
@property (nonatomic,strong) NSArray *defalutPickerIds;

/// 相册分类视图的圆角 默认17
@property (nonatomic,assign) CGFloat cornerRadius;

/// 自定义缩略图尺寸 默认一行4张
@property (nonatomic,assign) CGSize thumbnailSize;

/// 下载 & 预览图尺寸 默认为屏幕宽高
/// 调用 PHImageManager
/// requestImageForAsset:targetSize:contentMode:options:resultHandler:
///
/// @note
/// When you call this method, Photos loads or generates an image of the asset at, or near, the size you specify.
/// 从文档来看可能会加载或生成的图片尺寸可能会只是接近targetSize
/// 测试时发现有的图片传屏幕尺寸也会返回 <UIImage:0x283041cb0 anonymous {4032, 3024}> 尺寸的图片
@property (nonatomic,assign) CGSize previewSize;

/// 预览视图控制器 自定义界面
@property (nonatomic,weak,readonly) CatImagePreviewController *previewVC;

/// 照片选择控制器消失的回调
@property (nonatomic,copy) void (^dismissCompletion)(void);

/// 1. 调用创建CatPickerPhotoController对象
/// CatPickerPhotoController *vc = [CatPickerPhotoController controllerWithMode:CatPickerPhotoModeMultiple delegate:self];
///
/// 2. 自定义界面
/// vc.checkImage     = [UIImage imageNamed:@"xxx"];
/// vc.uncheckImage   = [UIImage imageNamed:@"xxx"];
/// vc.takePhotoImage = [UIImage imageNamed:@"xxx"];
/// 或
/// CatTakePhoneImages(vc,@"check",@"uncheck",@"takePhoto")
///
/// 3. 设置已选择的照片id数组[可选]
/// vc.defalutPickerIds = self.ids;
///
/// 4. 展示
/// [vc presentFromRootViewController:self]; /// self is an viewcontroller object
///
/// 5. 在回调中获取选择的照片
///
/// @note:若一个界面中存在多个按钮点击都要选择照片,不建议持有实例对象,而是类似
///
/// CatPickerPhotoController *vc = [CatPickerPhotoController controllerWithMode:CatPickerPhotoModeMultiple delegate:self];
/// vc.view.tag = xxx;
///
/// 在回调中通过controller参数进行判断点击的具体按钮
///
/// @param mode 选择模式
/// @param delegate 代理对象
+ (instancetype)controllerWithMode:(CatPickerPhotoMode)mode
                          delegate:(id<CatPickerPhotoControllerDelegate>)delegate;

/// 展示照片选择控制器
/// @param rootViewController 根控制器
- (void)presentFromRootViewController:(UIViewController *)rootViewController;

@end

/// TODO
/// 加载预览图或下载图片失败通知 比如
/// PHImageErrorKey = "Error Domain=CloudPhotoLibraryErrorDomain Code=256 \"Disk space is very low\" UserInfo={NSLocalizedDescription=Disk space is very low}";
/// UIKIT_EXTERN NSNotificationName const CatPreviewFailureNotification;

NS_ASSUME_NONNULL_END
