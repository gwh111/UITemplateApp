//
//  CatPersonSelectView.m
//  UITemplateLib
//
//  Created by ml on 2019/5/28.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatPersonSelectVC.h"
#import "ccs.h"
#import "CC_WebImageManager.h"

#pragma mark - NSMutaleArray (CatPersonSelect) -
@interface NSMutableArray (CatPersonSelect)

- (void)addPerson:(id<CatPersonSelectDatesource>)person;
- (void)addPersonsFromArray:(NSArray <id<CatPersonSelectDatesource>>*)persons;
- (void)removePersonWithId:(NSString *)ID;
- (id<CatPersonSelectDatesource>)findPersonWithId:(NSString *)ID;

@end

@implementation NSMutableArray (CatPersonSelect)

- (void)addPerson:(NSObject<CatPersonSelectDatesource> *)person {
    BOOL isExisted = NO;
    NSString *identifier = person.cat_diffIdentifier;
    for (NSObject<CatPersonSelectDatesource> *p in self) {
        if ([[p valueForKey:identifier] isEqualToString:[person valueForKey:identifier]]) {
            isExisted = YES;
        }
    }
    
    if (isExisted == NO) {
        [self addObject:person];
    }
}

- (void)addPersonsFromArray:(NSArray <id<CatPersonSelectDatesource>>*)persons {
    for (id<CatPersonSelectDatesource> person in persons) {
        [self addPerson:person];
    }
}

- (void)removePersonWithId:(NSString *)ID {
    id<CatPersonSelectDatesource> person = [self findPersonWithId:ID];
    if (person) {
        [self removeObject:person];
    }
}

- (id<CatPersonSelectDatesource>)findPersonWithId:(NSString *)ID {
    for (NSObject<CatPersonSelectDatesource> *person in self) {
        NSString *identifier = person.cat_diffIdentifier;
        if ([[person valueForKey:identifier] isEqualToString:ID]) {
            return person;
        }
    }
    return nil;
}

@end

#pragma mark - CatPersonSelectCell -

#define CatPersonSelectShowCellString @"CatPersonSelectShowCellString"
@interface CatPersonSelectShowCell : UICollectionViewCell

@property (nonatomic,strong) NSObject<CatPersonSelectDatesource> *model;
@property (nonatomic, strong) UIImageView *headView;

@end

@implementation CatPersonSelectShowCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    _headView = ({
        UIImageView *iv = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        iv.layer.cornerRadius = iv.width * 0.5;
        iv.layer.masksToBounds = YES;
        [self.contentView addSubview:iv];
        iv;
    });
}

- (void)setModel:(NSObject <CatPersonSelectDatesource> *)model{
    _model = model;
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

@end

@interface CatPersonSelectCell ()

@end

@implementation CatPersonSelectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:({
        _checkBoxButton = [UIButton new];
        _checkBoxButton.userInteractionEnabled = NO;
        _checkBoxButton.width = RH(22);
        _checkBoxButton.height = RH(22);
        _checkBoxButton.left = RH(20);
        _checkBoxButton;
    })];
    
    [self.contentView addSubview:({
        _iconView = [UIImageView new];
        _iconView.width = RH(33);
        _iconView.height = RH(33);
        _iconView.left = _checkBoxButton.right + RH(15);
        _iconView;
    })];
    
    [self.contentView addSubview:({
        _nameLabel = [UILabel new];
        _nameLabel.left = _iconView.right + RH(15);
        _nameLabel;
    })];
    
    [self.contentView addSubview:({
        _separator = [UIView new];
        _separator.backgroundColor = RGBA(212, 216, 238, 1);
        _separator.left = RH(20);
        _separator.width = WIDTH() - RH(59) - RH(15);
        _separator.height = 1;
        _separator;
    })];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.iconView.layer.masksToBounds = YES;
    self.iconView.layer.cornerRadius = self.iconView.height * 0.5;
}

@end

#pragma mark - CatPersonSelectSectionView -

