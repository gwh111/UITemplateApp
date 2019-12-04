//
//  ViewController.m
//  UITemplateKit
//
//  Created by 路飞 on 2019/5/24.
//  Copyright © 2019 路飞. All rights reserved.
//

#import "CommonUIVC.h"
#import "ccs.h"
#import "LYAOPViewController.h"

@interface CommonUIVC ()

@property (nonatomic, retain) NSArray *testList;
@property (nonatomic, retain) NSMutableArray *testNameList;

@end

@implementation CommonUIVC

- (void)cc_viewWillLoad {
    
    self.cc_title = @"通用UI";
    self.view.backgroundColor = UIColor.whiteColor;
    _testList = [ccs bundlePlistWithPath:@"testList"][@"list"];
    _testNameList = ccs.mutArray;
    for (int i = 0; i < _testList.count; i++) {
        [_testNameList cc_addObject:_testList[i][@"title"]];
    }
}

- (void)cc_viewDidLoad {
    
    CC_TableView *tableView = ccs.TableView
    .cc_frame(0, 0, WIDTH(), self.cc_displayView.height)
    .cc_addToView(self.cc_displayView);
    [tableView cc_addTextList:_testNameList withTappedBlock:^(NSUInteger index) {
        
        NSDictionary *dic = self.testList[index];
        NSString *name = dic[@"className"];
        Class cls = NSClassFromString(name);
        if (!cls) {
            [ccs showNotice:@"找不到class"];
            return;
        }
        
        if (dic[@"items"]) {
            LYAOPViewController *vc = [[NSClassFromString(dic[@"className"]) alloc] init];
            vc.itemTitles = dic[@"items"];
            [self.navigationController pushViewController:vc animated:YES];
            return;
        }
        CC_ViewController *vc = [ccs init:cls];
        vc.cc_title = [self.testList objectAtIndex:index][@"title"];
        [ccs pushViewController:vc];
        
    }];
}

@end
