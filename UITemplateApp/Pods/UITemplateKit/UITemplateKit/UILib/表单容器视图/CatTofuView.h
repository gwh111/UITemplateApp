//
//  CatTofuView.h
//  UITemplateKit
//
//  Created by ml on 2019/7/29.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatSimpleView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CatTofuView : CatSimpleView

@property (nonatomic,assign,getter=isEditable) BOOL editable;

- (instancetype)createWithBigTitle:(NSString *)bigTitle
                             title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
