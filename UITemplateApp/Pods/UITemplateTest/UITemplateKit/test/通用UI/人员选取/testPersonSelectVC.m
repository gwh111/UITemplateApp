//
//  testPersonSelectVC.m
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/9.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "testPersonSelectVC.h"
#import "CatPersonSelectVC.h"
#import "testPersonModel.h"
#import "CC_WebImageManager.h"
#import "NSString+Pinyin.h"
#import "CustomPersonSelectCell.h"
#import "UIView+CCWebImage.h"
#import "ccs.h"

@interface testPersonSelectVC () <CatPersonSelectViewDelegate>

@property (nonatomic,weak) CatPersonSelectView *pickerView;
@end

@implementation testPersonSelectVC

- (void)cc_viewDidLoad {
    NSArray *nameList = @[@"基础(单选)",@"基础(多选)",@"自定义cell",@"包含辅助视图(titles)",@"纯view方式"];
    CC_TableView *tableView = ccs.TableView
    .cc_frame(0, 0, WIDTH(), self.cc_displayView.height)
    .cc_addToView(self.cc_displayView);
    [tableView cc_addTextList:nameList withTappedBlock:^(NSUInteger index) {
        
        [self actionWithIndex:index];
    }];
}

- (void)actionWithIndex:(NSUInteger)index {
    if (index == 0) {
        [self showDefault:CatPersonSelectViewTypeSingle];
    }
    if (index == 1) {
        [self showDefault:CatPersonSelectViewTypeMultiple];
    }
    if (index == 2) {
        [self showCustomCell];
    }
    if (index == 3) {
        [self showAccessView];
    }
    if (index == 4) {
        [self showPureView];
    }
}

- (void)showDefault:(CatPersonSelectViewType)single {
    CatPersonSelectView *pickerView = [[CatPersonSelectView alloc] initWithType:single delegate:self];
    pickerView.maxCount = 5;
    pickerView.completionHandler = ^(NSArray<id<CatPersonSelectDatesource>> * _Nonnull persons) {
        NSLog(@"%@",persons);
    };
    NSMutableArray *fakeDatas = [NSMutableArray array];
    NSArray *names = @[@"钢铁侠",@"蜘蛛侠",@"灭霸",@"夜王",@"惊奇队长",@"美队",@"雷神",@"緑巨人",@"蚁人",@"黑豹",@"蝙蝠侠",@"超人",@"闪电侠",@"金刚狼",@"二丫",@"三傻",@"囧诺"];
    for (int i = 0; i < names.count; ++i) {
        testPersonModel *m = [testPersonModel new];
        
        [m setValuesForKeysWithDictionary:@{
                                            @"pid":@(i).stringValue,
                                            @"name":names[i],
                                            @"icon":@"http://mapi.mingliao.net/userLogoUrl.htm?userId=2201904260001238&timestamp=1556259765000",
                                            @"initial":[names[i] firstPinyinLetterForHans],
                                            }];
        [fakeDatas addObject:m];
    }
    [pickerView setItems:fakeDatas];
    
    CatPersonSelectVC *vc = [CatPersonSelectVC controllerWithPickerView:pickerView];
    vc.title = @"人员选取";
    
    pickerView.tableView.sectionIndexColor = [UIColor greenColor];
    
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navC animated:YES completion:^{
        [vc.pickerView reloadData];
    }];
}

- (void)showCustomCell {
    CatPersonSelectView *pickerView = [[CatPersonSelectView alloc] initWithType:CatPersonSelectViewTypeMultiple delegate:self];
    pickerView.maxCount = 5;
    pickerView.completionHandler = ^(NSArray<id<CatPersonSelectDatesource>> * _Nonnull persons) {
        NSLog(@"%@",persons);
    };
    NSMutableArray *fakeDatas = [NSMutableArray array];
    NSArray *names = @[@"重庆",@"钢铁侠",@"蜘蛛侠",@"灭霸",@"夜王",@"惊奇队长",@"美队",@"雷神",@"緑巨人",@"蚁人",@"黑豹",@"蝙蝠侠",@"超人",@"闪电侠",@"金刚狼",@"二丫",@"三傻",@"囧诺"];
    for (int i = 0; i < names.count; ++i) {
        testPersonModel *m = [testPersonModel new];
        
        [m setValuesForKeysWithDictionary:@{
                                            @"pid":@(i).stringValue,
                                            @"name":names[i],
                                            @"icon":@"http://mapi.mingliao.net/userLogoUrl.htm?userId=2201904260001238&timestamp=1556259765000",
                                            @"initial":[names[i] firstPinyinLetterForHans],
                                            }];
        [fakeDatas addObject:m];
    }
    [pickerView setItems:fakeDatas];
    [pickerView.tableView registerClass:[CustomPersonSelectCell class] forCellReuseIdentifier:@"CustomPersonSelectCell"];
    CatPersonSelectVC *vc = [CatPersonSelectVC controllerWithPickerView:pickerView];
    vc.title = @"人员选取";
    
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navC animated:YES completion:^{
        // [vc.pickerView reloadData];
        
    }];
}