@interface CatPersonSelectSectionHeaderView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation CatPersonSelectSectionHeaderView

//- (instancetype)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self createComponents];
//    }
//    return self;
//}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self createComponents];
    }
    return  self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self createComponents];
    }
    return self;
}

- (void)createComponents {
    self.contentView.backgroundColor = UIColor.whiteColor;
    [self.contentView addSubview:({
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = UIColor.blackColor;
        _titleLabel.font = RF(15);
        _titleLabel.left = RH(15);
        _titleLabel;
    })];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.titleLabel.text.length > 0) {
        [_titleLabel sizeToFit];
        _titleLabel.centerY = self.contentView.centerY;
    }
}

@end

#pragma mark - CatPersonSelectView -

#define CatPersonSelectSectionHeaderViewCellString @"CatPersonSelectSectionHeaderViewCellString"
#define CatPersonSelectCellString @"CatPersonSelectCellString"

@interface CatPersonSelectView () <UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource> {
@private
    NSArray *_items;
    NSDictionary *_mapper;
    
    UITableView *_tableView;
    CatPersonSelectSectionHeaderView *_sortHeaderView;
    UICollectionView *_collectionView;
    
    NSMutableArray *_localSelectPersons;
    NSMutableArray *_allPersons;
    
    NSArray *_initials;
    NSDictionary *_orderedDic;
@public
    CatPersonSelectViewType _type;
    __weak CatPersonSelectVC *_vc;
}

@property (nonatomic,weak) id<CatPersonSelectViewDelegate> delegate;
+ (UIImage *)imageResourcePathWithName:(NSString *)name;

@end

