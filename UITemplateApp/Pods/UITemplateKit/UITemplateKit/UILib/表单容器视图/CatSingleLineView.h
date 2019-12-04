//
//  CatSingleLineView.h
//  UITemplateKit
//
//  Created by Shepherd on 2019/7/7.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatSimpleView.h"
#import "ccs.h"

NS_ASSUME_NONNULL_BEGIN

@interface CatSingleLineView : CatSimpleView

/** 是否可编辑 */
@property (nonatomic,assign,getter=isEditable) BOOL editable;
/** 上一次输入的内容 */
@property (nonatomic,copy) NSString *lastTimeString;
/** 是否可选项 */
@property (nonatomic,assign) BOOL optional CC_DEPRECATED("建议直接操作requireLabel属性");

@property (nonatomic,assign) NSUInteger maxCount;

/**
 包含标题与占位符的一个基础的单选输入的样式

 @param title 标题
 @param placeholder 单行输入框的占位符
 @return 返回一个基础的单选输入视图
 
 @note 其它隐含视图
 图标:
    self.icon 进行设置和布局
 分割线:
    self.separtor
    默认 frame = RH(16),bottom-0.5,self.width-2 * RH(16),0.5
    默认颜色 0xededed
 
 自定义扩展
 CatSimpleView
 */
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
- (UITextField *)inputTextField;

@end

NS_ASSUME_NONNULL_END
