//
//  CatPagerTool.m
//  UITemplateLib
//
//  Created by 路飞 on 2019/4/26.
//  Copyright © 2019 gwh. All rights reserved.
//

//颜色
#define kDefaultCPTextColor RGBA(91, 94, 99, 1)
#define kDefaultCPSelectedTextColor RGBA(249, 249, 249, 1)
#define kDefaultCPBackColor RGBA(255, 255, 255, 1)
#define kDefaultCPSelectedBackColor RGBA(61, 68, 77, 1)
#define kDefaultCPBottomLineColor RGBA(91, 94, 99, 1)
//字体
#define kCPSegmentSmallFont RF(14.0f)
#define kCPSegmentNormalFont RF(16.0f)
#define kCPSegmentBigFont RF(22.0f)
#define kCPSegmentMargin RH(20.0f)

#import "CatPagerTool.h"
#import "CatPagerSegment.h"

@implementation CatPagerModel

@end

@implementation CatPagerTool

+(NSArray<CatPagerModel *> *)tranformArrayWithArray:(NSArray<NSString *> *)array theme:(CatPagerTheme)theme selectedIndex:(NSUInteger)selectedIndex segment:(CatPagerSegment*)segment{
    NSAssert(selectedIndex < array.count, @"默认选中项超出数组长度");
    
    NSMutableArray* muArr = @[].mutableCopy;
    for (NSInteger i = 0; i < array.count; i++) {
        CatPagerModel* model = [CatPagerTool caculateBaseConfig:theme title:array[i] segment:segment];
        if (i == selectedIndex) {
            model.selected = YES;
        }else{
            model.selected = NO;
        }
        [muArr addObject:model];
    }
    return muArr.copy;
}

+(void)caculateCatPagerSegmentDefaultConfig:(CatPagerSegment *)segment{
    
    switch (segment.theme) {
            //矩形
        case CatPagerThemeRect:
            segment.itemFont = kCPSegmentSmallFont;
            segment.textColor = kDefaultCPTextColor;
            segment.selectedTextColor = kDefaultCPSelectedTextColor;
            segment.backColor = kDefaultCPBackColor;
            segment.selectedBackColor = kDefaultCPSelectedBackColor;
            segment.bottomLineHidden = YES;
            break;
            //圆
        case CatPagerThemeRound:
            segment.itemFont = kCPSegmentSmallFont;
            segment.textColor = kDefaultCPTextColor;
            segment.selectedTextColor = kDefaultCPSelectedTextColor;
            segment.backColor = kDefaultCPBackColor;
            segment.selectedBackColor = kDefaultCPSelectedBackColor;
            segment.bottomLineHidden = YES;
            break;
            //小圆角
        case CatPagerThemeRoundCorner:
            segment.itemFont = kCPSegmentSmallFont;
            segment.textColor = kDefaultCPTextColor;
            segment.selectedTextColor = kDefaultCPSelectedTextColor;
            segment.backColor = RGBA(238, 238, 238, 1);
            segment.selectedBackColor = kDefaultCPSelectedBackColor;
            segment.bottomLineColor = kDefaultCPBackColor;
            segment.bottomLineSize = CGSizeMake(RH(24.0f), RH(6.0f));
            segment.bottomLineHidden = YES;
            break;
            //整体加圆角
        case CatPagerThemeSegmentRound:
            segment.itemFont = kCPSegmentNormalFont;
            segment.textColor = kDefaultCPTextColor;
            segment.selectedTextColor = kDefaultCPSelectedTextColor;
            segment.backColor = kDefaultCPBackColor;
            segment.selectedBackColor = kDefaultCPSelectedBackColor;
            segment.bottomLineHidden = YES;
            break;
            //下划线+和选中项字体等长
        case CatPagerThemeLine:
            segment.itemFont = kCPSegmentSmallFont;
            segment.textColor = kDefaultCPTextColor;
            segment.selectedTextColor = RGBA(6, 18, 30, 1);
            segment.backColor = kDefaultCPBackColor;
            segment.selectedBackColor = kDefaultCPBackColor;
            segment.bottomLineColor = kDefaultCPBottomLineColor;
            segment.bottomLineHidden = NO;
            break;
            //下划线+各项下划线等长
        case CatPagerThemeLineEqual:
            segment.itemFont = kCPSegmentSmallFont;
            segment.textColor = kDefaultCPTextColor;
            segment.selectedTextColor = RGBA(6, 18, 30, 1);
            segment.backColor = kDefaultCPBackColor;
            segment.selectedBackColor = kDefaultCPBackColor;
            segment.bottomLineColor = kDefaultCPBottomLineColor;
            segment.bottomLineHidden = NO;
            break;
            //下划线+选中项字体放大
        case CatPagerThemeLineZoom:
            segment.itemFont = kCPSegmentSmallFont;
            segment.itemZoomFont = kCPSegmentBigFont;
            segment.textColor = kDefaultCPTextColor;
            segment.selectedTextColor = RGBA(6, 18, 30, 1);
            segment.backColor = kDefaultCPBackColor;
            segment.selectedBackColor = kDefaultCPBackColor;
            segment.bottomLineColor = kDefaultCPBottomLineColor;
            segment.bottomLineSize = CGSizeMake(RH(12.0f), RH(2.0f));
            segment.bottomLineHidden = NO;
            break;
            
        default:
            break;
    }
}

