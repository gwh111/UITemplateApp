//
//  YCDataSource.m
//  UITemplateLib
//
//  Created by yichen on 2019/5/28.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CatListManager.h"

@interface CatListManager()<CatListCellDelegate>

@property (nonatomic, strong)  NSMutableArray *dataArray;;
@property (nonatomic, strong) IBInspectable NSString *cellIdentifier;
@property (nonatomic, copy) CellConfigureBefore cellConfigureBefore;
@property (nonatomic, copy) CellHeightConfigure cellHeightConfigure;
@property (nonatomic, copy) CellClickConfigure cellClickConfigure;
@property (nonatomic, strong) NSMutableDictionary *heightDic;

- (id)modelsAtIndexPath:(NSIndexPath *)indexPath;

@end

@implementation CatListManager

- (id)initWithIdentifier:(NSString *)identifier configureBlock:(CellConfigureBefore)before clickConfigure:(CellClickConfigure _Nullable)click {
    return [self initWithIdentifier:identifier configureBlock:before heightConfigure:nil clickConfigure:click];
}

-(id)initWithIdentifier:(NSString *)identifier configureBlock:(CellConfigureBefore)before heightConfigure:(CellHeightConfigure)height clickConfigure:(CellClickConfigure _Nullable)click{
    if (self = [super init]) {
        _cellIdentifier = identifier;
        _cellConfigureBefore = [before copy];
        _cellHeightConfigure = [height copy];
        _cellClickConfigure = [click copy];
    }
    return self;
}

-(void)addDataArray:(NSArray *)datas {
    if (!datas) {
        return;
    }
    [self.dataArray addObjectsFromArray:datas];
}

-(void)clearDataArray {
    if (self.dataArray) {
        [self.dataArray removeAllObjects];
    }
}

-(id)modelsAtIndexPath:(NSIndexPath *)indexPath {
    return self.dataArray.count > indexPath.row ? self.dataArray[indexPath.row] : nil;
}

#pragma mark - tableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return !self.dataArray ? 0 : self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CatListCell * cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    id model = [self modelsAtIndexPath:indexPath];
    cell.index = indexPath;
    cell.delegate = self;
    if (self.cellConfigureBefore) {
        self.cellConfigureBefore(cell, model, indexPath);
    }
    return cell;
}

#pragma mark - tableviewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id model = [self modelsAtIndexPath:indexPath];
    if (self.cellHeightConfigure) {
        NSInteger height = (NSInteger)[self.heightDic objectForKey:indexPath];
        if (height > 0) {
            return height;
        }else{
            CGFloat height = self.cellHeightConfigure(model,indexPath);
            if (height > 0) {
                [self.heightDic setObject:@(height) forKey:indexPath];
            }
            return height;
        }        
    }
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id model = [self modelsAtIndexPath:indexPath];
    if (self.cellClickConfigure) {
        self.cellClickConfigure(model, indexPath);
    }
}

#pragma mark - cellDelegate
-(void)didClickCellContent:(CatListCell *)cell withType:(CatCellContentClickType)clickType withIndexPath:(NSIndexPath *)index withInfo:(NSInteger)info {
    if ([_delegate respondsToSelector:@selector(didTouchCellContent:withType:withIndexPath:withInfo:)]) {
        [_delegate didTouchCellContent:cell withType:clickType withIndexPath:index withInfo:info];
    }
    id model = [self modelsAtIndexPath:index];
    if ([_delegate respondsToSelector:@selector(didTouchCellContent:withType:withModel:withInfo:)]) {
        [_delegate didTouchCellContent:cell withType:clickType withModel:model withInfo:info];
    }
}

#pragma mark - setter/getter
-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:5];
    }
    return _dataArray;
}

-(NSMutableDictionary *)heightDic {
    if (!_heightDic) {
        _heightDic = [NSMutableDictionary dictionary];
    }
    return _heightDic;
}

@end