@implementation CatPersonSelectView
#pragma mark - LifeCyele -
- (instancetype)initWithType:(CatPersonSelectViewType)type delegate:(id<CatPersonSelectViewDelegate>)delegate {
    if (self = [super initWithFrame:CGRectMake(0, 0, WIDTH(), HEIGHT())]) {
        self->_type = type;
        self.maxCount = 100;
        self.delegate = delegate;
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    [self addSubview:({
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumLineSpacing = RH(14);
        CGFloat itemWidth = RH(32);
        layout.itemSize = CGSizeMake(itemWidth, itemWidth);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(), 0) collectionViewLayout:layout];
        _collectionView.backgroundColor = UIColor.whiteColor;
        CGFloat inset = RH(15);
        _collectionView.contentInset = UIEdgeInsetsMake(0, inset, 0, inset);
        _collectionView.dataSource = self;
        // c.delegate = self;
        [self addSubview:_collectionView];
        
        /// Register Cell
        [_collectionView registerClass:[CatPersonSelectShowCell class] forCellWithReuseIdentifier:CatPersonSelectShowCellString];
        _collectionView;
    })];
    
    [self addSubview:({
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH(), HEIGHT() - 64) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = HEX(0xF5F5F7);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.sectionIndexBackgroundColor = UIColor.clearColor;
        
        [_tableView registerClass:[CatPersonSelectCell class] forCellReuseIdentifier:CatPersonSelectCellString];
        [_tableView registerClass:[CatPersonSelectSectionHeaderView class] forHeaderFooterViewReuseIdentifier:CatPersonSelectSectionHeaderViewCellString];
        _tableView;
    })];
    
    _headerView = [UIView new];
    
    _localSelectPersons = [NSMutableArray array];
    
    if (_type == CatPersonSelectViewTypeMultiple) {
        if (self.defaultSelectPersons) {
            for (id<CatPersonSelectDatesource> person in self.defaultSelectPersons) {
                [_localSelectPersons addPerson:person];
            }
            [self showSelectPersonsAction];
            [self showCompleteLabelAction];
        }
    }
    
    _doneButton = ({
        UIButton *b = [UIButton new];
        b.frame = CGRectMake(0, 0, 90, 30);
        b.contentEdgeInsets = UIEdgeInsetsMake(0, 17, 0, -17);
        [b setTitle:@"完成" forState:UIControlStateNormal];
        [b setTitleColor:[ccs appStandard:MASTER_COLOR] forState:UIControlStateNormal];
        [b addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
        b;
    });
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(incrementalAction:)
                                                 name:CatPersonSelectIncrementalPersonsNotification
                                               object:nil];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview) {
        self.backgroundColor = HEX(0xF5F5F7);
        for (UIView *subview in self.headerView.subviews) {
            [subview removeFromSuperview];
        }
        
        UIView *contentView = [UIView new];
        [contentView addGestureRecognizer:({
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTriggerAction:)];
            tap;
        })];
        [self.headerView addSubview:contentView];
        
        CGFloat maxHeight = 0;
        if (self.searchView) {
            [self.headerView addSubview:_searchView];
            maxHeight = _searchView.height;
        }
        
        if (self.headMode == CatSortListHeadModeContact) {
            _sortHeaderView = [CatPersonSelectSectionHeaderView new];
            _sortHeaderView.top = _searchView ? _searchView.bottom : 0;
            _sortHeaderView.left = 0;
            _sortHeaderView.width = newSuperview.width;
            _sortHeaderView.height = 20;
            _sortHeaderView.titleLabel.text = @"我的通讯录";
            _sortHeaderView.titleLabel.textColor = HEX(0x999999);
            _sortHeaderView.titleLabel.font = RF(12);
            _sortHeaderView.titleLabel.left = RH(15);
            [_sortHeaderView.titleLabel sizeToFit];
        }
        
        if ([self.delegate respondsToSelector:@selector(catPersonSelectView:customSortHeaderView:)]) {
            [self.delegate catPersonSelectView:self customSortHeaderView:_sortHeaderView];
        }
        
        if (_sortHeaderView) {
            [self.headerView addSubview:_sortHeaderView];
            maxHeight += _sortHeaderView.height;
        }
        
        if (_extraView) {
            _extraView.top = maxHeight;
            [_headerView addSubview:_extraView];
            maxHeight += _extraView.height;
        }
        
        if(_extraTitles) {
            NSInteger count = _extraTitles.count;
            _extraCells = _extraCells ? : [NSPointerArray weakObjectsPointerArray];;
            
            CGFloat cellHeight = RH(55);
            contentView.frame = CGRectMake(0, maxHeight, newSuperview.width, _extraTitles.count * cellHeight);
            
            for (int i = 0 ; i < count; ++i) {
                UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"_extraTitlesCellString"];
                cell.backgroundColor = [UIColor whiteColor];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = _extraTitles[i];
                cell.frame = CGRectMake(0, i * RH(55), WIDTH(), cellHeight);
                [contentView addSubview:cell];
                if (i != count - 1) {
                    CGFloat left = 15;
                    CGFloat right = 15;
                    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(left, RH(55) - 0.5, WIDTH() - left - right, 0.5)];
                    lineView.backgroundColor = RGBA(212, 216, 238, 1);
                    [cell.contentView addSubview:lineView];
                }
                
                [_extraCells addPointer:(__bridge void * _Nullable)cell];
                cellHeight = cell.height;
            }
            
            for (int i = 0; i < _extraCells.count; ++i) {
                UITableViewCell *cell = [_extraCells pointerAtIndex:i];
                if ([self.delegate respondsToSelector:@selector(catPersonSelectView:willDisplayCell:forRowAtIndexPath:)]) {
                    [self.delegate catPersonSelectView:self
                                       willDisplayCell:cell
                                     forRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:CatPersonSelectExtraCellTag]];
                }
            }
            
            maxHeight += (cellHeight * _extraTitles.count);
        }
        
        _headerView.frame = CGRectMake(0, 0, newSuperview.width, maxHeight);
        _tableView.tableHeaderView = _headerView;
        
        [self reloadData];
    }
}

