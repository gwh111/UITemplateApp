//
//  CatChatDetailCell.m
//  UITemplateKit
//
//  Created by gwh on 2019/6/17.
//  Copyright © 2019 路飞. All rights reserved.
//

#import "CatChatDetailCell.h"
#import "ccs.h"
#import "UIView+CCWebImage.h"

@interface CatChatDetailCell()<UITextViewDelegate>{
}

@end

@implementation CatChatDetailCell
@synthesize cellType,cellPosition,delegate;
@synthesize figureUrlStr,imageUrlStr,defaultHeight;

+ (id)dequeueReusableCellWithType:(CatChatDetailCellType)type andPosition:(CatChatDetailCellPosition)position andTableView:(UITableView *)tableView andDelegate:(id <CatChatDetailCellDelegate>)delegate1 specialCode:(NSString *)specialCode{
    
    NSString *idStr=[NSString stringWithFormat:@"CatChatDetailCell_%lu_%lu_%@",(unsigned long)type,(unsigned long)position,specialCode];
    CatChatDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:idStr];
    if (!cell) {
        cell = [[CatChatDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idStr];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=UIColor.clearColor;
        cell.delegate=delegate1;
        cell.cellPosition=position;
        cell.cellType=type;
        cell.width=tableView.width;
        [cell initUI];
    }
    return cell;
}

- (void)initUI{
    
    if (cellType!=CatChatTypeNotice) {
        
        UIImageView *figureImageV=[[UIImageView alloc]initWithFrame:CGRectMake(RH(10), RH(10), RH(40), RH(40))];
        if (cellPosition==CatChatPositionRight) {
            figureImageV.right=WIDTH()-RH(10);
        }
        figureImageV.backgroundColor=[UIColor grayColor];
        figureImageV.layer.cornerRadius = RH(20);
        figureImageV.layer.masksToBounds = YES;
        [self addSubview:figureImageV];
        figureImageV.name=@"figureImageV";
        [figureImageV cc_tappedInterval:1 withBlock:^(id  _Nonnull view) {
            UIImageView *imageview = (UIImageView *)view;
            if (self->delegate&&[self->delegate respondsToSelector:@selector(catChatDetailCell:tappedWithViewName:)]) {
                [self->delegate catChatDetailCell:self tappedWithViewName:imageview.name];
            }
        }];
    }
    
    if (cellType==CatChatTypeText) {
        
        UIView *chatContentV=[[UIView alloc]init];
        chatContentV.backgroundColor=UIColor.whiteColor;
        if (cellPosition==CatChatPositionRight) {
            chatContentV.backgroundColor=HEX(0x39A1FD);
        }
        [self addSubview:chatContentV];
        chatContentV.name=@"chatContentV";
        
        CC_TextView *textV=[[CC_TextView alloc]init];
        textV.font=RF(17);
        textV.textColor=HEX(0x324057);
        if (cellPosition==CatChatPositionRight) {
            textV.textColor=UIColor.whiteColor;
        }
        textV.backgroundColor=UIColor.clearColor;
        textV.editable=NO;
        textV.scrollEnabled=NO;
        [self addSubview:textV];
        textV.name=@"chatTextV";
        
        [self addmask:chatContentV];
        
    }else if (cellType==CatChatTypeNotice) {
        UIView *chatContentV=[[UIView alloc]init];
        chatContentV.frame=CGRectMake(RH(10), RH(10), self.width-RH(20), RH(50));
        chatContentV.backgroundColor=HEX(0xE6E6E6);
        chatContentV.layer.cornerRadius = RH(15);
        chatContentV.layer.masksToBounds = YES;
        [self addSubview:chatContentV];
        chatContentV.name=@"chatContentV";
        
        CC_TextView *textV=[[CC_TextView alloc]init];
        textV.frame=CGRectMake(RH(20), RH(12), self.width-RH(40), chatContentV.height);
        textV.font=RF(15);
        textV.textColor=[UIColor darkGrayColor];
        textV.backgroundColor=UIColor.clearColor;
        textV.editable=NO;
        textV.scrollEnabled=NO;
        textV.delegate=self;
        [self addSubview:textV];
        textV.name=@"noticeTextV";
        
    }else if (cellType==CatChatTypeImage) {
        
        UIView *imageContentV=[[UIView alloc]init];
        imageContentV.backgroundColor=UIColor.whiteColor;
        [self addSubview:imageContentV];
        imageContentV.name=@"imageContentV";
        
        UIImageView *imageV=[[UIImageView alloc]init];
        imageV.backgroundColor=UIColor.whiteColor;
        [self addSubview:imageV];
        imageV.name=@"imageV";
    }
    
    if (delegate&&[delegate respondsToSelector:@selector(catChatDetailCell:finishInitWithViewNames:)]) {
        [delegate catChatDetailCell:self finishInitWithViewNames:[self getViewNames]];
    }
}

