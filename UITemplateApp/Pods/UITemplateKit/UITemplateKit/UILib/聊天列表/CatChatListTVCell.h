//
//  CatChatListTVCell.h
//  UITemplateLib
//
//  Created by 路飞 on 2019/5/9.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ccs.h"

NS_ASSUME_NONNULL_BEGIN

@interface CatChatListTVCell : UITableViewCell

//头像
@property (nonatomic, strong) UIImageView* iconImgV;
//标题
@property (nonatomic, strong) UILabel* titleLb;
//内容
@property (nonatomic, strong) UILabel* contentLb;
//分割线
@property (nonatomic, strong) UIView* seperateLine;
//时间
@property (nonatomic, strong) UILabel* timeLb;

//时间
@property (nonatomic, strong) NSString* timeStr;
//未读消息数
@property (nonatomic, strong) NSString* unReadNum;

+(CatChatListTVCell*)createCatChatListTVCellWithTableView:(UITableView*)tableView;

@end

NS_ASSUME_NONNULL_END
