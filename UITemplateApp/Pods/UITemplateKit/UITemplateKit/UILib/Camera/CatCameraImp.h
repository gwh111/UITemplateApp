//
//  CatScanner.h
//  UITemplateKit
//
//  Created by ml on 2019/10/29.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSInteger,CatCameraOption) {
    CatCameraOptionMoment          = 1 << 0,
    CatCameraOptionContinued       = 1 << 1, /// unimplement
    CatCameraOptionScanner         = 1 << 2,
    CatCameraOptionRecognizeQRcode = 1 << 3, /// TODO
};

@interface CatCameraImp : NSObject

@property (nonatomic) CatCameraOption option;

/// 设置扫码有效区域
@property (nonatomic) CGRect effectiveArea;
/// 成功识别二维码后停止会话(默认YES)
@property (nonatomic) BOOL stopSessionWhenRecognize;

///-------------------------------
/// @name Life cycle
///-------------------------------

+ (instancetype)cameraWithContentView:(UIView *)view
                               option:(CatCameraOption)option;

/// Starts an AVCaptureSession instance running.
- (void)startRunning;

/// Stops an AVCaptureSession instance that is currently running.
- (void)stopRunning;

///-------------------------------
/// @name Actions
///-------------------------------

- (void)takeAPhotoWithCompletion:(void (^)(UIImage *image))completion;

- (void)scanWithCompletion:(void(^)(NSString *result))completion;

- (void)recognizeWithImage:(UIImage *)image completion:(void (^)(NSArray *results))completion;

///-------------------------------
/// @name utils
///-------------------------------

/// 是否允许使用摄像头
/// @param handler 授权完成回调,包含是否允许使用的参数
+ (void)canUserCameraWithCompletionHandler:(void (^)(BOOL granted))handler;

@end

NS_ASSUME_NONNULL_END
