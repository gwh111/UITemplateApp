//
//  CatPreviewToolView.h
//  UITemplateKit
//
//  Created by ml on 2019/11/4.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CC_Label,CC_Button;

@interface CatPreviewToolView : UIView

@property (nonatomic,strong,readonly) CC_Label  *previewLabel;

/// 是否返回原始图片按钮
@property (nonatomic,strong,readonly) CC_Button *selectOriginImageButton;

- (CatPreviewToolView *)cc_previewWithBlock:(void (^)(CC_Label *))block;

- (CatPreviewToolView *)cc_selectOriginImageWithBlock:(void (^)(CC_Button *))block;

@end

NS_ASSUME_NONNULL_END
