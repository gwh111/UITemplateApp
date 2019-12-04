//
//  CatZoomScrollView.m
//  kk_buluo
//
//  Created by david on 2019/9/24.
//  Copyright © 2019 yaya. All rights reserved.
//

#import "CatZoomScrollView.h"

static const float maxScale = 3.0;
static const float minScale = 0.5;

@implementation CatZoomScrollView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.minimumZoomScale = minScale;
        self.maximumZoomScale = maxScale;
        
        [self setupImageView];
    }
    return self;
}

-(void)setupImageView {
    //1.imageV
    UIImageView *imageV = [[UIImageView alloc] init];
    self.imageView = imageV;
    [self addSubview:imageV];
    
    imageV.backgroundColor = [UIColor clearColor];
    imageV.contentMode = UIViewContentModeScaleAspectFit;
    imageV.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *oneTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(oneTapImageView:)];
    oneTap.numberOfTapsRequired = 1;
    oneTap.numberOfTouchesRequired = 1;
    [self.imageView addGestureRecognizer:oneTap];
    //2.双击
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTapImageView:)];
    doubleTap.numberOfTapsRequired = 2;
    doubleTap.numberOfTouchesRequired = 1;
    self.currentScale = 1.0;
    [self.imageView addGestureRecognizer:doubleTap];
    [oneTap requireGestureRecognizerToFail:doubleTap];
    
    //3.添加长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    longPress.minimumPressDuration = 1.0;
    [self.imageView addGestureRecognizer:longPress];
}
-(void)oneTapImageView:(UITapGestureRecognizer *)oneTap{
    if (_closeBlock) _closeBlock();
}
-(void)doubleTapImageView:(UITapGestureRecognizer *)gr{
    
    if (self.currentScale == 1.0) {
        self.currentScale = maxScale;
        [self setZoomScale:maxScale animated:YES];
    }else{
        self.currentScale = 1.0;
        [self setZoomScale:1.0 animated:YES];
    }
}

-(void)longPress:(UILongPressGestureRecognizer *)gr{
    //1.创建AlertController
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message: @"保存图片到本地相册" preferredStyle:UIAlertControllerStyleAlert];
    
    //2.创建界面上的按钮
    UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
    }];
    
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [actionCancel setValue:[UIColor darkGrayColor] forKey:@"titleTextColor"];
    
    [alert addAction:actionCancel];
    [alert addAction:actionYes];
    
    //3.设置message字体样式
    NSMutableAttributedString *alertTitleStr = [[NSMutableAttributedString alloc] initWithString:alert.message];
    [alertTitleStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, alert.message.length)];
    [alert setValue:alertTitleStr forKey:@"attributedMessage"];
    
    //3.显示AlertController
    UIViewController *vc = [self currentVC];
    [vc presentViewController:alert animated:YES completion:nil];
}

/** 获取ViewController */
- (UIViewController*)currentVC {
    for (UIView* nextV = self.superview; nextV; nextV = nextV.superview) {
        
        UIResponder* nextResponder = [nextV nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
//    if (!error) {
//        [CC_NoticeView showError:@"保存成功"];
//    }else{
//        [CC_NoticeView showError:@"保存失败"];
//    }
}

#pragma mark delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

-(void)scrollViewDidZoom:(UIScrollView *)aScrollView {
    CGFloat offsetX = (aScrollView.bounds.size.width > aScrollView.contentSize.width) ? (aScrollView.bounds.size.width - aScrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (aScrollView.bounds.size.height > aScrollView.contentSize.height) ? (aScrollView.bounds.size.height - aScrollView.contentSize.height) * 0.5 : 0.0;
    self.imageView.center = CGPointMake(aScrollView.contentSize.width * 0.5 + offsetX,
                                        aScrollView.contentSize.height * 0.5 + offsetY);
}


@end
