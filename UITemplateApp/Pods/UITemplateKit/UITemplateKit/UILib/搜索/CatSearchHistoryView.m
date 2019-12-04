//
//  CatSearchHistoryView.m
//  UITemplateKit
//
//  Created by ml on 2019/8/8.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatSearchHistoryView.h"
#import "ccs.h"

@implementation CatSearchHistoryView
// MARK: - LifeCycle -
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _stickerView = [[CatStickerView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(), 0)];
        _stickerView.delegate = self;
        _stickerView.datasource = self;
        CatSimpleView *sview = [[CatSimpleView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(), RH(52))];
        sview
            .LYOneView
                .n2Left(WIDTH() - RH(115))
                .n2W(RH(115)).n2H(RH(52))
            .LYTitleLabel
                .n2Text(@"搜索历史")
                .n2TextColor(HEX(0x999999)).n2Font(RF(13))
                .n2Left(RH(16)).n2SizeToFit().n2CenterY(sview.centerY)
            .LYIcon
                .n2Text(@"history_search_delete")
                .n2Left(WIDTH() - RH(12) - RH(10)).n2W(RH(12)).n2H(RH(13)).n2Top(sview.titleLabel.top)
            .LYDescLabel
                .n2Text(@"长按可单个取消")
                .n2TextColor(HEX(0xD8D8D8)).n2Font(RF(13))
                .n2UserInteractionEnabled(NO)
                .n2SizeToFit()
                .n2Left(WIDTH() - RH(115)).n2CenterY(sview.titleLabel.centerY);
        
        [sview.oneView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteAllAction:)]];
        
        _stickerView.headerView = sview;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview) {
        if (!_record) {
            _record = [[CatSearchRecordsModel alloc] initWithName:@"_cat_history"];
        }
        [self addSubview:_stickerView];
    }
}

// MARK: - Actions -
- (void)deleteAllAction:(UITapGestureRecognizer *)sender  {    
    if ([self.delegate respondsToSelector:@selector(historyView:clearAction:)]) {
        [self.delegate historyView:self clearAction:(UIButton *)sender.view];
    }
}

- (void)deleteAction:(UIButton *)sender {
    CatSimpleView *sview = [_stickerView stickerViewForIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
    [_record removeWithKeyword:sview.oneButton.titleLabel.text];
    [_stickerView reloadData];
}

- (void)longPressDeleteAction:(UILongPressGestureRecognizer *)sender {
    CatSimpleView *sview = [self.stickerView stickerViewForIndexPath:[NSIndexPath indexPathForRow:sender.view.tag inSection:0]];
    sview.closeButton.hidden = NO;
}

// MARK: - CatStickerView -
- (NSInteger)stickerView:(CatStickerView *)stickerView numberOfRowsInSection:(NSInteger)section {
    return _record.sortKeywords.count;
}

- (void)stickerView:(CatStickerView *)stickerView willDisplayView:(CatSimpleView *)view atIndexPath:(NSIndexPath *)indexPath {
    NSString *keyWord = _record.sortKeywords[indexPath.row];
    view
        .LYOneButton
            .n2Text(keyWord)
            .n2TextColor(HEX(0x999999)).n2Font(RF(13)).n2BackgroundColor(HEX(0xf7f7f7))
            .n2SizeToFit().n2W(view.oneButton.width + RH(24))
            .n2H(view.oneButton.height + RH(12)).n2Radius(RH(3)).n2Tag(indexPath.row)
            .n2UserInteractionEnabled(NO)
        .LYCloseButton
            .n2Image([UIImage imageNamed:@"right_close"])
            .n2Left(RH(view.oneButton.size.width) - RH(12)).n2H(RH(12)).n2W(RH(12))
            .n2Hidden(YES).n2Tag(indexPath.row);
    
    
    [view addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressDeleteAction:)]];
    view.size = CGSizeMake(view.oneButton.size.width, view.oneButton.size.height);
    [view.closeButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)stickerView:(CatStickerView *)stickerView didSelectAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(historyView:didSelectAtIndexPath:)]) {
        [self.delegate historyView:self didSelectAtIndexPath:indexPath];
    }
}

@end
