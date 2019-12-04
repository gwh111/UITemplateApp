//
//  testCatFormVC.m
//  UITemplateKit
//
//  Created by Shepherd on 2019/7/7.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "testCatFormVC.h"
#import "CatFormView.h"
#import "CatSimpleView.h"
#import "Masonry.h"
//#import "UIButton+CCCat.h"
#import "CatStickerView.h"
#import "PTSingleLineLayout.h"
#import "PTMultiLineLayout.h"
#import "PTTakePhotoView.h"
#import "PTAgreeButton.h"
#import "PTProtocolLayout.h"
#import "PTMedicineInfoModel.h"
#import "CatSideView.h"
#import "CatPopView.h"
#import "CatLibSearchMainVC.h"
#import "CatSearchObject.h"
#import "UIImage+GradientLayer.h"

@interface testCatFormVC () <CatFormViewDatasource,CatFormViewDelegate,CatStickerViewDatesource>

@property (nonatomic,strong) CatStickerView *medicineView;

@property (nonatomic,strong) PTTakePhotoView *takePhotoView;
@property (nonatomic,strong) NSMutableArray *randomDatas;
@property (nonatomic,assign) BOOL agreeProtocol;

@end

@implementation testCatFormVC

- (void)cc_viewDidLoad {
    
    /**
    /// ①
    /// 创建一个表单控件
    CatFormView *formView = [[CatFormView alloc] initWithFrame:[CatFormView formRect]];
    formView.datasource = self;
    formView.delegate = self;
    [formView.submitButton setTitle:@"提交复诊" forState:UIControlStateNormal];
    formView.submitButton.backgroundColor = HEX(0x3EA6FD);
    [formView.submitButton cc_setBackgroundColor:HEX(0xD0D0D0) forState:UIControlStateDisabled];
    formView.submitButton.enabled = NO;
    
    formView.submitButton.layer.masksToBounds = YES;
    formView.submitButton.layer.cornerRadius = 5;
    */
    
    /// ②
    CGRect submitBounds = CGRectMake(0,0,WIDTH() - 2 * RH(16),44);
    // 0x3EA6FD
    UIImage *gradientImage = [UIImage gradientImageWithColors:@[HEX(0xff0000),HEX(0x2C96FC)]
                                                         rect:submitBounds];
    /// 创建一个表单控件
    CatFormView *formView = [CatFormView formViewWithFrame:CatFormView.formRect                                               
                                         submitBtnBgColors:@[gradientImage,HEX(0xC0DEFF)]
                                              cornerRadius:5];
    formView.datasource = self;
    formView.delegate = self;

    formView.submitButton.c2Text(@"提交复诊");
    
    /// 提交按钮是否跟随滚动视图
    /// formView.combineScroll = NO;
    
    [self.view addSubview:formView];
}

// MARK: - FormView -
- (NSInteger)rowsInFormView {
    return 13;
}

