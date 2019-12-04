//
//  CatSimpleLayout.h
//  LYCommonUI
//
//  Created by Liuyi on 2019/6/30.
//  Copyright © 2019 Shepherd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class CatSimpleView;

@protocol CatSimpleViewLayoutDelegate <NSObject>

- (void)layoutSimpleView:(CatSimpleView *)sview;

@end

@interface CatSimpleLayout : NSObject <CatSimpleViewLayoutDelegate>

@property (nonatomic,weak) CatSimpleView *sview;

@end

NS_ASSUME_NONNULL_END
