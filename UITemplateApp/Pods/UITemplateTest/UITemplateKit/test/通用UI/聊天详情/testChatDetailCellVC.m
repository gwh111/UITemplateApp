//
//  testChatDetailCellVC.m
//  UITemplateKit
//
//  Created by gwh on 2019/6/17.
//  Copyright © 2019 路飞. All rights reserved.
//

#import "testChatDetailCellVC.h"
#import "ccs.h"
#import "CatChatDetailCell.h"

@interface testChatDetailCellVC ()<UITableViewDelegate,UITableViewDataSource,CatChatDetailCellDelegate> {
    NSMutableArray *listMutArr;
}

@end

@implementation testChatDetailCellVC

- (void)cc_viewWillLoad {
    self.view.backgroundColor = RGBA(241, 241, 241, 1);
}

- (void)cc_viewDidLoad {
    listMutArr=@[

  @{@"type":@(CatChatTypeNotice),@"position":@(CatChatPositionCenter),@"text":@"当前医生已离线，或许未能及时解决您的复诊问题，建议您选择其他在线医生复诊，，您也可以等待该医生上线后，再次向其发起您的复诊需求，"},
  @{@"type":@(CatChatTypeText),@"position":@(CatChatPositionLeft),@"text":@"你好，请问有什么可以帮你",@"figure":@"http://mapi.mingliao.net/userLogoUrl.htm?userId=2201904260001238&timestamp=1556259765000"},
  @{@"type":@(CatChatTypeText),@"position":@(CatChatPositionRight),@"text":@"睡不好"},
  @{@"type":@(CatChatTypeText),@"position":@(CatChatPositionRight),@"text":@"每天晚上都睡不好，容易被惊 醒，有光有声音睡不着"},
  @{@"type":@(CatChatTypeImage),@"position":@(CatChatPositionRight),@"image":@"http://pic37.nipic.com/20140113/8800276_184927469000_2.png"},
  @{@"type":@(CatChatTypeNotice),@"position":@(CatChatPositionCenter),@"text":@"本次复诊已结束，结束时间：2019/05/29 18:02",@"typeCode":@"shortNotice"},
  @{@"type":@(CatChatTypeEmpty),@"position":@(CatChatPositionRight),@"typeCode":@"card",@"firstHospitalName":@"浙江大学医学院附属第二医院",@"diseaseName":@"扁平髋"},
  @{@"type":@(CatChatTypeNotice),@"position":@(CatChatPositionCenter),@"text":@"下次复诊时间：2019/06/21",@"typeCode":@"shortNotice"}].copy;
    
    CC_TableView *tableV = ccs.TableView;
    tableV.frame = CGRectMake(0, RH(100), WIDTH(), SAFE_HEIGHT() - RH(100));
    [self.view addSubview:tableV];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.backgroundColor = UIColor.clearColor;
    
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
}

//tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return listMutArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CatChatDetailCell *cell = [self getCellWithTableView:tableView andIndexPath:indexPath];
    float h = [cell update];
    CCLOG(@"h=%f",h);
    return h;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CatChatDetailCell *cell = [self getCellWithTableView:tableView andIndexPath:indexPath];
    [cell update];
    return cell;
}

- (CatChatDetailCell *)getCellWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger row=indexPath.row;
    CatChatDetailCellType type = [listMutArr[row][@"type"]intValue];
    CatChatDetailCellPosition postion = [listMutArr[row][@"position"]intValue];
    CatChatDetailCell *cell = [CatChatDetailCell dequeueReusableCellWithType:type andPosition:postion andTableView:tableView andDelegate:self specialCode:@""];
    cell.typeCode = listMutArr[row][@"typeCode"];
    cell.chatText = listMutArr[row][@"text"];
    cell.figureUrlStr = listMutArr[row][@"figure"];
    cell.imageUrlStr = listMutArr[row][@"image"];
    cell.row = indexPath.row;
    cell.section = indexPath.section;
    if ([cell.typeCode isEqualToString:@"card"]) {
        cell.defaultHeight = RH(140);
    }
    return cell;
}