- (CatFormSubview *)formView:(CatFormView *)formView atRow:(NSInteger)row {
    NSArray *titles = @[@"复诊科室(数据采集)",@"复诊医生(锁定)",
                        @"所需药品(高度变更)",@"就诊人(侧滑)",
                        @"首诊医院(侧滑)",@"疾病(单行编辑)",
                        @"病情",@"测试自动上浮",@"弹窗",@"搜索历史记录"];
    
    NSArray *placeholders = @[@"请选择复诊科室",@"请选择复诊医生",
                              @"请选择所需药品",@"请选择就诊人",
                              @"请选择首诊医院",@"请选择疾病",
                              @"请输入病情描述，如发病时间、主要病症、治疗经过、目前状况及希望获得的帮助",@"测试自动上浮",@"",@""];
    
    if (row < 6) {
        /// 单行
        CatSingleLineView *item = [formView dequeueReusableViewWithSubType:CatFormSubTypeSingle atRow:row];
        [item createWithTitle:titles[row] placeholder:placeholders[row]];
        item.LYSelf.n2H(RH(50))
            .LYAccessoryIcon.n2Text(@"arrow_right")
        .layout = PTSingleLineLayout.new;
        
        if (row == 1) {
            item.singleLineField.text = @"张医生";
            item.requireLabel.hidden = YES;
        }
        
        if (row == 2) {
            item.identifier = @"canChange";
            
            if (self.randomDatas.count > 0) {
                
                self.medicineView ? [self.medicineView reloadData] : item.LYAdd(({
                    CatStickerView *medicineView = [[CatStickerView alloc] initWithFrame:CGRectMake(0, 30, WIDTH() - RH(26), RH(30))];
                    medicineView.backgroundColor = UIColor.clearColor;
                    medicineView.datasource = self;
                    medicineView.layout.interitemSpacing = 0;
                    medicineView.layout.lineSpacing = RH(4);
                    medicineView.scrollable = NO;
                    self.medicineView = medicineView;
                }));
                
                item.LYSingleLineField.n2Hidden(YES)
                .LYSelf.n2H(CGRectGetMaxY(self.medicineView.frame) + 10);
            }else {
                
                item.LYSingleLineField.n2Hidden(NO)
                .LYSelf.n2H(RH(50));
            }
        }
        return item;
    }else if (row == 6){
        /// 多行
        CatMultiLineView *item = [formView dequeueReusableViewWithSubType:CatFormSubTypeMulti atRow:row];
        [item createWithTitle:titles[row] placeholder:placeholders[row]];
        item.maxCount = 100;
        item.LYPlaceholderLabel.n2Lines(2)
            .LYSelf.n2H(RH(105))
        .layout = PTMultiLineLayout.new;
        return item;
    }else if (row == 7) {
        /// 相册
        return self.takePhotoView ? : ({
            PTTakePhotoView *item = [[PTTakePhotoView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(), RH(114))];
            item.tag = row;
            item.formView = formView;
            self.takePhotoView = item;
        });
    }else if (row == 8) {
        /// 用户协议
        CatFormSubview *item = [formView dequeueReusableViewWithSubType:CatFormSubTypeCustom atRow:row];
        BOOL selected = NO;
        if ([item viewWithTag:99]) {
            PTAgreeButton *agreeBtn = (PTAgreeButton *)[item viewWithTag:99];
            [agreeBtn removeFromSuperview];
            selected = agreeBtn.selected;
        }
        
        item.LYSelf
            .n2Frame(CGRectMake(0, 0, WIDTH(), RH(36)))
        .LYAdd(PTAgreeButton.new)
            .n2Tag(99)
            .n2Text(@"我已阅读并确认")
            .n2Font(RF(12))
            .n2TextColor(HEX(0x999999))
            .n2BtnImage(UIControlStateNormal,[UIImage imageNamed:@"protocol_uncheck"])
            .n2BtnImage(UIControlStateSelected,[UIImage imageNamed:@"protocol_check"])
        .LYOneButton
            .n2Text(@"《知情同意书》")
            .n2Font(RF(12))
            .n2TextColor(HEX(0x39A1FD))
            .n2SizeToFit()
        .LYSepartor
            .n2BackgroundColor(HEX(0xededed))
        .layout = PTProtocolLayout.new;
        
        PTAgreeButton *agreeBtn = (PTAgreeButton *)[item viewWithTag:99];
        agreeBtn.selected = selected;
        [agreeBtn addTarget:self
                     action:@selector(agreeAction:)
           forControlEvents:UIControlEventTouchUpInside];
        
        [item.oneButton addTarget:self
                           action:@selector(protocolAction:)
                 forControlEvents:UIControlEventTouchUpInside];
        
        return item;
    }
    
    if (row == 9 || row == 10) {
        CatSingleLineView *item = [formView dequeueReusableViewWithSubType:CatFormSubTypeSingle atRow:row];
        [item createWithTitle:titles[7] placeholder:placeholders[7]];
        item.LYSelf.n2H(RH(50))
            .LYAccessoryIcon.n2Text(@"arrow_right")
        .layout = PTSingleLineLayout.new;
        item.requireLabel.hidden = YES;
        return item;
    }
    
    if (row == 11) {
        CatSingleLineView *item = [formView dequeueReusableViewWithSubType:CatFormSubTypeSingle atRow:row];
        [item createWithTitle:titles[8] placeholder:placeholders[8]];
        item.LYSelf.n2H(RH(50))
            .LYAccessoryIcon.n2Text(@"arrow_right")
        .layout = PTSingleLineLayout.new;
        item.requireLabel.hidden = YES;
        return item;
    }
    
    if (row == 12) {
        CatSingleLineView *item = [formView dequeueReusableViewWithSubType:CatFormSubTypeSingle atRow:row];
        [item createWithTitle:titles[9] placeholder:placeholders[9]];
        item.LYSelf.n2H(RH(50))
            .LYAccessoryIcon.n2Text(@"arrow_right")
        .layout = PTSingleLineLayout.new;
        item.requireLabel.hidden = YES;
        return item;
    }
    
    return nil;
}

