//
//  CatCitySelectView.m
//  UITemplateKit
//
//  Created by 路飞 on 2019/5/28.
//  Copyright © 2019 路飞. All rights reserved.
//

#import "CatCitySelectView.h"

@interface CatCitySelectView ()<UIPickerViewDelegate,UIPickerViewDataSource, UIGestureRecognizerDelegate>
//数据
@property (nonatomic, strong) NSArray *allArr;//取出所有数据(json类型，在pilst里面)

@property (nonatomic, strong) NSMutableArray *provinceArr;//省份名的数组
@property (nonatomic, strong) NSDictionary *provinceDict;//选中省份的字典
@property (nonatomic, strong) NSArray *cityArr;//城市的数组
@property (nonatomic, strong) NSArray *districtArr;//区的数组

//UI
@property (nonatomic, weak) UIPickerView *pickerView;
@end

@implementation CatCitySelectView

- (instancetype)init{
    if (self = [super init]) {
        [self loadDataFormPlist];
        [self setupSubvies];
    }
    return self;
}

#pragma mark - data
-(void)loadDataFormPlist {
    NSBundle *mainBundle = [NSBundle bundleForClass:[self class]];
    if ([mainBundle pathForResource:@"CatCitySelect" ofType:@"bundle"]) {
        NSString *myBundlePath = [mainBundle pathForResource:@"CatCitySelect" ofType:@"bundle"];
        NSBundle* myBundle = [NSBundle bundleWithPath:myBundlePath];
        self.allArr = [NSArray arrayWithContentsOfFile:[myBundle pathForResource:@"Address" ofType:@"plist"]];
    }else{
        NSString *appBundlePath = [mainBundle pathForResource:@"UITemplateKit" ofType:@"bundle"];
        NSBundle* appBundle = [NSBundle bundleWithPath:appBundlePath];
        NSString *myBundlePath = [appBundle pathForResource:@"CatCitySelect" ofType:@"bundle"];
        NSBundle* myBundle = [NSBundle bundleWithPath:myBundlePath];
        self.allArr = [NSArray arrayWithContentsOfFile:[myBundle pathForResource:@"Address" ofType:@"plist"]];
    }
    self.provinceArr = [NSMutableArray array];
    for (NSDictionary *dict in self.allArr) {
        [self.provinceArr addObject:[[dict allKeys] firstObject]];
    }
}

#pragma mark - UI
-(void)setupSubvies {
    WS(weakSelf);
    //1.self背景
    self.backgroundColor = [UIColor whiteColor];
    self.frame = CGRectMake(0, HEIGHT(), WIDTH(), kCatCitySelectViewHeight);
    
    //3.tool
    UIView *tool = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, kCatCitySelectViewBtnH)];
    tool.backgroundColor = UIColor.grayColor;
    [self addSubview:tool];
    
    //3.1取消
    CC_Button *cancelBtn = [CC_Button buttonWithType:UIButtonTypeRoundedRect];
    cancelBtn.frame = CGRectMake(0, 0, kCatCitySelectViewBtnW, kCatCitySelectViewBtnH);
    [cancelBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn cc_tappedInterval:0.1 withBlock:^(id  _Nonnull view) {
        SS(strongSelf);
        if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(catCitySelectViewCancel:)]) {
            [strongSelf.delegate catCitySelectViewCancel:strongSelf];
        }
    }];
    [tool addSubview:cancelBtn];
    
    //3.2确认
    CC_Button *confirmBtn = [CC_Button buttonWithType:UIButtonTypeRoundedRect];
    confirmBtn.frame = CGRectMake(self.width-kCatCitySelectViewBtnW ,0,kCatCitySelectViewBtnW, kCatCitySelectViewBtnH);
    [confirmBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn cc_tappedInterval:0.1 withBlock:^(id  _Nonnull view) {
        SS(strongSelf);
        NSInteger provinceRow = [strongSelf.pickerView selectedRowInComponent:0];
        NSInteger cityRow = [strongSelf.pickerView selectedRowInComponent:1];
        NSInteger districtRow = [strongSelf.pickerView selectedRowInComponent:2];
        
        if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(catCitySelectViewConfirm:selectProvince:selectCity:selectDistrict:)]) {
            [strongSelf.delegate catCitySelectViewConfirm:strongSelf selectProvince:strongSelf.provinceArr[provinceRow] selectCity:strongSelf.cityArr[cityRow] selectDistrict:strongSelf.districtArr[districtRow]];
        }
    }];
    [tool addSubview:confirmBtn];
    
    //4.pickerV
    UIPickerView *pickerV = [[UIPickerView alloc] initWithFrame:CGRectMake(0,kCatCitySelectViewBtnH, self.width, kCatCitySelectViewHeight-kCatCitySelectViewBtnH)];
    self.pickerView = pickerV;
    pickerV.delegate = self;
    pickerV.dataSource = self;
    pickerV.backgroundColor = UIColor.whiteColor;
    [self addSubview:pickerV];
    
    NSString *provinceStr = self.provinceArr.firstObject;
    self.provinceDict = [self.allArr.firstObject objectForKey:provinceStr];
    if (self.provinceDict) {
        self.cityArr = [self.provinceDict allKeys];
        self.districtArr = [self.provinceDict objectForKey:self.cityArr.firstObject];
    }
}

#pragma mark - UIPickerViewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component==0) {
        return self.provinceArr.count;
    }else if (component == 1){
        return self.cityArr.count;
    }else if (component == 2){
        return self.districtArr.count;
    }
    return 0;
}

#pragma mark - pickerViewDelegate
//自定义每个pickview的label
-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = [UILabel new];
    pickerLabel.numberOfLines = 0;
    pickerLabel.textAlignment = NSTextAlignmentCenter;
    pickerLabel.textColor = [UIColor colorWithRed:51/255.0 green:52/255.0 blue:52/255.0 alpha:1.0];
    pickerLabel.font = [UIFont boldSystemFontOfSize:17];
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        return self.provinceArr[row];
    }else if (component == 1){
        return self.cityArr[row];
    }else if (component == 2){
        return self.districtArr[row];
    }
    return nil;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    //1.省份
    if (component == 0) {
        NSString *provinceStr = self.provinceArr[row];
        self.provinceDict = [self.allArr[row] objectForKey:provinceStr];
        if (self.provinceDict) {
            self.cityArr = [self.provinceDict allKeys];
            self.districtArr = [self.provinceDict objectForKey:self.cityArr.firstObject];
            [pickerView reloadComponent:1];
            [pickerView selectRow:0 inComponent:1 animated:YES];
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:YES];
        }
    }
    if (component == 1) {
        NSString *cityStr = self.cityArr[row];
        self.districtArr = [self.provinceDict objectForKey:cityStr];
        if (self.districtArr) {
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:YES];
        }
    }
    if (component == 2) {
    }
}

@end