- (void)dealloc {
#if DEBUG
    NSLog(@"%s",__func__);
#endif
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Public -
- (void)setItems:(NSArray<id<CatPersonSelectDatesource>> *)items {
    /// 断言判断是否准守协议
    
    _items = [items copy];
    if([items.firstObject.class respondsToSelector:@selector(cat_mapper)]) {
        _mapper = [items.firstObject.class cat_mapper];
        
        BOOL sort = NO;
        if (_mapper) {
            if ([_mapper objectForKey:CatPersonSelectCategroyString]) {
                sort = YES;
            }
        }
        
        if (sort) {
            NSMutableArray *persons = [NSMutableArray array];
            [persons addPersonsFromArray:items];
            
            NSMutableArray *initials = [NSMutableArray array];
            NSMutableDictionary *orderedDic = [NSMutableDictionary dictionary];
            NSMutableArray *AtoZ = [NSMutableArray new];
            for (int i = 'A'; i<='Z'; i++) {
                NSString *c = [NSString stringWithFormat:@"%c",i];
                [AtoZ addObject:c];
            }
            
            for (NSObject<CatPersonSelectDatesource> *person in persons) {
                NSString *initial = [person valueForKey:[_mapper objectForKey:CatPersonSelectCategroyString]];
                if ([AtoZ containsObject:initial]) {
                    if(!orderedDic[initial]) {
                        orderedDic[initial] = [NSMutableArray array];
                    }
                    [orderedDic[initial] addPerson:person];
                    
                }else {
                    if (!orderedDic[@"#"]) {
                        orderedDic[@"#"] = [NSMutableArray array];
                    }
                    [orderedDic[@"#"] addPerson:person];
                }
            }
            
            initials = [orderedDic allKeys].mutableCopy;
            [initials sortUsingSelector:@selector(compare:)];
            if ([initials containsObject:@"#"]) {
                [initials removeObject:@"#"];
                [initials addObject:@"#"];
            }
            
            _initials = initials.copy;
            _orderedDic = orderedDic.copy;
        }else {
            _orderedDic = @{@"unsorted":items};
        }
    }
}

- (void)reloadData {
    if (CGRectEqualToRect(_tableView.bounds, self.bounds) == NO) {
        _tableView.frame = self.bounds;
        _collectionView.width = self.width;
    }
    [_tableView reloadData];
}

- (NSArray *)selectPersons {
    return _localSelectPersons;
}

- (void)setDefaultSelectPersons:(NSArray<id<CatPersonSelectDatesource>> *)defaultSelectPersons {
    _defaultSelectPersons = [defaultSelectPersons copy];
    [_localSelectPersons addPersonsFromArray:_defaultSelectPersons];
}

#pragma mark - Internal -
- (NSString *)_parseWithMapper:(NSDictionary *)mapper
                          item:(NSObject <CatPersonSelectDatesource> *)item
                     keyString:(NSString *)keyString {
    
    NSString *rs = nil;
    id key = [mapper objectForKey:keyString];
    if ([key isKindOfClass:[NSArray class]]) {
        NSArray *keys = (NSArray *)key;
        for (NSString *k in keys) {
            id value = [item valueForKey:k];
            if (![ccs function_isEmpty:value]) {
                rs = value;
                break;
            }
        }
    }else if ([key isKindOfClass:[NSString class]]) {
        id value = [item valueForKey:key];
        if(value) {
            rs = value;
        }
    }
    
    return rs;
}

#pragma mark - Actions -
- (void)doneAction:(UIButton *)sender {
    if (self->_vc) {
        [self->_vc dismissViewControllerAnimated:YES completion:nil];
    }
    /// bla bla bla
    [[NSNotificationCenter defaultCenter] postNotificationName:CatPersonSelectDoneNotification object:nil];
    !self.completionHandler ? : self.completionHandler([self selectPersons]);
    
}

- (void)incrementalAction:(NSNotification *)sender {
    if ([sender.name isEqualToString:CatPersonSelectIncrementalPersonsNotification]) {
        if ([sender.object isKindOfClass:[NSArray class]]) {
            [_localSelectPersons addPersonsFromArray:sender.object];
        }
    }
}

- (void)tapTriggerAction:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:sender.view];
    
    NSInteger row = point.y / RH(55);
    NSInteger section = CatPersonSelectExtraCellTag;
    
    if ([self.delegate respondsToSelector:@selector(catPersonSelectView:item:didSelectRowAtIndexPath:)]) {        
        [self.delegate catPersonSelectView:self item:nil didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
    }
}

