//
//  testChatListTVCellVC.m
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/9.
//  Copyright © 2019 gwh. All rights reserved.
//

#define NAV_BAR_HEIGHT (44.f)
#define STATUS_AND_NAV_BAR_HEIGHT (STATUS_BAR_HEIGHT + NAV_BAR_HEIGHT)
#define STATUS_BAR_HEIGHT (CGRectGetHeight([UIApplication sharedApplication].statusBarFrame))

#import "testChatListTVCellVC.h"
#import "CatChatListTVCell.h"
#import "ccs.h"

@interface testChatListTVCellVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSArray* array;
@end

@implementation testChatListTVCellVC

- (void)cc_viewDidLoad {
    
    NSAttributedString* muaStr1 = [[NSAttributedString alloc]initWithString:@"4个任务需要处理" attributes:@{NSFontAttributeName:RF(13.0f), NSForegroundColorAttributeName:RGBA(153, 153, 153, 1)}];
    NSMutableAttributedString* muaStr2 = [[NSMutableAttributedString alloc]initWithString:@"[有人@我]" attributes:@{NSFontAttributeName:RF(13.0f), NSForegroundColorAttributeName:RGBA(0, 144, 255, 1)}];
    [muaStr2 appendAttributedString:[[NSAttributedString alloc]initWithString:@"春天，连绵雨水啥时候能停！" attributes:@{NSFontAttributeName:RF(13.0f), NSForegroundColorAttributeName:RGBA(153, 153, 153, 1)}]];
    NSAttributedString* muaStr3 = [[NSAttributedString alloc]initWithString:@"@maggie 连绵雨水啥时候能停！" attributes:@{NSFontAttributeName:RF(13.0f), NSForegroundColorAttributeName:RGBA(153, 153, 153, 1)}];
    NSAttributedString* muaStr4 = [[NSAttributedString alloc]initWithString:@"你今天还没有把那些申诉书" attributes:@{NSFontAttributeName:RF(13.0f), NSForegroundColorAttributeName:RGBA(153, 153, 153, 1)}];
    NSMutableAttributedString* muaStr5 = [[NSMutableAttributedString alloc]initWithString:@"[有人@我]" attributes:@{NSFontAttributeName:RF(13.0f), NSForegroundColorAttributeName:RGBA(0, 144, 255, 1)}];
    [muaStr5 appendAttributedString:[[NSAttributedString alloc]initWithString:@"Maggie:是就是就是" attributes:@{NSFontAttributeName:RF(13.0f), NSForegroundColorAttributeName:RGBA(153, 153, 153, 1)}]];
    NSAttributedString* muaStr6 = [[NSAttributedString alloc]initWithString:@"Maggie给您创建了一条新任务NSForegroundColorAttributeNameNSForegroundColorAttributeName" attributes:@{NSFontAttributeName:RF(13.0f), NSForegroundColorAttributeName:RGBA(153, 153, 153, 1)}];
    
    self.array = @[@{@"image":@"chat_onepiece_1", @"title":[[NSAttributedString alloc]initWithString:@"波多卡斯·D·艾斯" attributes:@{NSFontAttributeName:RF(17.0f), NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}], @"content":muaStr1, @"time":@"15:42", @"unReadNum":@"0"},
                  @{@"image":@"chat_onepiece_2", @"title":[[NSAttributedString alloc]initWithString:@"香克斯·李·洛克斯" attributes:@{NSFontAttributeName:RF(17.0f), NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}], @"content":muaStr2, @"time":@"15:42", @"unReadNum":@"2"},
                   @{@"image":@"chat_onepiece_3", @"title":[[NSAttributedString alloc]initWithString:@"艾尼路" attributes:@{NSFontAttributeName:RF(17.0f), NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}], @"content":muaStr3, @"time":@"15:10", @"unReadNum":@"19"},
                   @{@"image":@"chat_onepiece_4", @"title":[[NSAttributedString alloc]initWithString:@"三治" attributes:@{NSFontAttributeName:RF(17.0f), NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}], @"content":muaStr4, @"time":@"15:42", @"unReadNum":@"0"},
                   @{@"image":@"chat_onepiece_5", @"title":[[NSAttributedString alloc]initWithString:@"唐吉诃德·多弗朗明哥" attributes:@{NSFontAttributeName:RF(17.0f), NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}], @"content":muaStr5, @"time":@"11:23", @"unReadNum":@"100"},
                   @{@"image":@"chat_onepiece_6", @"title":[[NSAttributedString alloc]initWithString:@"萨博" attributes:@{NSFontAttributeName:RF(17.0f), NSForegroundColorAttributeName:RGBA(51, 51, 51, 1)}], @"content":muaStr6, @"time":@"11:20", @"unReadNum":@"0"}];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, WIDTH(), HEIGHT()-STATUS_AND_NAV_BAR_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CatChatListTVCell* cell = [CatChatListTVCell createCatChatListTVCellWithTableView:tableView];
    cell.titleLb.attributedText = _array[indexPath.row][@"title"];
    cell.contentLb.attributedText = _array[indexPath.row][@"content"];
    cell.timeStr = _array[indexPath.row][@"time"];
    cell.unReadNum = _array[indexPath.row][@"unReadNum"];
    cell.iconImgV.image = [UIImage imageNamed:_array[indexPath.row][@"image"]];
//    若是网络图，用CC_WebImage加载
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return RH(72.0f);
}

@end
