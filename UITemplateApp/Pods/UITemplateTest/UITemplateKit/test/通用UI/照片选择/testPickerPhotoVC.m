//
//  testPickerPhotoVC.m
//  UITemplateKit
//
//  Created by Shepherd on 2019/6/15.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "testPickerPhotoVC.h"
#import "CatPickerPhotoController.h"
#import "CatCameraSystemViewController.h"
#import "CatCameraViewController.h"
#import "CatQRcodeViewController.h"

@interface testPickerPhotoVC ()  <CatPickerPhotoControllerDelegate>
@property (nonatomic,strong) NSArray *ids;
@end

@implementation testPickerPhotoVC

- (void)cc_viewDidLoad {
    
    NSArray *nameList = @[@"照片选择(单选)", @"照片选择(多选)", @"拍照 - 系统", @"(建议)自定义(无返回)", @"拍照 - 自定义界面(dev)", @"二维码(dev)"];
    CC_TableView *tableView = ccs.TableView
    .cc_frame(0, 0, WIDTH(), self.cc_displayView.height)
    .cc_addToView(self.cc_displayView);
    [tableView cc_addTextList:nameList withTappedBlock:^(NSUInteger index) {
        
        [self actionWithIndex:index];
    }];
}

- (void)actionWithIndex:(NSUInteger)index {
    if (index == 0) {
        CatPickerPhotoController *vc = [CatPickerPhotoController controllerWithMode:CatPickerPhotoModeSingle delegate:self];
        // CatTakePhoneImages(vc, @"common_check", @"common_uncheck", @"subsequent_take_photo");
        vc.defalutPickerIds = self.ids;
        [vc presentFromRootViewController:self];
        
    } else if (index == 1) {
        CatPickerPhotoController *vc = [CatPickerPhotoController controllerWithMode:CatPickerPhotoModeMultiple delegate:self];
        /// 设置圆角
        vc.cornerRadius = 0;
        // [vc.backButton setImage:[UIImage imageNamed:@"common_uncheck"] forState:UIControlStateNormal];
        
        /// 设置选择原视图按钮
        /// vc.senderView.selectOriginImageButton.cc_setSelectedImage([UIImage imageNamed:@"nav_back"]);
        
        [vc presentFromRootViewController:self];
        
        // CatTakePhoneImages(vc, @"common_check", @"common_uncheck", @"subsequent_take_photo");
        /// [vc.backButton setImage:[UIImage imageNamed:@"common_uncheck"] forState:UIControlStateNormal];
        // vc.defalutPickerIds = self.ids;
        
    } else if (index == 2) {
        [[CatCameraSystemViewController controllerWithCompletion:^(UIImage * _Nonnull data) {
            NSLog(@"%@",data);
        }] presentCameraPageFromRootViewController:self];
        
    } else if (index == 3) {
        [[CatCameraViewController controllerWithCompletion:^(UIImage * _Nonnull data) {
            NSLog(@"%@",data);
        }] presentCameraPageFromRootViewController:self];
    } else if (index == 4) {
        [CatQRcodeViewController controllerWithCompletion:^(id data) {
            
        }];
    }
}

- (void)catPickerPhotoController:(CatPickerPhotoController *)controller didFinishPickingWithItems:(NSArray<UIImage *> *)images assets:(NSArray *)assets isSelectOriginPhoto:(BOOL)isSelectOriginPhoto ids:(NSArray *)ids {
    NSLog(@"%@",images);
    NSLog(@"%@",assets);
    NSLog(@"%d",isSelectOriginPhoto);
    NSLog(@"%@",ids);
}

- (void)catPickerPhotoController:(CatPickerPhotoController *)controller didSelectItemAtIndexPath:(NSIndexPath *)indexPath isMax:(BOOL)isMax {
    if (isMax) {
        
    }
}

@end
