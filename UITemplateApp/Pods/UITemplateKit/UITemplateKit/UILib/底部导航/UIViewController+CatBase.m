//
//  UIViewController+CatBase.m
//  UITemplateKit
//
//  Created by 路飞 on 2019/6/4.
//  Copyright © 2019 路飞. All rights reserved.
//

#import "UIViewController+CatBase.h"
#import <objc/runtime.h>
#import "UIImage+CatRTTint.h"
#import "CatNavBarView.h"

static const char  cat_base_navigationbar_view_key;

@implementation UIViewController (CatBase)

@dynamic cat_navigationBarView;

-(void)setCatNavigationBar
{
    [self setCatNavigationBarWithType:CatNavBarTypeRed];
}
-(void)setCatNavigationBarWhite
{
    [self setCatNavigationBarWithType:CatNavBarTypeWhite];
}
-(void)setCatNavigationBarClear{
    [self setCatNavigationBarWithType:CatNavBarTypeClear];
}
-(void)setCatNavigationBarGray
{
    [self setCatNavigationBarWithType:CatNavBarTypeGray];
}
-(void)setCatNavigationBarBigRed
{
    [self setCatNavigationBarWithType:CatNavBarTypeChangeRed];
}

-(void)setCatNavigationBarWithType:(CatNavBarType)barType
{
    self.navigationController.navigationBarHidden = YES;
    CatNavBarView *catNavBarView = [[CatNavBarView alloc]init];
    __weak typeof(self)weakSelf = self;
    
    CCLOG(@"%ld",self.navigationController.viewControllers.count);
    if (self.navigationController.viewControllers.count > 1) {
        catNavBarView.backButton.hidden = NO;
    }else{
        catNavBarView.backButton.hidden = YES;
    }
    
    [catNavBarView.backButton cc_tappedInterval:0.1 withBlock:^(id  _Nonnull view) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        if ([strongSelf canPerformAction:@selector(pressBackButton) withSender:nil]) {
            [strongSelf performSelector:@selector(pressBackButton)];
        }else if(strongSelf.navigationController.viewControllers.count>1){
            [strongSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [strongSelf dismissViewControllerAnimated:YES completion:nil];
        }
    }];
    
    
    switch (barType) {
        case CatNavBarTypeRed:
            catNavBarView.barType = CatNavBarTypeRed;
            break;
        case CatNavBarTypeWhite:
        {
            catNavBarView.barType = CatNavBarTypeWhite;
            [catNavBarView setNavBarBackGroundColor:[UIColor whiteColor]];
            [catNavBarView setNavBarTitleColor:RGBA(51, 51, 51, 1)];
            
            UIImage *backImage;
            NSBundle *mainBundle = [NSBundle bundleForClass:[self class]];
            if ([mainBundle pathForResource:@"CatNav" ofType:@"bundle"]) {
                NSString *myBundlePath = [mainBundle pathForResource:@"CatNav" ofType:@"bundle"];
                NSBundle* myBundle = [NSBundle bundleWithPath:myBundlePath];
                backImage = [UIImage imageWithContentsOfFile:[myBundle pathForResource:@"gray_navBack_arrow_icon@3x" ofType:@"png"]];
            }else{
                NSString *appBundlePath = [mainBundle pathForResource:@"UITemplateKit" ofType:@"bundle"];
                NSBundle* appBundle = [NSBundle bundleWithPath:appBundlePath];
                NSString *myBundlePath = [appBundle pathForResource:@"CatNav" ofType:@"bundle"];
                NSBundle* myBundle = [NSBundle bundleWithPath:myBundlePath];
                backImage = [UIImage imageWithContentsOfFile:[myBundle pathForResource:@"gray_navBack_arrow_icon@3x" ofType:@"png"]];
            }
            [catNavBarView.backButton setImage:[backImage rt_tintedImageWithColor:RGBA(51, 51, 51, 1)] forState:UIControlStateNormal];
        }
            break;
        case CatNavBarTypeClear:
        {
            catNavBarView.barType = CatNavBarTypeClear;
            [catNavBarView setNavBarBackGroundColor:[UIColor clearColor]];
            [catNavBarView setNavBarTitleColor:RGBA(51, 51, 51, 1)];
            
        }
            break;
        case CatNavBarTypeGray:
        {
            catNavBarView.barType = CatNavBarTypeGray;
            [catNavBarView setNavBarBackGroundColor:RGBA(242,242,242,1)];
            [catNavBarView setNavBarTitleColor:RGBA(51, 51, 51, 1)];
            
        }
            break;
        case CatNavBarTypeChangeRed:
            catNavBarView.barType = CatNavBarTypeChangeRed;
            [catNavBarView setNavBarBackGroundColor:RGBA(205, 53, 43,1)];
            break ;
        default:
            break;
    }
    self.cat_navigationBarView = catNavBarView;
    [self.view addSubview:catNavBarView];
}

-(CatNavBarView *)cat_navigationBarView {
    return objc_getAssociatedObject(self, &cat_base_navigationbar_view_key);
}

-(void)setCat_navigationBarView:(CatNavBarView *)cat_navigationBarView {
    [self willChangeValueForKey:@"cat_navigationBarView"];
    objc_setAssociatedObject(self, &cat_base_navigationbar_view_key, cat_navigationBarView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"cat_navigationBarView"];
}

-(NSString *)catNavBarTitle {
    return self.cat_navigationBarView.titleLabel.text;
}
-(void)setCatNavBarTitle:(NSString *)title {
    self.cat_navigationBarView.titleLabel.text = title;
}
-(void)setCatNavBarBackgroundImage:(UIImage *)image {
    self.cat_navigationBarView.navBarBackgroundImage = image;
}
-(void)setCatNavBarBackgroundColor:(UIColor *)color {
    [self.cat_navigationBarView setNavBarBackGroundColor:color];;
}
-(void)setCatNavBarTitleColor:(UIColor *)color {
    [self.cat_navigationBarView setNavBarTitleColor:color];;
}
-(void)setCatNavBarTitleFont:(UIFont *)font {
    [self.cat_navigationBarView setNavBarTitleFont:font] ;
}
-(CGFloat)catNavBarHeight {
    return self.cat_navigationBarView.frame.size.height;
}

-(UIView *)setCatDisplayView{
    CGRect rect=self.view.frame;
    rect.origin.y=self.catNavBarHeight;
    rect.size.height=rect.size.height-self.catNavBarHeight;
    UIView *v=[[UIView alloc]initWithFrame:rect];
    [self.view addSubview:v];
    return v;
}

-(CatNavBarType)getCatNavBarType {
    return self.cat_navigationBarView.barType;
}

-(void)hiddenBackButton {
    if (self.cat_navigationBarView) {
        self.cat_navigationBarView.backButton.hidden = YES;
    }
}
@end
