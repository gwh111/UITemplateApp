//
//  CatNavBarView.m
//  UITemplateKit
//
//  Created by 路飞 on 2019/6/4.
//  Copyright © 2019 路飞. All rights reserved.
//

#import "CatNavBarView.h"

@implementation CatNavBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.frame=CGRectMake(0, 0, WIDTH(), STATUS_AND_NAV_BAR_HEIGHT);
        _navBarImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        //        _navBarImageView.image = [UIImage imageNamed:@"NavBar64"];
        
        [self addSubview:_navBarImageView];
        _navBarImageView.hidden = YES;
        
        UIImage *backImage;
        NSBundle *mainBundle = [NSBundle bundleForClass:[self class]];
        if ([mainBundle pathForResource:@"CatNav" ofType:@"bundle"]) {
            NSString *myBundlePath = [mainBundle pathForResource:@"CatNav" ofType:@"bundle"];
            NSBundle* myBundle = [NSBundle bundleWithPath:myBundlePath];
            backImage = [UIImage imageWithContentsOfFile:[myBundle pathForResource:@"white_navBack_arrow_icon@3x" ofType:@"png"]];
        }else{
            NSString *appBundlePath = [mainBundle pathForResource:@"UITemplateKit" ofType:@"bundle"];
            NSBundle* appBundle = [NSBundle bundleWithPath:appBundlePath];
            NSString *myBundlePath = [appBundle pathForResource:@"CatNav" ofType:@"bundle"];
            NSBundle* myBundle = [NSBundle bundleWithPath:myBundlePath];
            backImage = [UIImage imageWithContentsOfFile:[myBundle pathForResource:@"white_navBack_arrow_icon@3x" ofType:@"png"]];
        }
        self.backgroundColor = RGBA(246, 63, 63,1);
        _backButton=[CC_Button buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:backImage forState:UIControlStateNormal];
        _backButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _backButton.frame=CGRectMake(10, STATUS_BAR_HEIGHT+10, backImage.size.width*24/backImage.size.height, 24);
        [self addSubview:_backButton];
        
        _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH()/2-150, STATUS_BAR_HEIGHT, 300, 44)];
        _titleLabel.textColor=[UIColor whiteColor];
        _titleLabel.backgroundColor=[UIColor clearColor];
        _titleLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:19];//[UIFont systemFontOfSize:19];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    return self;
}

-(void)setNavBarBackgroundImage:(UIImage *)navBarBackgroundImage {
    _navBarImageView.image = navBarBackgroundImage;
    _navBarImageView.hidden = NO;
}
-(void)setNavBarBackGroundColor:(UIColor *)color {
    _navBarImageView.hidden = YES;
    self.backgroundColor = color;
}
-(void)setNavBarTitleColor:(UIColor *)color {
    [_titleLabel setTextColor:color];
}
-(void)setNavBarTitleFont:(UIFont *)font {
    [_titleLabel setFont:font] ;
}
-(void)hiddenBackButton {
    self.backButton.hidden = YES;
}
@end