+(CatPagerModel*)caculateBaseConfig:(CatPagerTheme)theme title:(NSString*)title segment:(CatPagerSegment*)segment{
    
    CatPagerModel* model = [[CatPagerModel alloc]init];
    model.itemTitle = title;
    model.theme = theme;
    model.tagType = CatPagerCellTagTypeNone;
    model.itemFont = segment.itemFont;
    model.textColor = segment.textColor;
    model.selectedTextColor = segment.selectedTextColor;
    model.backColor = segment.backColor;
    model.selectedBackColor = segment.selectedBackColor;
    model.bottomLineColor = segment.bottomLineColor;
    model.itemZoomFont = segment.itemZoomFont;
    model.bottomLineSize = segment.bottomLineSize;
    model.bottomLineHidden = segment.bottomLineHidden;
    model.itemSize = [CatPagerTool caculateSizeWithContent:model segment:segment];

    return model;
}

//计算每个item的size
+(CGSize)caculateSizeWithContent:(CatPagerModel*)model segment:(CatPagerSegment*)segment{
    CGSize itemSize = CGSizeZero;

    itemSize = [model.itemTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, segment.segmentHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:model.itemFont} context:nil].size;
    //记录字体宽度
    model.itemWordsWidth = itemSize.width;
    //微调
    switch (model.theme) {
        case CatPagerThemeRect:
            
            itemSize.height = segment.segmentHeight;
            itemSize.width += RH(40.0f);
            
            break;
        case CatPagerThemeRound:
            
            itemSize.height = segment.segmentHeight-RH(20.0f);
            itemSize.width += RH(20.0f);
            
            break;
        case CatPagerThemeRoundCorner:
            
            itemSize.height = segment.segmentHeight-RH(24.0f);
            itemSize.width += RH(44.0f);
            
            break;
        case CatPagerThemeSegmentRound:
            
            itemSize.height = segment.segmentHeight-RH(16.0f);
            itemSize.width = (segment.width)/segment.itemArr.count;
            
            break;
        case CatPagerThemeLine:
            
            itemSize.height = segment.segmentHeight;
//            itemSize.width += RH(40.0f);
            itemSize.width = (segment.width)/segment.itemArr.count;
            
            break;
        case CatPagerThemeLineEqual:
            
            itemSize.height = segment.segmentHeight;
            itemSize.width += RH(48.0f);
            
            break;
        case CatPagerThemeLineZoom:
            
            itemSize.height = segment.segmentHeight;
            itemSize.width += RH(40.0f);
            
            break;
            
        default:
            break;
    }
    return itemSize;
}

