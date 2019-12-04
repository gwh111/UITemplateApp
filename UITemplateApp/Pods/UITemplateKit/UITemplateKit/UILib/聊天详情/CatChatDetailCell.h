//
//  CatChatDetailCell.h
//  UITemplateKit
//
//  Created by gwh on 2019/6/17.
//  Copyright © 2019 路飞. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    CatChatTypeText,
    CatChatTypeImage,
    CatChatTypeNotice,
    CatChatTypeEmpty,//只有头像 在代理扩展view
} CatChatDetailCellType;

typedef enum : NSUInteger {
    CatChatPositionLeft,
    CatChatPositionCenter,
    CatChatPositionRight,
} CatChatDetailCellPosition;

@class CatChatDetailCell;
@protocol CatChatDetailCellDelegate <NSObject>

//初始化完
- (void)catChatDetailCell:(CatChatDetailCell *)cell finishInitWithViewNames:(NSArray *)names;
//数据更新完
- (void)catChatDetailCell:(CatChatDetailCell *)cell finishUpdateWithViewNames:(NSArray *)names;
//图片下载完
- (void)catChatDetailCell:(CatChatDetailCell *)cell finishLoadImage:(UIImage *)image;
//图片点击
- (void)catChatDetailCell:(CatChatDetailCell *)cell tappedWithImage:(UIImage *)image;
//视图点击
- (void)catChatDetailCell:(CatChatDetailCell *)cell tappedWithViewName:(NSString *)name;
//链接点击
- (void)catChatDetailCell:(CatChatDetailCell *)cell tappedWithUrlStr:(NSString *)urlStr;

@end

@interface CatChatDetailCell : UITableViewCell


@property (nonatomic,retain) NSString *typeCode;//类型
@property (nonatomic,assign) float defaultHeight;//新增类型默认高度

@property (nonatomic,assign) NSUInteger row;
@property (nonatomic,assign) NSUInteger section;

//大类型 文本 图片 通知
@property (nonatomic,assign) CatChatDetailCellType cellType;
//位置 左 右
@property (nonatomic,assign) CatChatDetailCellPosition cellPosition;
@property (nonatomic,weak) id <CatChatDetailCellDelegate>delegate;

@property (nonatomic,retain) NSString *figureUrlStr;
//CatChatTypeText
@property (nonatomic,retain) NSString *chatText;

//CatChatTypeNotice
@property (nonatomic,retain) NSAttributedString *chatAttText;

//CatChatTypeImage
@property (nonatomic,retain) NSString *imageUrlStr;

+ (id)dequeueReusableCellWithType:(CatChatDetailCellType)type andPosition:(CatChatDetailCellPosition)position andTableView:(UITableView *)tableView andDelegate:(id <CatChatDetailCellDelegate>)delegate1 specialCode:(NSString*)specialCode;

- (float)update;

- (void)addmask:(UIView *)chatContentV;

@end

NS_ASSUME_NONNULL_END
