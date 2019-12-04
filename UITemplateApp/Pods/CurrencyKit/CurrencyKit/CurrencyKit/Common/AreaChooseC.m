//
//  AreaController.m
//  CurrencyKit
//
//  Created by gwh on 2019/11/15.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "AreaChooseC.h"

@interface AreaChooseC ()

@property (nonatomic, retain) CC_View *popView;
@property (nonatomic, retain) CC_TableView *tableView;
@property (nonatomic, retain) NSArray *areaList;
@property (nonatomic, retain) CC_View *selectLine;

@property (nonatomic, retain) NSMutableArray *areaListList;
@property (nonatomic, retain) NSMutableArray *selectIndexList;
@property (nonatomic, assign) NSUInteger currentIndex;

@end

@implementation AreaChooseC

- (void)updateAreaData {
    
    Area *a = ccs.areaLib_area;
    [a subAreaQueryWithAreaId:@"" areaType:@"COUNTRY" success:^(HttpModel * _Nonnull result) {
        
        self.areaList = result.resultDic[@"areaSimples"];
        [self.areaListList cc_addObject:self.areaList];
    } fail:^(NSString * _Nonnull errorMsg, HttpModel * _Nonnull result) {
       
        [ccs showNotice:errorMsg];
    }];
    
}

- (void)updateAreaList:(NSUInteger)selectIndex {
    
//    _areaList = @[@"北京", @"上海", @"浙江"];
    
    CC_Button *chooseButton;
    if (_currentIndex == 0) {
        
        chooseButton = ccs.Button
        .cc_name([ccs string:@"select%d", _currentIndex])
        .cc_tag(_currentIndex + 100)
        .cc_frame(RH(10), RH(50), RH(60), RH(35))
        .cc_setTitleColorForState(HEX(#333333), UIControlStateNormal)
        .cc_font(BRF(15))
        .cc_setTitleForState(@"请选择", UIControlStateNormal)
        .cc_addToView(_popView);
        [_tableView reloadData];
    }
    
    if (_currentIndex > 0) {
        
        [_selectIndexList addObject:@(selectIndex)];
        
        CC_Button *oldButton = [_popView cc_viewWithName:[ccs string:@"select%d", _currentIndex - 1]];
        oldButton.cc_setTitleForState(_areaList[selectIndex][@"name"], UIControlStateNormal);
        [oldButton.titleLabel sizeToFit];
        oldButton.width = oldButton.titleLabel.width;
        
        float right = oldButton.right;
        
        CC_View *selectLine = [_popView cc_viewWithName:@"selectLine"];
        selectLine.left = right + RH(30);
        
        chooseButton = ccs.Button
        .cc_name([ccs string:@"select%d", _currentIndex])
        .cc_tag(_currentIndex + 100)
        .cc_frame(right + RH(10), RH(50), RH(60), RH(35))
        .cc_setTitleColorForState(HEX(#333333), UIControlStateNormal)
        .cc_font(BRF(15))
        .cc_setTitleForState(@"请选择", UIControlStateNormal)
        .cc_addToView(_popView);
        
        NSString *areaType = self.areaList[selectIndex][@"areaType"][@"name"];
        NSString *idS = [ccs string:@"%@", self.areaList[selectIndex][@"id"]];
        Area *a = ccs.areaLib_area;
        [a subAreaQueryWithAreaId:idS areaType:areaType success:^(HttpModel * _Nonnull result) {
            
            self.areaList = result.resultDic[@"areaSimples"];
            [self.areaListList addObject:self.areaList];
            [self.tableView reloadData];
        } fail:^(NSString * _Nonnull errorMsg, HttpModel * _Nonnull result) {
           
            [ccs showNotice:errorMsg];
        }];
//        _areaList = @[@"滨州市", @"滨州市2", @"滨州市3"];
    }

    [chooseButton cc_addTappedOnceDelay:.1 withBlock:^(CC_Button *btn) {
        
        CC_View *selectLine = [self.popView cc_viewWithName:@"selectLine"];
        selectLine.left = btn.left + RH(30);
        
        self.currentIndex = btn.tag - 100;
        self.areaList = self.areaListList[self.currentIndex];
        [self.tableView reloadData];
    }];
    
}

- (void)cc_willInit {
    
    _maxCount = 2;
    _areaListList = ccs.mutArray;
    _selectIndexList = ccs.mutArray;
    [self updateAreaData];
}

- (void)dismiss {
    
    [UIView animateWithDuration:.2 animations:^{
        
        self.popView.top = HEIGHT();
        self.displayView.alpha = 0;
    } completion:^(BOOL finished) {

        self.areaList = [self.areaListList firstObject];
        [self.areaListList removeAllObjects];
        [self.areaListList cc_addObject:self.areaList];
        self.currentIndex = 0;
        [self.tableView reloadData];
        [self.displayView removeFromSuperview];
    }];
}

- (void)showAreaChooseOn:(UIView *)view {
    
    _displayView = ccs.View
    .cc_backgroundColor(HEXA(#000000, 0.5))
    .cc_addToView(view);
    _displayView.frame = view.frame;
    
    _popView = ccs.View
    .cc_frame(0, HEIGHT(), WIDTH(), RH(400))
    .cc_backgroundColor(UIColor.whiteColor)
    .cc_cornerRadius(10)
    .cc_addToView(_displayView);
    [UIView animateWithDuration:.3 animations:^{
        
        self.popView.bottom = HEIGHT();
    }];
    
    ccs.Label
    .cc_frame(0, RH(10), WIDTH(), RH(40))
    .cc_text(@"请选择所在地区")
    .cc_textAlignment(NSTextAlignmentCenter)
    .cc_font(BRF(17))
    .cc_textColor(HEX(#333333))
    .cc_addToView(_popView);
    
    CC_Button *closeButton = ccs.Button;
    closeButton
    .cc_frame(_popView.width - RH(45), RH(15), RH(30), RH(30))
    .cc_setTitleColorForState(HEX(#B8B8B8), UIControlStateNormal)
    .cc_font(BRF(15))
    .cc_setTitleForState(@"X", UIControlStateNormal)
    .cc_addToView(_popView);
    [closeButton cc_addTappedOnceDelay:.1 withBlock:^(CC_Button *btn) {
        
        [self dismiss];
    }];
    
    _tableView = ccs.TableView
    .cc_frame(RH(5), RH(90), WIDTH() - RH(10), _popView.height - RH(80))
    .cc_delegate(self)
    .cc_dataSource(self)
    .cc_backgroundColor(UIColor.whiteColor)
    .cc_addToView(_popView);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    ccs.View
    .cc_frame(RH(20), RH(80), _popView.width - RH(40), 1)
    .cc_backgroundColor(HEX(#F5F5F5))
    .cc_addToView(_popView);
    
    _selectLine = ccs.View
    .cc_name(@"selectLine")
    .cc_frame(RH(30), RH(80), RH(20), 2)
    .cc_backgroundColor(HEX(#F8492F))
    .cc_addToView(_popView);

    [self updateAreaList:0];
}

//tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _areaList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return RH(40);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier: CellIdentifier];
    } else {
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    
    cell.textLabel.font = RF(13);
    cell.textLabel.text = _areaList[indexPath.row][@"name"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
    if (_currentIndex + 1 >= _maxCount) {
        
        [_selectIndexList addObject:@(indexPath.row)];
        NSMutableArray *selects = ccs.mutArray;
        for (int i = 0; i < _selectIndexList.count; i++) {
            
            int select = [_selectIndexList[i]intValue];
            [selects addObject:_areaListList[i][select]];
        }
        
        [self.cc_delegate cc_performSelector:@selector(controller:tappedArea:) params:self, selects];
        [self dismiss];
        return;
    }
    
    _currentIndex++;
    
    int count = (int)self.areaListList.count - (int)_currentIndex;
    for (int i = 0; i < count; i++) {
        [self.areaListList removeLastObject];
        [self.selectIndexList removeLastObject];
        CC_Button *oldButton = [_popView cc_viewWithName:[ccs string:@"select%d", _currentIndex + i]];
        [oldButton removeFromSuperview];
    }
    
    [self updateAreaList:indexPath.row];
}

@end