+(void)caculateCatPagerSegmentMargins:(CatPagerSegment *)segment{
    switch (segment.theme) {
            //矩形
        case CatPagerThemeRect:
            segment.segmentHeight = RH(44.0f);
            segment.edges = UIEdgeInsetsMake(0, 0, 0, 0);
            segment.interitemSpace = 0.0f;
            segment.frame = CGRectMake(0, 0, WIDTH(), segment.segmentHeight);
            break;
            //圆
        case CatPagerThemeRound:
            segment.segmentHeight = RH(52.0f);
            segment.edges = UIEdgeInsetsMake(RH(10.0f), RH(10.0f), RH(10.0f), RH(10.0f));
            segment.interitemSpace = RH(8.0f);
            segment.frame = CGRectMake(0, 0, WIDTH(), segment.segmentHeight);
            break;
            //小圆角
        case CatPagerThemeRoundCorner:
            segment.segmentHeight = RH(72.0f);
            segment.edges = UIEdgeInsetsMake(RH(12.0f), RH(16.0f), RH(12.0f), RH(16.0f));
            segment.interitemSpace = RH(8.0f);
            segment.frame = CGRectMake(0, 0, WIDTH(), segment.segmentHeight);
            break;
            //segment加圆角
        case CatPagerThemeSegmentRound:
            segment.segmentHeight = RH(64.0f);
            segment.edges = UIEdgeInsetsMake(RH(0.0f), RH(0.0f), RH(0.0f), RH(0.0f));
            segment.interitemSpace = RH(0.0f);
            segment.frame = CGRectMake(RH(16.0f), RH(8.0f), WIDTH()-RH(32.0f), segment.segmentHeight-RH(16.0f));
            segment.padding = 0.0;
            segment.layer.cornerRadius = (segment.segmentHeight-RH(16.0f))/2.0;
            segment.layer.masksToBounds = YES;
            break;
            //下划线+和选中项字体等长
        case CatPagerThemeLine:
            segment.segmentHeight = RH(44.0f);
            segment.edges = UIEdgeInsetsMake(RH(0.0f), RH(0.0f), RH(0.0f), RH(0.0f));
            segment.interitemSpace = RH(0.0f);
            segment.frame = CGRectMake(0, 0, WIDTH(), segment.segmentHeight);
            break;
            //下划线+各项下划线等长
        case CatPagerThemeLineEqual:
            segment.segmentHeight = RH(52.0f);
            segment.edges = UIEdgeInsetsMake(RH(0.0f), RH(0.0f), RH(0.0f), RH(0.0f));
            segment.interitemSpace = RH(0.0f);
            segment.frame = CGRectMake(0, 0, WIDTH(), segment.segmentHeight);
            break;
            //下划线+选中项字体放大
        case CatPagerThemeLineZoom:
            segment.segmentHeight = RH(56.0f);
            segment.edges = UIEdgeInsetsMake(RH(0.0f), RH(0.0f), RH(0.0f), RH(0.0f));
            segment.interitemSpace = RH(0.0f);
            segment.frame = CGRectMake(0, 0, WIDTH(), segment.segmentHeight);
            break;
            
        default:
            break;
    }
}

+(NSArray<CatPagerModel *> *)changeSegmentArrAfterClickOne:(NSArray<CatPagerModel *> *)array index:(NSInteger)index{
    for (NSInteger i = 0; i < array.count; i++) {
        CatPagerModel* model = array[i];
        if (i == index) {
            model.selected = YES;
        }else{
            model.selected = NO;
        }
    }
    return array;
}

+(CGRect)caculateTagFrameWithModel:(CatPagerModel *)model{
    if (!(model && (model.theme == CatPagerThemeLine || model.theme == CatPagerThemeLineZoom))) return CGRectZero;
    if (model.tagContent.length<1) return CGRectZero;
    
    CGRect tagRect = CGRectZero;
    if (model.tagType == CatPagerCellTagTypeNone) {
        tagRect = CGRectZero;
    }else if (model.tagType == CatPagerCellTagTypePoint) {
        tagRect = CGRectMake((model.itemSize.width+model.itemWordsWidth)/2.0, RH(10.0f), RH(8.0f), RH(8.0f));
    } else if (model.tagType == CatPagerCellTagTypeContent) {
        
        CGFloat rectWidth = [model.tagContent boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:model.badgeFont?:RF(12.0)} context:nil].size.width;
        if (rectWidth <= RH(8.0f)) {
            rectWidth = RH(8.0f);
        }
        rectWidth += RH(8.0f);
        tagRect = CGRectMake((model.itemSize.width+model.itemWordsWidth)/2.0, RH(8.0f), rectWidth, RH(16.0f));
    }
    
    return tagRect;
}
@end