- (BOOL)formView:(CatFormView *)formView shouldEditableAtRow:(NSInteger)row {
    if (row == 5 || row == 6 || row == 9 || row == 10) {
        return YES;
    }
    return NO;
}

- (BOOL)formView:(CatFormView *)formView shouldSelectAtRow:(NSInteger)row {
    if (row == 1) { return NO; }
    return YES;
}

- (void)formView:(CatFormView *)formView didSelectAtRow:(NSInteger)row {
    NSLog(@"点击了第%ld行",(long)row);
    switch (row) {
        case 0: {
            /// 选择了某项
            [formView sendEditingChangedActionWithModel:@{@"name":@"99",@"message":@"呼吸内科"}];
        }
            break;
        case 1:{
            
        }
            break;
        case 2:{
             /// 单行高度变更
            [self randDatasWithForm:formView];
            [formView sendEditingChangedActionWithModel:@{@"name":@"99,19,17"}];
        }
            break;
        case 3:{
            /// 自定义弹窗
            [self newCreateView];
        }
            break;
        case 4:{
            [self oldCreateView];
        }
            break;
        case 9:
        case 10:
            break;
        case 11: {
            CatCombineView *item = [[CatCombineView alloc] initWithFrame:CGRectMake(20,(HEIGHT() - RH(240)) * 0.5, WIDTH() - 40, RH(260))];
            item.LYIcon
                .n2Text(@"home_subsequent_notifcation")
                .n2Frame(CGRectMake(RH(22), RH(36), RH(17), RH(18)))
            .LYTitleLabel.n2Text(@"消息标题")
                .n2TextColor(HEX(0x333333))
                .n2Font(RF(17))
                .n2Left(RH(41))
                .n2Top(RH(34))
                .n2SizeToFit()
            .LYDescLabel.n2Text(@"这是一条消息的内容")
                .n2Font(RF(17))
                .n2Left(RH(41))
                .n2Top(RH(62))
                .n2SizeToFit();
            [item.cc_popView showWithAnimation:CatPopAnimationStyleScale];
        }
            break;
        case 12: {
            CatLibSearchMainVC *searchMainVC = [CatLibSearchMainVC new];
            searchMainVC.searchObject = [CatSearchObject new];
            searchMainVC.searchView.option = CatSearchViewOptionLock;
            [self.navigationController pushViewController:searchMainVC animated:YES];
            [searchMainVC.searchView.td becomeFirstResponder];
        }
            break;
        default:
            break;
    }
}

- (void)formView:(CatFormView *)formView editingChangedView:(CatSimpleView *)sender value:(id)value atRow:(NSInteger)row {
    NSLog(@"编辑了第%ld行,新内容:%@",(long)row,value);
    if (row == 0) {
        /// message显示的内容
        /// name参数值
        [formView formSubviewForIndex:row].singleLineField.text = [value objectForKey:@"message"];
        [formView setFormKey:@"department" forValue:[value objectForKey:@"name"] optional:NO];
        
    }else if (row == 2) {
        [formView setFormKey:@"medicine" forValue:[value objectForKey:@"name"] optional:NO];
    }else if (row == 5) {
        [formView setFormKey:@"disease" forValue:value optional:NO];
    }else if (row == 6){
        [formView setFormKey:@"condition" forValue:value optional:NO];
    }else if (row == 9) {
        [formView setFormKey:@"optionalA" forValue:value optional:YES];
    }else if (row == 10) {
        [formView setFormKey:@"optionalB" forValue:value optional:YES];
    }
}

- (BOOL)formViewShouldSubmit:(CatFormView *)formView required:(NSDictionary *)requiredDictionary info:(NSDictionary *)infoDictionary {
    NSLog(@"当前已填写的必选项:%@",requiredDictionary);
    if (requiredDictionary.count >= 4) {
        if (self.agreeProtocol) {
            return YES;
        }
        return NO;
    }
    return NO;
}

- (void)formView:(CatFormView *)formView submit:(UIButton *)submit required:(NSDictionary *)requiredDictionary info:(NSDictionary *)infoDictionary {
    
    NSMutableDictionary *allDic = [NSMutableDictionary dictionaryWithDictionary:infoDictionary];
    [allDic addEntriesFromDictionary:requiredDictionary];
    /// 发起请求
    NSLog(@"%@",allDic);
}

// MARK: - CatStickerView -
- (NSInteger)stickerView:(CatStickerView *)stickerView numberOfRowsInSection:(NSInteger)section {
    return self.randomDatas.count;
}