- (void)showCompleteLabelAction{
    NSString *numbers = @"完成";
    if (_localSelectPersons.count > 0) {
        numbers = [NSString stringWithFormat:@"完成(%li)",_localSelectPersons.count];
    }
    if (_vc.completedButton) {
        [_vc.completedButton setTitle:numbers forState:UIControlStateNormal];
    }
}

- (void)showSelectPersonsAction {
    if (_localSelectPersons.count != 0) {
        [UIView animateWithDuration:0.3 animations:^{
            self->_collectionView.height = RH(55);
            if (self->_vc) {
                self->_collectionView.top = 64;
                self->_tableView.top = 64 + 16 + RH(55);
                self->_tableView.height = self.height - 64 - 16 - RH(55);
            }else {
                self->_collectionView.top = 0;
                self->_tableView.height = self.height - RH(55);
                self->_tableView.top = RH(55);
            }
        }];
    }else {
        [UIView animateWithDuration:0.66 animations:^{
            self->_collectionView.top = 0;
            self->_collectionView.height = 0;
            if (self->_vc) {
                self->_tableView.top = 64;
                self->_tableView.height = self.height - 64;
            }else {
                self->_tableView.top = 0;
                self->_tableView.height = self.height;
            }
        }];
    }
    
    [_collectionView reloadData];
    
    if ([_localSelectPersons count] != 0) {
        NSIndexPath *collectionViewIndexPath = [NSIndexPath indexPathForItem:[_localSelectPersons count] - 1 inSection:0];
        [_collectionView scrollToItemAtIndexPath:collectionViewIndexPath atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    }
}

#pragma mark - UITableView -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([_orderedDic objectForKey:@"unsorted"]) {
        return 1;
    }
    return [_orderedDic count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([_orderedDic objectForKey:@"unsorted"]) {
        return [[_orderedDic objectForKey:@"unsorted"] count];
    }
    NSString *initial = [_initials objectAtIndex:section];
    return [[_orderedDic objectForKey:initial] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CatPersonSelectCell *cell = nil;
    if ([self.delegate respondsToSelector:@selector(catPersonSelectView:customCellforRowAtIndexPath:)]) {
        cell = [self.delegate catPersonSelectView:self customCellforRowAtIndexPath:indexPath];
    }else {
        cell = [tableView dequeueReusableCellWithIdentifier:CatPersonSelectCellString];
    }
    
    /// Trick
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:CatPersonSelectCellString];
    }
    
    NSString *initial = [_initials objectAtIndex:indexPath.section];
    NSObject <CatPersonSelectDatesource> *model = [_orderedDic objectForKey:initial][indexPath.row];
    
    cell.nameLabel.text = [self _parseWithMapper:_mapper item:model keyString:CatPersonSelectTitleString];
    [cell.nameLabel sizeToFit];
    /// 换行模式
    cell.nameLabel.lineBreakMode = self.lineBreakMode;
    
    if (self.checkBoxImages) {
        [cell.checkBoxButton setImage:self.checkBoxImages.firstObject forState:UIControlStateNormal];
        [cell.checkBoxButton setImage:self.checkBoxImages.lastObject forState:UIControlStateSelected];
    }else {
        [cell.checkBoxButton setImage:[CatPersonSelectView imageResourcePathWithName:@"check_off"] forState:UIControlStateNormal];
        [cell.checkBoxButton setImage:[CatPersonSelectView imageResourcePathWithName:@"check"] forState:UIControlStateSelected];
    }
    
    if ([self.delegate respondsToSelector:@selector(catPersonSelectView:imageView:urlString:indexPath:)]) {
        [self.delegate catPersonSelectView:self
                                 imageView:cell.iconView
                                 urlString:[self _parseWithMapper:_mapper item:model keyString:CatPersonSelectImageString]
                                 indexPath:indexPath];
    }else {
        
    }
    
    if (indexPath.section == (_initials.count - 1) && indexPath.row == [_orderedDic[_initials[indexPath.section]] count] - 1) {
        cell.separator.hidden = YES;
    }else {
        cell.separator.hidden = NO;
    }

    if ([_localSelectPersons findPersonWithId:[model valueForKey:[model cat_diffIdentifier]]]) {
        cell.checkBoxButton.selected = YES;
    }else {
        cell.checkBoxButton.selected = NO;
    }
    
    if (_type == CatPersonSelectViewTypeSingle) {
        cell.checkBoxButton.hidden = YES;
    }else {
        cell.checkBoxButton.hidden = NO;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    CatPersonSelectCell *c = (CatPersonSelectCell *)cell;
    c.checkBoxButton.centerY = c.contentView.centerY;
    c.iconView.centerY = c.contentView.centerY;
    c.nameLabel.centerY = c.contentView.centerY;
    
    if ([self.delegate respondsToSelector:@selector(catPersonSelectView:willDisplayCell:forRowAtIndexPath:)]) {
        [self.delegate catPersonSelectView:self willDisplayCell:c forRowAtIndexPath:indexPath];
    }
    c.separator.top = c.contentView.height - 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL canSelect = YES;
    if ([self.delegate respondsToSelector:@selector(catPersonSelectView:shouldSelectRowAtIndexPath:)]) {
        canSelect = [self.delegate catPersonSelectView:self shouldSelectRowAtIndexPath:indexPath];
    }
    
    if (canSelect) {
        CatPersonSelectCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
        NSString *initial = [_initials objectAtIndex:indexPath.section];
        NSObject <CatPersonSelectDatesource> *model = [_orderedDic objectForKey:initial][indexPath.row];
        if(cell.checkBoxButton.selected == NO) {
            if (_type == CatPersonSelectViewTypeMultiple) {
                if (_localSelectPersons.count >= self.maxCount) {
                    if ([self.delegate respondsToSelector:@selector(catPersonSelectView:item:didSelectRowAtIndexPath:)]) {
                        [self.delegate catPersonSelectView:self item:model didSelectRowAtIndexPath:indexPath];
                    }
                    return;
                }
            }
        }
        
        cell.checkBoxButton.selected = !cell.checkBoxButton.isSelected;
        if (cell.checkBoxButton.isSelected) {
            [_localSelectPersons addPerson:model];
        }else {
            [_localSelectPersons removePersonWithId:[model valueForKey:[model cat_diffIdentifier]]];
        }
        
        if ([self.delegate respondsToSelector:@selector(catPersonSelectView:item:didSelectRowAtIndexPath:)]) {
            [self.delegate catPersonSelectView:self item:model didSelectRowAtIndexPath:indexPath];
        }
        if (_type == CatPersonSelectViewTypeMultiple) {
            [self showSelectPersonsAction];
            [self showCompleteLabelAction];
        }else {
            [self doneAction:nil];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return RH(55);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(catPersonSelectView:heightForRowAtIndexPath:)]) {
        return [self.delegate catPersonSelectView:self heightForRowAtIndexPath:indexPath];
    }
    
    return RH(55);
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if (_initials) {
        return _initials;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CatPersonSelectSectionHeaderView *sectionHeaderView = [_tableView dequeueReusableHeaderFooterViewWithIdentifier:CatPersonSelectSectionHeaderViewCellString];
    
    sectionHeaderView.titleLabel.text = _initials[section];
    [sectionHeaderView.titleLabel sizeToFit];
    
    if([self.delegate respondsToSelector:@selector(catPersonSelectView:customSectionView:viewForHeaderInSection:)]) {
        [self.delegate catPersonSelectView:self customSectionView:sectionHeaderView viewForHeaderInSection:section];
    }
    
    return sectionHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([self.delegate respondsToSelector:@selector(catPersonSelectView:heightForHeaderInSection:)]) {
        return [self.delegate catPersonSelectView:self heightForHeaderInSection:section];
    }
    return 20;
}

+ (UIImage *)imageResourcePathWithName:(NSString *)name {
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"CatPersonSelect" ofType:@"bundle"];
    NSString *imagePath = [resourcePath stringByAppendingPathComponent:name];
    if ([UIScreen mainScreen].scale > 2) {
        imagePath = [imagePath stringByAppendingString:@"@3x.png"];
    }else {
        imagePath = [imagePath stringByAppendingString:@"@2x.png"];
    }

    return [UIImage imageWithContentsOfFile:imagePath];
}