- (float)update{
    float h=0;
    float chatPlusH=RH(4);
    float chatPlusW=RH(15);
    float cellPlusH=RH(30);
    
    UIImageView *figureImageV=[self cc_viewWithName:@"figureImageV"];
    if (figureUrlStr) {
        [figureImageV cc_setImageWithURL:[NSURL URLWithString:figureUrlStr]];
    }
    
    UIView *chatContentV=[self cc_viewWithName:@"chatContentV"];
    
    if (cellType==CatChatTypeText) {
        chatContentV.frame=CGRectMake(RH(60), RH(10), self.width-RH(120), RH(50));
        UITextView *textV=[self cc_viewWithName:@"chatTextV"];
        textV.frame=CGRectMake(RH(75), RH(12), self.width-RH(150), RH(50));
        textV.text=_chatText;
        if (_chatAttText) {
            textV.attributedText=_chatAttText;
        }
        [textV sizeToFit];
        chatContentV.height=textV.height+chatPlusH;
        chatContentV.width=textV.width+chatPlusW*2;
        if (cellPosition==CatChatPositionLeft) {
            
        }else if (cellPosition==CatChatPositionRight){
            UIImageView *figureImageV=[self cc_viewWithName:@"figureImageV"];
            chatContentV.right=figureImageV.left-RH(10);
            textV.right=figureImageV.left-RH(10)-chatPlusW;
        }
        [self addmask:chatContentV];
        h=textV.height+cellPlusH;
    }else if (cellType==CatChatTypeNotice){
        UITextView *textV=[self cc_viewWithName:@"noticeTextV"];
        textV.text=_chatText;
        if (_chatAttText) {
            textV.attributedText=_chatAttText;
        }
        [textV sizeToFit];
        textV.width=self.width-RH(40);
        chatContentV.height=textV.height+chatPlusH;
        [self addmask:chatContentV];
        h=textV.height+cellPlusH;
    }else if (cellType==CatChatTypeImage){
        UIView *imageContentV=[self cc_viewWithName:@"imageContentV"];
        imageContentV.frame=CGRectMake(RH(10), RH(10), RH(150), RH(150));
        UIImageView *imageV=[self cc_viewWithName:@"imageV"];
        imageV.frame=CGRectMake(RH(25), RH(25), RH(120), RH(120));
        if (cellPosition==CatChatPositionLeft) {
            imageContentV.left=figureImageV.right+RH(10);
            imageV.left=figureImageV.right+RH(25);
        }else if (cellPosition==CatChatPositionRight){
            imageContentV.right=figureImageV.left-RH(10);
            imageV.right=figureImageV.left-RH(25);
        }
        if (imageUrlStr) {
            [imageV cc_setImageWithURL:[NSURL URLWithString:imageUrlStr]placeholderImage:nil processBlock:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, BOOL finished) {
                if (!image) {
                    return;
                }
                float w=image.size.width*imageV.height/image.size.height;
                float maxw=self.width-figureImageV.width*2-RH(70);
                if (w>maxw) {
                    w=maxw;
                }
                imageV.width=w;
                imageContentV.width=w+RH(30);
                [self addmask:imageContentV];
                
                if (self->cellPosition==CatChatPositionLeft) {
                    imageContentV.left=figureImageV.right+RH(10);
                    imageV.left=figureImageV.right+RH(25);
                }else if (self->cellPosition==CatChatPositionRight){
                    imageContentV.right=figureImageV.left-RH(10);
                    imageV.right=figureImageV.left-RH(25);
                }
                
                if (self->delegate&&[self->delegate respondsToSelector:@selector(catChatDetailCell:finishLoadImage:)]) {
                    [self->delegate catChatDetailCell:self finishLoadImage:image];
                }
                
            }];
        }
        [self addmask:imageContentV];
        [imageV cc_tappedInterval:.5 withBlock:^(id  _Nonnull view) {
            if (self->delegate&&[self->delegate respondsToSelector:@selector(catChatDetailCell:tappedWithImage:)]) {
                UIImageView *tempImgV=(UIImageView *)view;
                [self->delegate catChatDetailCell:self tappedWithImage:tempImgV.image];
            }else{
                [self addImageV:view];
            }
        }];
        h=imageContentV.height+cellPlusH;
    }else{
        h=defaultHeight;
    }
    
    if (delegate&&[delegate respondsToSelector:@selector(catChatDetailCell:finishUpdateWithViewNames:)]) {
        [delegate catChatDetailCell:self finishUpdateWithViewNames:[self getViewNames]];
    }
    
    return h;
}