- (void)stickerView:(CatStickerView *)stickerView willDisplayView:(CatCombineView *)view atIndexPath:(NSIndexPath *)indexPath {
    PTMedicineInfoModel *model = self.randomDatas[indexPath.row];
    view.LYTitleLabel
        .n2Text(model.tradeName)
        .n2Font(RF(15))
        .n2TextColor(HEX(0x333333))
        .n2BackgroundColor(HEX(0xededed))
        .n2Top(4).n2Left(6).n2SizeToFit()
    .LYCloseButton
        .n2Image([UIImage imageNamed:@"right_close"])
        .n2Left(RH(view.titleLabel.size.width) - RH(6)).n2H(RH(12)).n2W(RH(12)).n2Tag(indexPath.row)
    .LYSelf
        .n2W(view.titleLabel.size.width + RH(12))
        .n2H(view.titleLabel.size.height + 8);
    
    [view.closeButton addTarget:self
                         action:@selector(deleteMedicineAction:)
               forControlEvents:UIControlEventTouchUpInside];
}

- (void)deleteMedicineAction:(UIButton *)sender {
    PTMedicineInfoModel *model = self.randomDatas[sender.tag];
    [self.randomDatas removeModelWithUniqueID:model.medicalID];
    if (self.randomDatas.count == 0) {
        [sender.cc_formView reloadData];
    }
    
    [self.medicineView reloadData];
}

// MARK: - Actions -
- (void)protocolAction:(UIButton *)sender {
    
}

- (void)agreeAction:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    self.agreeProtocol = sender.isSelected;
    /// 手动触发
    [sender.cc_formView allowSubmitTest];
}

- (void)newCreateView {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    CatCombineView *item = [[CatCombineView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(), RH(106))];
    item.LYIcon
        .n2Text(@"home_subsequent_notifcation")
        .n2Frame(CGRectMake(RH(22), RH(36), RH(17), RH(18)))
    .LYTitleLabel.n2Text(@"消息标题")
        .n2TextColor(HEX(0x333333))
        .n2Font(RF(17))
        .n2Left(RH(41))
        .n2Top(RH(34))
        .n2SizeToFit()
    .LYDescLabel.n2Text(@"这是一条消息的内容")
        .n2Font(RF(17))
        .n2Left(RH(41))
        .n2Top(RH(62))
        .n2SizeToFit();
    
    [item.cc_sideView.nextRadius(16) showWithDirection:CatSideViewDirectionTop];
}

- (void)oldCreateView {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    UIView *notifcationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(), RH(106))];
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_subsequent_notifcation"]];
    icon.frame = CGRectMake(RH(19), RH(26), RH(17), RH(18));
    [notifcationView addSubview:icon];
    
    UILabel *notificatioLabel = [UILabel new];
    notificatioLabel.text = @"消息标题";
    notificatioLabel.textColor = HEX(0x333333);
    notificatioLabel.font = RF(17);
    notificatioLabel.left = RH(41);
    notificatioLabel.top = RH(30);
    [notificatioLabel sizeToFit];
    [notifcationView addSubview:notificatioLabel];
    
    UILabel *notificatioDescLabel = [UILabel new];
    notificatioDescLabel.text = @"这是一条消息的内容";
    notificatioDescLabel.textColor = HEX(0x333333);
    notificatioDescLabel.font = RF(17);
    notificatioDescLabel.left = RH(41);
    notificatioDescLabel.top = RH(58);
    [notificatioDescLabel sizeToFit];
    [notifcationView addSubview:notificatioDescLabel];
    
    [notifcationView.cc_sideView.nextRadius(16) showWithDirection:CatSideViewDirectionBottom];
}

// MARK: - Internal -
- (void)randDatasWithForm:(CatFormView *)formView {
    [self.randomDatas removeAllObjects];
    NSArray *testArr = @[@"阿司匹林颗粒",@"脑白金",@"北大富硒康",@"一口闷",@"asdfdasfasfa"];
    NSInteger count = arc4random() % 10;
    for (int i = 0; i < count; ++i) {
        PTMedicineInfoModel *model = [PTMedicineInfoModel new];
        model.medicalID = @(count).stringValue;
        model.tradeName = testArr[arc4random() % 5];
        if (!self.randomDatas) {
            self.randomDatas = [NSMutableArray arrayWithCapacity:count];
        }
        [self.randomDatas addObject:model];
    }
    [formView reloadData];
}


@end