#pragma mark - UICollectionView -
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _localSelectPersons.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CatPersonSelectShowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CatPersonSelectShowCellString forIndexPath:indexPath];
    cell.model = _localSelectPersons[indexPath.row];
    NSURL *url = [NSURL URLWithString:[self _parseWithMapper:_mapper item:cell.model keyString:CatPersonSelectImageString]];
    [[CC_WebImageManager shared] loadImageWithURL:url progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, BOOL finished) {
        cell.headView.image = image;
    }];
    return cell;
}

#pragma mark - Internal -
- (id<CatPersonSelectDatesource>)searchModelWithIndexPath:(NSIndexPath *)indexPath {
    NSString *initial = [_initials objectAtIndex:indexPath.section];
    return [_orderedDic objectForKey:initial][indexPath.row];
}

@end

#pragma mark - CatPersonSelectVC -

@interface CatPersonSelectVC () {
@public
    UIButton *_completedButton;
@private
    CatPersonSelectView *_pickerView;
    UIColor *_originNavigationColor;
}

@end

@implementation CatPersonSelectVC

+ (instancetype)controllerWithPickerView:(CatPersonSelectView *)pickerView {
    CatPersonSelectVC *controller = [CatPersonSelectVC new];
    controller->_pickerView = pickerView;
    controller->_pickerView->_vc = controller;
    
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = ({
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[CatPersonSelectView imageResourcePathWithName:@"nav_back"]
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(leftBarButtonDidClick:)];
        item;
    });
    
    if (self->_pickerView->_type == CatPersonSelectViewTypeMultiple) {
        self.navigationItem.rightBarButtonItem = ({
            UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.pickerView.doneButton];
            _completedButton = self.pickerView.doneButton;
            item;
        });
    }
    
    if (_pickerView) {
        [self.view addSubview:_pickerView];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fixup:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self fixup:YES];
}

- (void)leftBarButtonDidClick:(UIBarButtonItem *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:CatPersonSelectWillDisappearNotification object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)fixup:(BOOL)isDidAppear {
    if (isDidAppear) {
        self.navigationController.navigationBar.shadowImage = nil;
        self.navigationController.navigationBar.barTintColor = _originNavigationColor;
    }else {
        self.navigationController.navigationBar.shadowImage = [UIImage new];
        _originNavigationColor = self.navigationController.navigationBar.barTintColor;
        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    }
}

@end

CatPersonSelectStringKey const CatPersonSelectTitleString = @"CatPersonSelectTitleString";
CatPersonSelectStringKey const CatPersonSelectImageString = @"CatPersonSelectImageString";
CatPersonSelectStringKey const CatPersonSelectCategroyString = @"CatPersonSelectCategroyString";

NSNotificationName const CatPersonSelectWillDisappearNotification = @"CatPersonSelectWillDisappearNotification";
NSNotificationName const CatPersonSelectDoneNotification = @"CatPersonSelectDoneNotification";
NSNotificationName const CatPersonSelectIncrementalPersonsNotification = @"CatPersonSelectIncrementalPersonsNotification";

CGFloat const CatPersonSelectExtraCellTag = 90120408;
