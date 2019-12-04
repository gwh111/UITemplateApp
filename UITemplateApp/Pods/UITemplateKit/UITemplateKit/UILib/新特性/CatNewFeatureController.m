//
//  CatNewFeatureController.m
//  UITemplateKit
//
//  Created by ml on 2019/7/9.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatNewFeatureController.h"
#import "CatSimpleView.h"
//#import "CC_UIViewExt.h"

@implementation CatPageControl

- (instancetype)init{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)setCurrentPage:(NSInteger)currentPage{
    [super setCurrentPage:currentPage];
    
    [self updateDots];
}


- (void)updateDots{
    for (int i = 0; i < [self.subviews count]; i++) {
        UIImageView *dot = [self imageViewForSubview:[self.subviews objectAtIndex:i] currPage:i];
        if (i == self.currentPage){
            dot.image = self.currentImage;
            dot.size = self.currentImageSize;
        }else{
            dot.image = self.inactiveImage;
            dot.size = self.inactiveImageSize;
        }
        dot.layer.cornerRadius=RH(2.5);
        dot.layer.masksToBounds=YES;
    }
}
- (UIImageView *)imageViewForSubview:(UIView *)view currPage:(int)currPage{
    UIImageView *dot = nil;
    if ([view isKindOfClass:[UIView class]]) {
        for (UIView *subview in view.subviews) {
            if ([subview isKindOfClass:[UIImageView class]]) {
                dot = (UIImageView *)subview;
                break;
            }
        }
        
        if (dot == nil) {
            dot = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, view.frame.size.width, view.frame.size.height)];
            
            [view addSubview:dot];
        }
    }else {
        dot = (UIImageView *)view;
    }
    
    return dot;
}

@end

@interface CatNewFeatureController () <UIScrollViewDelegate,UIGestureRecognizerDelegate> {
@private
    NSArray            *_images;
    UIScrollView       *_scrollView;
    UIButton           *_launchButton;
}

@end

@implementation CatNewFeatureController

- (instancetype)initWithImages:(NSArray *)images {
    if (self = [super init]) {
        self->_images = images;
        
        _launchButton = [UIButton new];
        _launchButton.height = 44;
        [_launchButton setTitle:@"立即进入" forState:UIControlStateNormal];
        _fullScreenTrigger = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    if (_images.count > 0) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        scrollView.backgroundColor = [UIColor whiteColor];
        scrollView.delegate = self;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO;
        scrollView.delegate = self;
        scrollView.contentSize = CGSizeMake(WIDTH() * _images.count, HEIGHT());
        [self.view addSubview:_scrollView = scrollView];
        
        for (int i = 0; i < _images.count ; ++i) {
            CatSimpleView *sview = [[CatSimpleView alloc] initWithFrame:CGRectMake(i * WIDTH(), 0,WIDTH() , HEIGHT())];
#if DEBUG
            sview.LYSelf.n2BackgroundColor([UIColor groupTableViewBackgroundColor]).LYBigTitleLabel.n2Text(@(i).stringValue).n2TextColor([UIColor redColor]).n2Font(RF(22)).n2SizeToFit();
            sview.bigTitleLabel.center = CGPointMake(sview.centerX - i * WIDTH(), sview.centerY);
#endif
            if ([_images[i] isKindOfClass:[UIImage class]]) {
                sview.LYIcon.n2Image(_images[i]).n2Frame(sview.bounds);
            }else {
                sview.LYIcon.n2Text(_images[i]).n2Frame(sview.bounds);
            }
            [scrollView addSubview:sview];
            
            if (i == _images.count - 1) {
                if (self->_launchButton.width == 0) {
                    CGFloat inter = RH(30);
                    self->_launchButton.width = WIDTH() - 2 * inter;
                    self->_launchButton.left = inter;
                    self->_launchButton.top = HEIGHT() - 44 - RH(30);
                    self->_launchButton.backgroundColor = [UIColor redColor];
                    self->_launchButton.layer.cornerRadius = 22;
                    self->_launchButton.layer.masksToBounds = YES;
                }
                
                [self->_launchButton addTarget:self
                                        action:@selector(launchAction:)
                              forControlEvents:UIControlEventTouchUpInside];
                
                [sview addSubview:self->_launchButton];
                
                if (_fullScreenTrigger) {
                    [sview.LYIcon.n2UserInteractionEnabled(YES).icon addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(launchAction:)]];
                }
            }
        }
        
        if (self.pageControl) {
            self.pageControl
                .c2Top(HEIGHT() - 7 - 14)
                .c2W(100)
                .c2H(7)
                .c2CenterX(self.view.centerX);
            [self.view addSubview:self.pageControl];
        }
    }
    
    if (@available(iOS 11.0, *)) {
        self->_scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)launchAction:(UIButton *)sender {
    !_completion ? : _completion();
}

// MARK: - UIScrollView -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.pageControl.currentPage = (NSUInteger)(scrollView.contentOffset.x / WIDTH()) % (self->_images.count);
}

@end
