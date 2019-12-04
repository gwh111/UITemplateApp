//
//  CatCameraSystemViewController.m
//  UITemplateKit
//
//  Created by ml on 2019/11/1.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatCameraSystemViewController.h"
#import "CatCameraImp.h"

@interface CatCameraSystemViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate> 

@end

@implementation CatCameraSystemViewController

+ (instancetype)controllerWithCompletion:(void (^ __nullable)(UIImage *data))completion {
    CatCameraSystemViewController *vc = [CatCameraSystemViewController new];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    vc->_completion = completion;
    return vc;
}

- (void)presentCameraPageFromRootViewController:(UIViewController *)rootViewController {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    self->_controller = rootViewController;
    
    [CatCameraImp canUserCameraWithCompletionHandler:^(BOOL granted) {
        if (granted) {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [rootViewController presentViewController:picker animated:YES completion:nil];
            }
        }else {
            NSString *appName = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleDisplayName"];
            NSString *errorStr = [NSString stringWithFormat:@"应用相机权限受限,请在iPhone的“设置-隐私-相机”选项中，允许%@访问你的相机。",appName];
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:errorStr preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }];

            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

            }];

            [alert addAction:ok];
            [alert addAction:cancel];

            [rootViewController presentViewController:picker animated:YES completion:nil];
        }
    }];
}

// MARK: - UIImagePickerControrller -

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self->_controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    // 判断获取类型：图片，并且是刚拍摄的照片
    if ([mediaType isEqualToString:@"public.image"]
        && picker.sourceType ==UIImagePickerControllerSourceTypeCamera){
            UIImage *theImage = nil;
            // 判断，图片是否允许修改
        if ([picker allowsEditing]) {
            // 获取用户编辑之后的图像
            theImage = [info objectForKey:UIImagePickerControllerEditedImage];
        } else {
            // 获取原始的照片
            theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        
        !self->_completion ? : self->_completion(theImage);
    }
}

@end