- (void)showAccessView {
    CatPersonSelectView *pickerView = [[CatPersonSelectView alloc] initWithType:CatPersonSelectViewTypeMultiple delegate:self];
    pickerView.completionHandler = ^(NSArray<id<CatPersonSelectDatesource>> * _Nonnull persons) {
        NSLog(@"%@",persons);
    };    
    /// 全局的lineBreakMode
    /// pickerView.lineBreakMode = NSLineBreakByTruncatingMiddle;
    NSMutableArray *fakeDatas = [NSMutableArray array];
    NSArray *names = @[@"齐桓公",@"晋文公[这个人的名字很长很长名字很长很长名字很长很长名字很长很长]",@"夫差",@"勾践",@"楚庄王",@"韩",@"赵",@"魏",@"楚",@"燕",@"齐",@"嬴政",@"刘邦",@"项羽",@"刘彻",@"刘病已",@"曹操",@"孙权",@"诸葛亮",@"关羽"];
    for (int i = 0; i < names.count; ++i) {
        testPersonModel *m = [testPersonModel new];
        if (i == 0) {
            [m setValuesForKeysWithDictionary:@{
                                                @"pid":@(i).stringValue,
                                                @"name":names[i],
                                                @"showName":@"桓公(有事找仲父)",
                                                @"icon":@"http://mapi.mingliao.net/userLogoUrl.htm?userId=2201904260001238&timestamp=1556259765000",
                                                @"initial":[names[i] firstPinyinLetterForHans],
                                                }];
        }else {
            [m setValuesForKeysWithDictionary:@{
                                                @"pid":@(i).stringValue,
                                                @"name":names[i],
                                                @"icon":@"http://mapi.mingliao.net/userLogoUrl.htm?userId=2201904260001238&timestamp=1556259765000",
                                                @"initial":[names[i] firstPinyinLetterForHans],
                                                }];
        }
        [fakeDatas addObject:m];
    }
    [pickerView setItems:fakeDatas];
    
    pickerView.extraTitles = @[@"从群聊中选择",@"选取自己",@"鸡条",@"RM",@"忘不了餐厅"];
    
    UIView *extraView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(), 100)];
    extraView.backgroundColor = [UIColor greenColor];
    pickerView.extraView = extraView;
    
    pickerView.headMode = CatSortListHeadModeContact;
    
    CatPersonSelectVC *vc = [CatPersonSelectVC controllerWithPickerView:pickerView];
    vc.title = @"人员选取";
    
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navC animated:YES completion:^{
        [vc.pickerView reloadData];
    }];
}

