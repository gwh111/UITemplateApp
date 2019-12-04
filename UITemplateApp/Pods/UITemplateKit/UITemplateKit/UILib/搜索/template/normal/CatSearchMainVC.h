//
//  CatSearchMainVC.h
//  UITemplateKit
//
//  Created by Shepherd on 2019/7/28.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CatSearchView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CatSearchMainVC : UIViewController

@property (nonatomic,strong,readonly) CatSearchView *searchView;
/** 默认为 self.navigationController.navigationBar */
@property (nonatomic,strong) UIView *parentView;

@property (nonatomic,weak) id<CatSearchViewDelegate> searchDelegate;
@property (nonatomic,weak) id<CatSearchLenovoViewDelegate> searchLenovoDelegate;

@property (nonatomic,assign) BOOL hidesBackButton;

@end

NS_ASSUME_NONNULL_END