- (void)catChatDetailCell:(CatChatDetailCell *)cell finishInitWithViewNames:(NSArray *)names {
}

- (void)catChatDetailCell:(CatChatDetailCell *)cell finishUpdateWithViewNames:(NSArray *)names {
    if ([cell.typeCode isEqualToString:@"shortNotice"]) {
        //对已有的cell类型修改样式
        UITextView *textV = [cell cc_viewWithName:@"noticeTextV"];
        textV.textColor = RGBA(155, 155, 155, 1);
        textV.textAlignment = NSTextAlignmentCenter;
    }else if ([cell.typeCode isEqualToString:@"card"]) {
        //扩展的cell
        [self addAndUpdateCardOnCell:cell];
    }
}

- (void)catChatDetailCell:(CatChatDetailCell *)cell finishLoadImage:(UIImage *)image {
    
}

- (void)catChatDetailCell:(CatChatDetailCell *)cell tappedWithViewName:(NSString *)name{
    CCLOG(@"%@ row=%d section=%d",name,(int)cell.row,(int)cell.section);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
}

#pragma mark extension cell 扩展cell
- (void)addAndUpdateCardOnCell:(CatChatDetailCell *)cell{
    UIView *chatContentV = [cell cc_viewWithName:@"card"];
    if (!chatContentV) {
        chatContentV = ccs.View;
        UIImageView *figureImageV = [cell cc_viewWithName:@"figureImageV"];
        chatContentV.frame=CGRectMake(figureImageV.right+RH(10), RH(10), RH(250), RH(120));
        chatContentV.backgroundColor = UIColor.whiteColor;
        if (cell.cellPosition == CatChatPositionRight) {
            chatContentV.right = figureImageV.left-RH(10);
        }
        [cell addSubview:chatContentV];
        [cell addmask:chatContentV];
        chatContentV.name = @"chatContentV";
        
        UIView *cardLine = ccs.View;
        cardLine.frame = CGRectMake(RH(10), RH(40), chatContentV.width - RH(20), 1);
        cardLine.backgroundColor = HEX(0xEDEDED);
        [chatContentV addSubview:cardLine];
        
        CC_Label *titleL = ccs.Label;
        titleL.frame = CGRectMake(RH(40), 0, RH(100), RH(40));
        titleL.font = RF(17);
        titleL.textColor = HEX(0x333333);
        titleL.text = @"病情描述";
        [chatContentV addSubview:titleL];
        
        NSArray *names = @[@"首诊医院：",@"疾病："];
        for (int i = 0; i < names.count; i++) {
            CC_Label *nameL = ccs.Label;
            nameL.frame = CGRectMake(RH(10), RH(35) * i + RH(40), RH(100), RH(35));
            nameL.font = RF(16);
            nameL.textColor = HEX(0x999999);
            nameL.text = names[i];
            [chatContentV addSubview:nameL];
        }
    }
    CC_Label *hosL = [cell cc_viewWithName:@"hosL"];
    if (!hosL) {
        hosL = ccs.Label;
        hosL.frame = CGRectMake(RH(90), RH(40), chatContentV.width-RH(90), RH(35));
        hosL.font = RF(16);
        hosL.textColor = HEX(0x333333);
        hosL.lineBreakMode = NSLineBreakByTruncatingMiddle;
        [chatContentV addSubview:hosL];
        hosL.name = @"hosL";
    }
    hosL.text = listMutArr[cell.row][@"firstHospitalName"];
    CC_Label *disL = [cell cc_viewWithName:@"disL"];
    if (!disL) {
        disL = ccs.Label;
        disL.frame = CGRectMake(RH(60), RH(75), chatContentV.width-RH(50), RH(35));
        disL.font = RF(16);
        disL.textColor = HEX(0x333333);
        [chatContentV addSubview:disL];
        disL.name = @"disL";
    }
    disL.text = listMutArr[cell.row][@"diseaseName"];
}

@end
