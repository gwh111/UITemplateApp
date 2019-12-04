//
//  CatLoginCountButton.m
//  UITemplateKit
//
//  Created by ml on 2019/6/12.
//  Copyright © 2019 路飞. All rights reserved.
//

#import "CatLoginCountButton.h"
#import "ccs.h"
/**
 使用NSProxy除去NSTimer的循环引用
 */
@interface WeakProxy : NSProxy

@property (weak,nonatomic,readonly)id target;

+ (instancetype)proxyWithTarget:(id)target;
- (instancetype)initWithTarget:(id)target;

@end

@implementation WeakProxy

- (instancetype)initWithTarget:(id)target{
    _target = target;
    return self;
}

+ (instancetype)proxyWithTarget:(id)target{
    return [[self alloc] initWithTarget:target];
}

- (void)forwardInvocation:(NSInvocation *)invocation{
    SEL sel = [invocation selector];
    if ([self.target respondsToSelector:sel]) {
        [invocation invokeWithTarget:self.target];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    return [self.target methodSignatureForSelector:aSelector];
}
- (BOOL)respondsToSelector:(SEL)aSelector{
    return [self.target respondsToSelector:aSelector];
}

@end

@interface CatLoginCountButton ()

@property (nonatomic,strong) NSTimer *timer;
/** 按钮触发的事件 */
@property (nonatomic,copy) void (^handler)(CatLoginCountButton *btn);

@property (nonatomic,assign) NSUInteger defaultSeconds;
/// 退到后台保持倒计时的执行
@property (nonatomic,assign) UIBackgroundTaskIdentifier bgTask;

@end

@implementation CatLoginCountButton

- (instancetype)initWithFrame:(CGRect)frame seconds:(NSUInteger)seconds {
    [self setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.immediately = YES;
    self.titleLabel.font = RF(12);
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame seconds:(NSUInteger)seconds trigger:(void (^)(CatLoginCountButton * _Nonnull))trigger {
    if (self = [super initWithFrame:frame]) {
        [self addTarget:self action:@selector(triggerAction:) forControlEvents:UIControlEventTouchUpInside];
        _handler = trigger;
        _seconds = seconds;
        _defaultSeconds = seconds - 1;
        _placeholderText = @"获取验证码";
        _immediately = NO;
        self.titleLabel.font = RF(12);
        [self setTitle:self.placeholderText forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self setTitle:self.triggerText forState:UIControlStateDisabled];
        [self sizeToFit];
    }
    return self;
}

+ (instancetype)buttonWithSeconds:(NSUInteger)seconds handler:(void (^)(CatLoginCountButton *))handler {
    return [self buttonWithSeconds:seconds handler:handler frame:CGRectMake(0, 0, RH(62), RH(27))];
}

+ (instancetype)buttonWithSeconds:(NSUInteger)seconds
                          handler:(void (^)(CatLoginCountButton * _Nonnull))handler
                            frame:(CGRect)frame {
    
    CatLoginCountButton *b = [[self alloc] initWithFrame:frame];
    [b addTarget:b action:@selector(triggerAction:) forControlEvents:UIControlEventTouchUpInside];
    b.handler = handler;
    b.seconds = seconds;
    b.defaultSeconds = seconds - 1;
    b.titleLabel.font = RF(12);
    b.placeholderText = @"获取验证码";
    b.immediately = YES;
    [b setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [b setTitle:b.placeholderText forState:UIControlStateNormal];
    [b setTitle:b.triggerText forState:UIControlStateDisabled];
    // [b sizeToFit];
    return b;
}

- (void)setupNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(enterBackgroundAction:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
}

- (void)triggerAction:(UIButton *)sender {
    sender.enabled = NO;
    _seconds = self.defaultSeconds;
    
    if(self.immediately) {
        if (self.triggerText) {
            [self setTitle:[NSString stringWithFormat:@"%@(%lu)",self.triggerText,(unsigned long)self.seconds] forState:UIControlStateDisabled];
        }else {
            [self setTitle:[NSString stringWithFormat:@"%lu(s)",(unsigned long)self.seconds] forState:UIControlStateDisabled];
        }
        
        if (_timer == nil) {
            _timer = [NSTimer timerWithTimeInterval:1.0 target:[WeakProxy proxyWithTarget:self] selector:@selector(exec) userInfo:nil repeats:YES];
        }
        
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    !self.handler ? : self.handler(self);
}

- (void)enterBackgroundAction:(NSNotification *)sender {
    self.bgTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        /// 在时间到之前会进入这个block，一般是iOS7及以上是3分钟。
        /// 按照规范，在这里要手动结束后台，你不写也是会结束的
        [self endBackTask];
    }];
}

- (void)endBackTask {
    [[UIApplication sharedApplication] endBackgroundTask:self.bgTask];
    self.bgTask = UIBackgroundTaskInvalid;
}

- (void)exec {
    _seconds -= 1;
    if (self.seconds == 0) {
        self.enabled = YES;
        [self setTitle:self.placeholderText forState:UIControlStateNormal];
        [self invalidate];
        
    }else {
        if (self.triggerText) {
            [self setTitle:[NSString stringWithFormat:@"%@(%lu)",self.triggerText,(unsigned long)self.seconds] forState:UIControlStateDisabled];
        }else {
            [self setTitle:[NSString stringWithFormat:@"%lu(s)",(unsigned long)self.seconds] forState:UIControlStateDisabled];
        }
    }
}

- (void)manualTrigger {
    if (_timer == nil) {
        _timer = [NSTimer timerWithTimeInterval:1.0 target:[WeakProxy proxyWithTarget:self] selector:@selector(exec) userInfo:nil repeats:YES];
        if (self.triggerText) {
            [self setTitle:[NSString stringWithFormat:@"%@(%lu)",self.triggerText,(unsigned long)self.seconds] forState:UIControlStateDisabled];
        }else {
            [self setTitle:[NSString stringWithFormat:@"%lu(s)",(unsigned long)self.seconds] forState:UIControlStateDisabled];
        }
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        // !self.handler ? : self.handler(self);
    }
}

- (void)invalidate {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    self.enabled = YES;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (newSuperview == nil) {
        [self invalidate];
    }
}

- (void)setSeconds:(NSUInteger)seconds {
    _seconds = seconds;
    _defaultSeconds = seconds - 1;
}

- (void)dealloc {
    if (_timer) {
        [self invalidate];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
