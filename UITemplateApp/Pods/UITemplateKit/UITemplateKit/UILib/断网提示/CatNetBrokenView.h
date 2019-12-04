//
//  CatNetBrokenView.h
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/10.
//  Copyright © 2019 gwh. All rights reserved.
//

//断网页宽度
#define kCatNetBrokenViewWidth RH(274.0f)
//断网页高度-根据内容高度会自适应
#define kCatNetBrokenViewHeight RH(380.0f)

#import <UIKit/UIKit.h>
#import "ccs.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ ReloadBlock)(void);

@interface CatNetBrokenView : UIView

@property (nonatomic, copy) ReloadBlock reloadBlock;

/**
 初始化

 @param frame frame
 @param emptyImage 断网的空白图
 @return 实例
 */
- (instancetype)initWithFrame:(CGRect)frame emptyImage:(UIImage *)emptyImage reloadBlock:(ReloadBlock)reloadBlock;

/**
 消失
 */
-(void)dismissCatBrokenView;

@end

NS_ASSUME_NONNULL_END