- (void)addImageV:(UIView *)imageV{
    UIView *lastV=imageV.superview;
    CGRect lastRect=imageV.frame;
    
    UIScrollView *displayV=[[UIScrollView alloc]initWithFrame:[self getLastWindow].frame];
    displayV.backgroundColor=UIColor.blackColor;
    [displayV addSubview:imageV];
    
    float h=imageV.size.height*WIDTH()/imageV.size.width;
    if (h>displayV.height) {
        [displayV setContentSize:CGSizeMake(0, h)];
    }
    
    imageV.left=0;
    imageV.width=WIDTH();
    imageV.height=h;
    imageV.center=CGPointMake(displayV.width/2, displayV.height/2);
    [[self getLastWindow] addSubview:displayV];
    
    [imageV cc_tappedInterval:.5 withBlock:^(id  _Nonnull view) {
        UIView *tapView = (UIView *)view;
        [displayV removeFromSuperview];
        
        tapView.userInteractionEnabled=YES;
        tapView.frame=lastRect;
        [lastV addSubview:view];
        
        [view cc_tappedInterval:.5 withBlock:^(id  _Nonnull view) {
            [self addImageV:view];
        }];
    }];
    
    [displayV cc_tappedInterval:.5 withBlock:^(id  _Nonnull view) {
        [view removeFromSuperview];
        
        imageV.userInteractionEnabled=YES;
        imageV.frame=lastRect;
        [lastV addSubview:imageV];
        
        [imageV cc_tappedInterval:.5 withBlock:^(id  _Nonnull view){
            [self addImageV:view];
        }];
    }];
}

- (void)addmask:(UIView *)chatContentV{
    CGRect bounds=CGRectMake(0, 0, chatContentV.width, chatContentV.height);
    UIBezierPath *maskPath;
    CGSize radii=CGSizeMake(RH(15), RH(15));
    maskPath=[UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:UIRectCornerTopRight|UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:radii];
    if (cellPosition==CatChatPositionRight) {
        maskPath=[UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:radii];
    }
    CAShapeLayer *maskLayer=[[CAShapeLayer alloc] init];
    maskLayer.frame=bounds;
    maskLayer.path=maskPath.CGPath;
    [chatContentV.layer addSublayer:maskLayer];
    chatContentV.layer.mask=maskLayer;
    chatContentV.layer.masksToBounds=YES;
}

- (NSArray *)getViewNames{
    NSMutableArray *names=@[].mutableCopy;
    for (UIView *view in self.subviews) {
        if (view.name) {
            [names addObject:view.name];
        }
    }
    return names;
}

#pragma mark delegate
-(BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    if (self->delegate&&[self->delegate respondsToSelector:@selector(catChatDetailCell:tappedWithUrlStr:)]) {
        [self->delegate catChatDetailCell:self tappedWithUrlStr:URL.absoluteString];
    }
    return NO;
}


- (UIWindow *)getLastWindow {
    NSArray *windows = [UIApplication sharedApplication].windows;
    for(UIWindow *window in [windows reverseObjectEnumerator]) {
        
        if ([window isKindOfClass:[UIWindow class]] &&
            CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds)&&window.hidden==NO){
            return window;
        }
    }
    
    return [UIApplication sharedApplication].keyWindow;
}

@end
