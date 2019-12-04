//
//  testListTypeVC.m
//  UITemplateKit
//
//  Created by yichen on 2019/6/3.
//  Copyright © 2019 路飞. All rights reserved.
//

#import "testListTypeVC.h"
#import "CatListManager.h"
#import "ExampleModel.h"

static NSString *const reuserId = @"reuserId";

@interface testListTypeVC ()<CatListManagerProtocol>

@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) CatListManager    *dataManager;
@property (nonatomic, strong) NSArray           *modelArray;

@end

@implementation testListTypeVC

- (void)cc_viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataManager = [[CatListManager alloc]initWithIdentifier:reuserId configureBlock:^(CatListCell * cell, ExampleModel * model, NSIndexPath * _Nonnull indexPath) {
        cell.bottomStyle = indexPath.row % 3;
        cell.imageStyle = indexPath.row % 3;
        //根据model赋值
        cell.nameLb.text = model.name;
        cell.headIv.isCornerShowed = YES;
        [cell.headIv addImageWithCornerImage:[UIImage imageNamed:@"firefox"]];
        cell.timeLb.text = model.time;
        cell.titleLb.text = model.title;
        cell.contentLb.text = model.content;
        cell.contentLb.numberOfLines = 2;         //默认title1行 content不限制行 如需要改动自行配置行数
        [cell.sharedBtn setTitle:@"999" forState:UIControlStateNormal];
        cell.imgArr = model.imgArr;
    }clickConfigure:^(id model, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"didClickAtIndex = %@",indexPath);
    }];
    [self.dataManager addDataArray:self.modelArray];  //设置modelArr
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self.dataManager;
    self.tableView.delegate = self.dataManager;
}

#pragma mark - delegate

- (void)didTouchCellContent:(CatListCell *)cell withType:(CatCellContentClickType)clickType withModel:(id)model withInfo:(NSInteger)info {
    
}

#pragma mark - setter/getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[CatListCell class] forCellReuseIdentifier:reuserId];
    }
    return _tableView;
}

-(NSArray *)modelArray {
    if (!_modelArray) {
        _modelArray = @[[[ExampleModel alloc]init],[[ExampleModel alloc]init],[[ExampleModel alloc]init],[[ExampleModel alloc]init],[[ExampleModel alloc]init],[[ExampleModel alloc]init],[[ExampleModel alloc]init],[[ExampleModel alloc]init],[[ExampleModel alloc]init]];
    }
    return _modelArray;
}

@end
