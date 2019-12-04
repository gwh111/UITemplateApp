//
//  CatListCell.h
//  UITemplateLib
//
//  Created by yichen on 2019/5/28.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+catCornerMark.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger , CatCellBottomStyle) {
    CatCellStyleBottomTypeRight,
    CatCellStyleBottomTypeCenter,
    CatCellStyleBottomTypeCenterContainShared,
};

typedef NS_ENUM(NSInteger , CatCellImageStyle) {
    CatCellImageStyleListMode,
    CatCellImageStyleThreeTypeMode,
    CatCellImageStyleNewThreeTypeMode,
};

typedef NS_ENUM(NSInteger , CatCellContentClickType) {
    CatCellContentClickTypeHead,
    CatCellContentClickTypeImage,
    CatCellContentClickTypeShare,
    CatCellContentClickTypeComment,
    CatCellContentClickTypeLike,
};
@class YCButton;
@class CatListCell;
@protocol CatListCellDelegate <NSObject>

- (void)didClickCellContent:(CatListCell *)cell withType:(CatCellContentClickType)clickType withIndexPath:(NSIndexPath *)index withInfo:(NSInteger)info;

@end

@interface CatListCell : UITableViewCell

@property (nonatomic, assign)CatCellBottomStyle bottomStyle;
@property (nonatomic, assign)CatCellImageStyle imageStyle;
@property (nonatomic, strong)UIImageView *headIv;
@property (nonatomic, strong)UILabel *nameLb;
@property (nonatomic, strong)UILabel *timeLb;
@property (nonatomic, strong)UILabel *titleLb;
@property (nonatomic, strong)UILabel *contentLb;
@property (nonatomic, strong)YCButton *sharedBtn;
@property (nonatomic, strong)YCButton *commentBtn;
@property (nonatomic, strong)YCButton *likeBtn;

@property (nonatomic, strong)NSArray *imgArr;
@property (nonatomic, strong)NSIndexPath *index;
@property (nonatomic, weak)id<CatListCellDelegate>delegate;

@end

@interface YCButton : UIButton

@end

NS_ASSUME_NONNULL_END
