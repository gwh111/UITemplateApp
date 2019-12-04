//
//  CatQRcodeViewController.h
//  UITemplateKit
//
//  Created by ml on 2019/10/30.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CatQRcodeView.h"
#import "CatCameraImp.h"

NS_ASSUME_NONNULL_BEGIN

@interface CatQRcodeViewController : UIViewController {
@private
    CatCameraImp *_imp;
}

@property (nonatomic,strong,readonly) CatQRcodeView *qrcodeView;

+ (instancetype)controllerWithCompletion:(void (^)(id data))completion;

@end

NS_ASSUME_NONNULL_END