- (void)showPureView {
    UIView *containerView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:containerView];
    UIView *coverView = [[UIView alloc] initWithFrame:containerView.bounds];
    coverView.backgroundColor = [UIColor blackColor];
    coverView.alpha = 0.66;
    [containerView addSubview:coverView];
    CatPersonSelectView *pickerView = [[CatPersonSelectView alloc] initWithType:CatPersonSelectViewTypeMultiple delegate:self];
    pickerView.frame = CGRectMake(20, HEIGHT(), WIDTH() - 40, 330);
    pickerView.completionHandler = ^(NSArray<id<CatPersonSelectDatesource>> * _Nonnull persons) {
        NSLog(@"%@",persons);
    };
    /// 全局的lineBreakMode
    /// pickerView.lineBreakMode = NSLineBreakByTruncatingMiddle;
    NSMutableArray *fakeDatas = [NSMutableArray array];
    NSArray *names = @[@"齐桓公",@"晋文公[这个人的名字很长很长名字很长很长名字很长很长名字很长很长长名字很长很长长名字很长很长长名字很长很长长名字很长很长]",@"夫差",@"勾践",@"楚庄王",@"韩",@"赵",@"魏",@"楚",@"燕",@"齐",@"嬴政",@"刘邦",@"项羽",@"刘彻",@"刘病已",@"曹操",@"孙权",@"诸葛亮",@"关羽"];
    for (int i = 0; i < names.count; ++i) {
        testPersonModel *m = [testPersonModel new];
        if (i == 0) {
            [m setValuesForKeysWithDictionary:@{
                                                @"pid":@(i).stringValue,
                                                @"name":names[i],
                                                @"showName":@"桓公(有事找仲父)",
                                                @"icon":@"http://mapi.mingliao.net/userLogoUrl.htm?userId=2201904260001238&timestamp=1556259765000",
                                                @"initial":[names[i] firstPinyinLetterForHans],
                                                }];
        }else {
            [m setValuesForKeysWithDictionary:@{
                                                @"pid":@(i).stringValue,
                                                @"name":names[i],
                                                @"icon":@"http://mapi.mingliao.net/userLogoUrl.htm?userId=2201904260001238&timestamp=1556259765000",
                                                @"initial":[names[i] firstPinyinLetterForHans],
                                                }];
        }
        [fakeDatas addObject:m];
    }
    [pickerView setItems:fakeDatas];
    
    [containerView addSubview:pickerView];
    _pickerView = pickerView;
    [pickerView reloadData];
    
    [UIView animateWithDuration:0.5 animations:^{
        pickerView.top = 100;
    } completion:^(BOOL finished) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAction:)];
        tap.cancelsTouchesInView = YES;
        [coverView addGestureRecognizer:tap];
    }];
}

- (void)dismissAction:(UITapGestureRecognizer *)sender {
    [UIView animateWithDuration:0.5 animations:^{
        self.pickerView.top = HEIGHT();
    } completion:^(BOOL finished) {
        [self.pickerView.superview removeFromSuperview];
        [self.pickerView removeFromSuperview];
    }];
}

#pragma mark - CatPersonSelectViewDelegate -
- (void)catPersonSelectView:(CatPersonSelectView *)pickerView imageView:(UIImageView *)imageView urlString:(NSString *)urlString indexPath:(NSIndexPath *)indexPath {
    if (urlString) {
        /// 图片不存在时报 [Unknown process name] CGContextAddPath: invalid context 0x0. If you want to see the backtrace, please set CG_CONTEXT_SHOW_BACKTRACE environmental variable.
        NSURL *url = [NSURL URLWithString:urlString];
        [imageView cc_setImageWithURL:url];
    }
}

- (void)catPersonSelectView:(CatPersonSelectView *)pickerView willDisplayCell:(CatPersonSelectCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    int row=(int)indexPath.row;
    int section=(int)indexPath.section;
    CCLOG(@"row=%d section=%d",row,section);
    if (indexPath.section == CatPersonSelectExtraCellTag) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@+%ld",cell.textLabel.text,indexPath.row];
    }else {
        if ([cell isKindOfClass:[CustomPersonSelectCell class]]) {
            
            
        }else {
            testPersonModel *model = [pickerView searchModelWithIndexPath:indexPath];
            NSLog(@"%@",model.name);
        }
    }
    
    // NSLog(@"%@",self.pickerView.zeroSectionExtraHeaderView);
}

- (void)catPersonSelectView:(CatPersonSelectView *)pickerView item:(id <CatPersonSelectDatesource>)item didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == CatPersonSelectExtraCellTag) {
        /// 点击了辅助视图
        UITableViewCell *cell = [pickerView.extraCells pointerAtIndex:indexPath.row];
        [self pushViewController:self.presentedViewController WithTitle:cell.textLabel.text];
    }else {
        NSLog(@"%@",[pickerView selectPersons]);
    }
}

- (void)pushViewController:(UIViewController *)controller WithTitle:(NSString *)title {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.title = title;
    [(UINavigationController *)controller pushViewController:vc animated:YES];
}

- (CatPersonSelectCell *)catPersonSelectView:(CatPersonSelectView *)selectView customCellforRowAtIndexPath:(NSIndexPath *)indexPath {
    return [selectView.tableView dequeueReusableCellWithIdentifier:@"CustomPersonSelectCell"];
    
}

//- (CGFloat)catPersonSelectView:(CatPersonSelectView *)selectView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 100;
//}

- (void)catPersonSelectView:(CatPersonSelectView *)selectView
          customSectionView:(CatPersonSelectSectionHeaderView *)sectionHeaderView
     viewForHeaderInSection:(NSInteger)section {
    
    sectionHeaderView.titleLabel.textColor = HEX(0xff0000);
    sectionHeaderView.contentView.backgroundColor = HEX(0xEDEDED);
    
}

@end
