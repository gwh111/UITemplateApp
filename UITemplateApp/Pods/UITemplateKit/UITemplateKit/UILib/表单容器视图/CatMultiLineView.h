//
//  CatMultiLineView.h
//  UITemplateKit
//
//  Created by Shepherd on 2019/7/7.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatSimpleView.h"
#import "ccs.h"

NS_ASSUME_NONNULL_BEGIN

@interface CatMultiLineView : CatSimpleView

/** 是否可编辑 */
@property (nonatomic,assign,getter=isEditable) BOOL editable;
/** 上一次输入的内容 */
@property (nonatomic,copy) NSString *lastTimeString;
/** 是否可选项 */
@property (nonatomic,assign) BOOL optional CC_DEPRECATED("建议直接操作requireLabel属性");
/** 最大字数限制 */
@property (nonatomic,assign) NSUInteger maxCount;

- (instancetype)createWithTitle:(NSString *)title
                    placeholder:(NSString *)placeholder;

///-------------------------------
/// @name 视图业务命名
///-------------------------------
/// *号 必选项
- (UILabel *)requireLabel;
/// 描述文案
- (UILabel *)itemLabel;
/// 输入框
- (UITextView *)inputTextField;
/// 输入框占位label;
- (UILabel *)inputPlaceholderLabel;

@end

@interface CatMultiLineView (CatForm)

- (instancetype)LYPlaceholderLabel;

@end

NS_ASSUME_NONNULL_END
