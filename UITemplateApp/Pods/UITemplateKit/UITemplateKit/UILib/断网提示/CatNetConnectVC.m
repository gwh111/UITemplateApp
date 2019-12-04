//
//  CatNetConnectVC.m
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/13.
//  Copyright © 2019 gwh. All rights reserved.
//

#define NAV_BAR_HEIGHT (44.f)
#define STATUS_AND_NAV_BAR_HEIGHT (STATUS_BAR_HEIGHT + NAV_BAR_HEIGHT)
#define STATUS_BAR_HEIGHT (CGRectGetHeight([UIApplication sharedApplication].statusBarFrame))

#import "CatNetConnectVC.h"

@interface CatNetConnectVC ()<UITextViewDelegate>

@end

@implementation CatNetConnectVC

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDatas];
    [self initNav];
    [self initViews];
}

#pragma mark - network

#pragma mark - private
-(void)initDatas{
    
}
-(void)initNav{
        self.navigationItem.title = @"无网络连接";
}
-(void)initViews{
    self.view.backgroundColor = [UIColor whiteColor];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"\n请设置你的网络\n\n" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0f], NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"      •  打开设备的"] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f], NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}]];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"“设置”>“通用”>“蜂窝移动网格”"] attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0f], NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}]];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"，启用"] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f], NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}]];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"“蜂窝移动网格”。"] attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0f], NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}]];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n\n      •  打开设备的"] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f], NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}]];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"“设置”>“Wi-Fi网络”"] attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0f], NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}]];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"启用"] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f], NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}]];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"“Wi-Fi网络”"] attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0f], NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}]];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"后从中选择一个可用的热点链接。"] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f], NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}]];
    [attributedString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"\n\n\n\n如果你已经连接Wi-Fi网络\n\n" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0f], NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}]];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"      •  请确认你所接入的Wi-Fi网络已经介入互联网，或者确认你的设备是否被允许访问该热点。"] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f], NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}]];
    
//    CGFloat backHeight = [attributedString boundingRectWithSize:CGSizeMake(self.width-RH(32.0f), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
    
    UITextView* textView = [[UITextView alloc]initWithFrame:CGRectMake(RH(20.0f), STATUS_AND_NAV_BAR_HEIGHT, WIDTH()-RH(40.0f), HEIGHT()-STATUS_AND_NAV_BAR_HEIGHT)];
    textView.delegate = self;
    textView.editable = NO;//必须禁止输入，否则点击将会弹出输入键盘
    textView.scrollEnabled = NO;//可选的，视具体情况而定
    [self.view addSubview:textView];
    textView.attributedText = attributedString;
}
#pragma mark - public

#pragma mark - notification

#pragma mark - delegate

#pragma mark - property



@end
