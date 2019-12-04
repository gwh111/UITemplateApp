//
//  CatScanner.m
//  UITemplateKit
//
//  Created by ml on 2019/10/29.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatCameraImp.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreImage/CoreImage.h>
#import "ccs.h"

@interface CatCameraImp () <AVCaptureMetadataOutputObjectsDelegate,
AVCaptureVideoDataOutputSampleBufferDelegate,AVCaptureMetadataOutputObjectsDelegate> {
@private
    __weak UIView *_contentView;
    void (^_completion)(id data);
}

/// 捕获设备，通常是前置摄像头，后置摄像头，麦克风（音频输入）
@property(nonatomic) AVCaptureDevice *device;

/// AVCaptureDeviceInput 输入设备
@property(nonatomic) AVCaptureDeviceInput *input;

/// 当启动摄像头开始捕获输入
@property(nonatomic) AVCaptureMetadataOutput *output;

@property(nonatomic) AVCaptureStillImageOutput *imageOutPut;

@property(nonatomic) AVCaptureSession *session;

/// 图像预览层，显示实时捕获的图像
@property(nonatomic) AVCaptureVideoPreviewLayer *previewLayer;

@end

@implementation CatCameraImp

+ (instancetype)cameraWithContentView:(UIView *)view                             
                               option:(CatCameraOption)option {
    
    CatCameraImp *imp = [[CatCameraImp alloc] init];
    imp.option = option;
    [self canUserCameraWithCompletionHandler:^(BOOL granted) {
        [imp setUpConfigure];
        [imp setUpWithView:view];
    }];
    
    return imp;
}

- (void)setUpConfigure {
    self.stopSessionWhenRecognize = YES;
    
    // 使用AVMediaTypeVideo 指明self.device代表视频，默认使用后置摄像头进行初始化
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 使用设备初始化输入
    self.input = [[AVCaptureDeviceInput alloc] initWithDevice:self.device error:nil];
    
    // 生成输出对象
    self.output = [[AVCaptureMetadataOutput alloc]init];
    self.imageOutPut = [[AVCaptureStillImageOutput alloc] init];
    
    self.session = [[AVCaptureSession alloc]init];
    if ([self.session canSetSessionPreset:AVCaptureSessionPreset1280x720]) {
        self.session.sessionPreset = AVCaptureSessionPreset1280x720;
    }
    
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    
    if ([self.session canAddOutput:self.imageOutPut]) {
        [self.session addOutput:self.imageOutPut];
    }
    
    if ([self.session canAddOutput:self.output]) {
        [self.session addOutput:self.output];
    }
}

- (void)setUpWithView:(UIView *)contentView {
    // 使用self.session，初始化预览层，self.session负责驱动input进行信息的采集，layer负责把图像渲染显示
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    self.previewLayer.frame = CGRectMake(0, 0, WIDTH(), HEIGHT());
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [contentView.layer addSublayer:self.previewLayer];
    
    self->_contentView = contentView;
}

// MARK: -

- (void)startRunning {
    if (!self.session.isRunning) {
       [self.session startRunning];
        if ([_device lockForConfiguration:nil]) {
            if ([_device isFlashModeSupported:AVCaptureFlashModeAuto]) {
                [_device setFlashMode:AVCaptureFlashModeAuto];
            }
            // 自动白平衡
            if ([_device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeAutoWhiteBalance]) {
                [_device setWhiteBalanceMode:AVCaptureWhiteBalanceModeAutoWhiteBalance];
            }
            [_device unlockForConfiguration];
        }
    }
}

- (void)stopRunning {
    if (self.session.isRunning) {
        [self.session stopRunning];
    }
}

- (void)takeAPhotoWithCompletion:(void (^)(UIImage *image))completion {
    if (self.option & CatCameraOptionMoment) {
        AVCaptureConnection *videoConnection = [self.imageOutPut connectionWithMediaType:AVMediaTypeVideo];
        if (!videoConnection) {
            NSLog(@"take photo failed!");
            return;
        }

        [self.imageOutPut captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
            if (imageDataSampleBuffer == NULL) {
                return;
            }
            NSData * imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            UIImage *image = [UIImage imageWithData:imageData];
            !completion ? : completion(image);
            
            [self.session stopRunning];
        }];
    }
}

- (void)scanWithCompletion:(void (^)(NSString * _Nonnull))completion {
    if (self.option & CatCameraOptionScanner) {
        if ([self.output.metadataObjectTypes indexOfObject:AVMetadataObjectTypeQRCode] == NSNotFound) {
            // 二维码识别
            // 用于检测环境光强度
            AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc] init];
            if([self.session canAddOutput:output]) {
                [self.session addOutput:output];
            }
            
            dispatch_queue_t dispatchOutputQueue = dispatch_queue_create("com.ios.uitemplate.camera", NULL);
            [output setSampleBufferDelegate:self queue:dispatchOutputQueue];
            
                     
            dispatch_queue_t dispatchQueue = dispatch_queue_create("com.ios.uitemplate.qrcode", NULL);
            [self.output setMetadataObjectsDelegate:self queue:dispatchQueue];
            [self.output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
            
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(_subjectAreaDidChangeAction:)
                                                         name:AVCaptureDeviceSubjectAreaDidChangeNotification
                                                       object:self.device];
            
            self->_completion = completion;
        }
    }
}

- (void)setEffectiveArea:(CGRect)effectiveArea {
    _effectiveArea = effectiveArea;
    if (self.option & CatCameraOptionScanner) {
        CGRect viewRect = self->_contentView.frame;
        CGRect containerRect = effectiveArea;
        CGFloat x = containerRect.origin.y / viewRect.size.height;
        CGFloat y = containerRect.origin.x / viewRect.size.width;
        CGFloat width = containerRect.size.height / viewRect.size.height;
        CGFloat height = containerRect.size.width / viewRect.size.width;
        self.output.rectOfInterest = CGRectMake(x, y, width, height);
    }
}

- (void)recognizeWithImage:(UIImage *)image completion:(void (^)(NSArray *results))completion {
    if (self.option & CatCameraOptionRecognizeQRcode) {
        CIImage *ciImage = [[CIImage alloc] initWithImage:image];
        CIContext *context = [CIContext contextWithOptions:nil];
        CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:context options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
        NSArray *results = [detector featuresInImage:ciImage];
        !completion ? : completion(results);
    }
}

- (void)_subjectAreaDidChangeAction:(NSNotification *)sender {
    
}

// MARK: - utils -
+ (void)canUserCameraWithCompletionHandler:(void (^)(BOOL granted))handler {
    BOOL enabled = NO;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if (authStatus == AVAuthorizationStatusNotDetermined){
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            !handler ? : handler(granted);
        }];
    }else {
        if (authStatus == AVAuthorizationStatusAuthorized) {
            enabled = YES;
        }
        !handler ? : handler(enabled);
    }
}

// MARK: - AVCaptureMetadataOutputObjectsDelegate -
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects
       fromConnection:(AVCaptureConnection *)connection {
    
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        NSString *result;
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            result = metadataObj.stringValue;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (result) {
                    if (self.stopSessionWhenRecognize) {
                        [self stopRunning];
                    }
                    !self->_completion ? : self->_completion(result);
                }
            });
        }
    }
}

@end
