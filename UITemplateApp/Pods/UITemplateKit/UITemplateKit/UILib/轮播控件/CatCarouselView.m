//
//  CatCarouselView.m
//  Patient
//
//  Created by 路飞 on 2019/8/16.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatCarouselView.h"
#import "ccs.h"

@interface CatCarouselView ()<UIScrollViewDelegate>
{
    UIView *nextV;
    UIView *currentV;
    UIView *lastV;
    NSTimer *timer;
    NSUInteger currentIndex;
    
    NSString *subViewClass;
    NSString *propertyName;
}
@property (nonatomic, assign) CatCarouselTheme theme;
@property (nonatomic, copy) CatCarouselTapBlock tapBlock;

@end

@implementation CatCarouselView

-(instancetype)initWithFrame:(CGRect)frame subViewClass:(NSString *)subViewClass propertyName:(NSString *)propertyName tapBlock:(CatCarouselTapBlock)tapBlock{
    if (self=[super initWithFrame:frame]) {
        
        self.tapBlock = tapBlock;
        self.scrollEnabled = NO;
        self.bounces = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.contentOffset = CGPointMake(0, self.height);
        self.contentSize = CGSizeMake(self.width, self.height*3);
        self.delegate = self;
        self.interval = 3.0f;
        
        self->subViewClass = subViewClass;
        self->propertyName = propertyName;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame subViewClass:(NSString *)subViewClass propertyName:(NSString *)propertyName theme:(CatCarouselTheme)theme tapBlock:(CatCarouselTapBlock)tapBlock{
    if (self=[super initWithFrame:frame]) {
        
        self.tapBlock = tapBlock;
        self.theme = theme;
        self.scrollEnabled = NO;
        self.bounces = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.pagingEnabled = YES;
        if (theme == CatCarouselThemeVertical) {
            self.contentOffset = CGPointMake(0, self.height);
            self.contentSize = CGSizeMake(self.width, self.height*3);
        }else{
            self.contentOffset = CGPointMake(self.width, 0);
            self.contentSize = CGSizeMake(self.width*3, self.height);
        }
        self.delegate = self;
        self.interval = 3.0f;
        
        self->subViewClass = subViewClass;
        self->propertyName = propertyName;
    }
    return self;
}

-(void)dealloc{
    [self timerStop];
}

-(void)setDataArr:(NSArray *)dataArr {
    _dataArr=dataArr;
    if (dataArr.count == 0) {
        return;
    }
    for (UIView* subView in self.subviews) {
        [subView removeFromSuperview];
    }
    nextV=nil;
    currentV=nil;
    lastV=nil;
    
    [self addView];
    
    currentIndex = 0;
    
    [self addProperty:_dataArr.lastObject toObj:lastV];
    [self addProperty:_dataArr[0] toObj:currentV];
    if (dataArr.count>1) {
        [self addProperty:_dataArr[1] toObj:nextV];
        [self timerStart];
    }else{
        [self addProperty:_dataArr[0] toObj:nextV];
    }
}
-(void)addView{
    if (lastV) {
        return;
    }
    Class className = NSClassFromString(subViewClass);
    lastV = [[className alloc] initWithFrame:CGRectMake(0, 0,self.width, self.height)];
    [self addSubview:lastV];
    
    if (_theme == CatCarouselThemeVertical) {
        currentV = [[className alloc] initWithFrame:CGRectMake(0, self.height,self.width, self.height)];
        nextV = [[className alloc] initWithFrame:CGRectMake(0, self.height*2,self.width, self.height)];
    }else{
        currentV = [[className alloc] initWithFrame:CGRectMake(self.width, 0,self.width, self.height)];
        nextV = [[className alloc] initWithFrame:CGRectMake(self.width*2, 0,self.width, self.height)];
    }
    
    
    [self addSubview:currentV];
    WS(weakSelf)
    [currentV cc_tappedInterval:2 withBlock:^(id  _Nonnull view) {
        SS(strongSelf)
        if (strongSelf.tapBlock) {
            strongSelf.tapBlock(strongSelf->currentIndex, strongSelf.dataArr[strongSelf->currentIndex]);
        }
    }];
    
    [self addSubview:nextV];
}

-(void)timerAction{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.theme == CatCarouselThemeVertical) {
            [self setContentOffset:CGPointMake(0, self.height*2) animated:YES];
        }else{
            [self setContentOffset:CGPointMake(self.width*2, 0) animated:YES];
        }
    });
    //动画过后重置位置
    [NSTimer scheduledTimerWithTimeInterval:.4 target:self selector:@selector(scroll) userInfo:nil repeats:NO];
}
- (void)timerStop{
    [timer invalidate];
    timer = nil;
}
- (void)timerStart{
    if (_dataArr.count > 1) {
        if (timer) {
            [timer invalidate];
            timer = nil;
        }
        timer = [NSTimer scheduledTimerWithTimeInterval:_interval target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    }
}

-(void)scroll{
    if (_dataArr.count > 1) {
        currentIndex = (currentIndex + 1)%_dataArr.count;
        
        [self addProperty:_dataArr[(currentIndex-1)%_dataArr.count] toObj:lastV];
        [self addProperty:_dataArr[currentIndex] toObj:currentV];
        [self addProperty:_dataArr[(currentIndex+1)%_dataArr.count] toObj:nextV];
        if (_theme == CatCarouselThemeVertical) {
            [self setContentOffset:CGPointMake(0, self.height)];
        }else{
            [self setContentOffset:CGPointMake(self.width, 0)];
        }
    }
}

- (void)addProperty:(id)data toObj:(id)obj{
    SEL sel=NSSelectorFromString(propertyName);
    if ([obj respondsToSelector:sel]) {
        [obj setValue:data forKey:propertyName];
    }
}
@end
