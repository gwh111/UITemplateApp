//
//  CatCameraViewController.h
//  UITemplateKit
//
//  Created by Shepherd on 2019/10/29.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CatCameraSystemViewController.h"
#import "CatCameraImp.h"

NS_ASSUME_NONNULL_BEGIN

/// TODO 自定义拍照界面
@interface CatCameraViewController : CatCameraSystemViewController {
@private
    CatCameraImp *_imp;
}

@end

NS_ASSUME_NONNULL_END
