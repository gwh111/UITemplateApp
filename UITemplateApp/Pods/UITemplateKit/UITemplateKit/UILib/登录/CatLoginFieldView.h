//
//  CatLoginFieldView.h
//  UITemplateKit
//
//  Created by ml on 2019/6/12.
//  Copyright © 2019 路飞. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CatLoginFieldView : UIView {
    UIView *_lineView;
}

@property (nonatomic,strong) UILabel *floatLabel;
@property (nonatomic,strong) UITextField *textField;

@end

NS_ASSUME_NONNULL_END
