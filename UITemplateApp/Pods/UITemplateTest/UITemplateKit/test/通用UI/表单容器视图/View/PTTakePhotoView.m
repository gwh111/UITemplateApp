//
//  PTTakePhotoView.m
//  Patient
//
//  Created by ml on 2019/7/16.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "PTTakePhotoView.h"
#import "CatPickerPhotoController.h"
// #import "UIScrollView+PT.h"
#import "ccs.h"
#import "Masonry.h"
#import "CatFormView.h"
#import "UIView+CCWebImage.h"

@interface PTTakePhotoView () <CatSimpleViewLayoutDelegate,CatPickerPhotoControllerDelegate>

@property (nonatomic,strong) UIButton *fakePhotoButton;

@end

@implementation PTTakePhotoView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    CatStickerView *stickerView = [[CatStickerView alloc] initWithFrame:self.bounds];
    stickerView.placeholderView = ({
        CatSimpleView *plView = [[CatSimpleView alloc] initWithFrame:self.bounds];
        plView
            .LYOneButton.n2Image([UIImage imageNamed:@"subsequent_plus_photo"])
            .LYTitleLabel.n2Text(@"拍照化验单、检查资料、报告单、药品处方单、患处照片(支持9张)").n2Lines(2).n2Font(RF(15)).n2TextColor(HEX(0x878787))
            .LYDescLabel.n2Text(@"照片仅医生和自己可见").n2Font(RF(12)).n2TextColor(HEX(0xbebebe))
            .delegate = self;
        ;
        [plView.oneButton addTarget:self action:@selector(takePhotoAction:) forControlEvents:UIControlEventTouchUpInside];
        plView;
    });
    stickerView.datasource = self;
    stickerView.delegate = self;
    stickerView.scrollable = NO;
    stickerView.layout.marginSectionInset = UIEdgeInsetsMake(RH(16), RH(16), 0, RH(16));
    
    [self addSubview:stickerView];
    self.stickerView = stickerView;
}

#pragma mark - Actions -
- (void)takePhotoAction:(UIButton *)sender {
    CatPickerPhotoController *vc = [CatPickerPhotoController controllerWithMode:CatPickerPhotoModeMultiple delegate:self];
    CatTakePhoneImages(vc, @"common_check", @"common_uncheck", @"subsequent_take_photo");
    vc.maxCount = 9 - self.images.count;
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:vc];
    [[self cc_viewController] presentViewController:navC animated:YES completion:nil];
}

- (void)closeAction:(UIButton *)sender {
    CatSimpleView *reuseView = (CatSimpleView *)sender.superview;
    if ([reuseView isKindOfClass:[CatSimpleView class]]) {
        NSMutableArray *images = [NSMutableArray array];
        for (int i = 0; i < self.images.count; ++i) {
            if (![self.images[i] isEqual:reuseView.icon.image]) {
                [images addObject:self.images[i]];
            }
        }
        self.images = images.copy;
        for (UIView *view in self.stickerView.subviews) {
            if ([view isKindOfClass:[CatSimpleView class]]) {
                [view removeFromSuperview];
            }
        }
        [self reloadPhotosImages:self.images isAppend:NO];
    }
}

#pragma mark - CatPickerPhotoController -
- (void)catPickerPhotoController:(CatPickerPhotoController *)controller
       didFinishPickingWithItems:(NSArray <UIImage *> *)images {
    [self reloadPhotosImages:images isAppend:YES];
}

- (void)reloadPhotosImages:(NSArray *)images isAppend:(BOOL)append{
    if (images.count > 0) {
        self.stickerView.placeholderView.hidden = YES;
        self.stickerView.userInteractionEnabled = YES;
        if (append) {
            NSMutableArray *allImages = [NSMutableArray arrayWithArray:self.images];
            [allImages addObjectsFromArray:images];
            self.images = allImages;
            if (allImages.count > 9) {
                NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 8)];
                self.images = [allImages objectsAtIndexes:set];
            }
        }else {
            self.images = images;
        }
        
        [self.stickerView reloadData];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(self.images.count - 1) inSection:0];
        CatSimpleView *lastView = [self.stickerView stickerViewForIndexPath:indexPath];
        
        if (self.images.count < 9) {
            if (self.fakePhotoButton == nil) {
                self.fakePhotoButton = [[UIButton alloc] initWithFrame:CGRectMake(RH(16), RH(14), RH(73), RH(73))];
                [self.fakePhotoButton setImage:[UIImage imageNamed:@"subsequent_plus_photo"] forState:UIControlStateNormal];
                [self.fakePhotoButton addTarget:self action:@selector(takePhotoAction:) forControlEvents:UIControlEventTouchUpInside];
                [self.stickerView addSubview:self.fakePhotoButton];
            }
            self.fakePhotoButton.hidden = NO;
            
            if (self.images.count % 4 == 0) {
                [self.fakePhotoButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(RH(16));
                    make.top.mas_equalTo(lastView.mas_bottom).mas_offset(RH(20));
                    make.width.height.mas_equalTo(RH(70));
                }];
                self.stickerView.height += RH(74) + RH(16);
            }else {
                [self.fakePhotoButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(lastView.mas_right).mas_offset(RH(10));
                    make.top.mas_equalTo(lastView.mas_top).mas_offset(RH(3));
                    make.width.height.mas_equalTo(RH(70));
                }];
            }
        }else {
            self.fakePhotoButton.hidden = YES;
        }
        
        CatSimpleView *agreeView = [self.formView formSubviewForIndex:8];
        CGFloat maxY = [self.stickerView convertPoint:CGPointMake(0, CGRectGetMaxY(lastView.frame)) toView:self.formView.scrollView].y;
        agreeView.top = maxY + RH(16);
        if (self.images.count % 4 == 0) {
            agreeView.top += RH(73);
        }
        self.formView.submitButton.superview.top = agreeView.bottom + RH(16);
        self.formView.scrollView.contentSize = CGSizeMake(WIDTH(), self.formView.submitButton.superview.bottom + RH(16));
        self.height = self.stickerView.height + RH(10);
        
        [self.formView reloadData];
    }else {        
        [self.stickerView reloadData];
        self.stickerView.placeholderView.hidden = NO;
        self.fakePhotoButton.hidden = YES;
    }
}

#pragma mark - StickerView -

- (NSInteger)stickerView:(CatStickerView *)stickerView numberOfRowsInSection:(NSInteger)section {
    self.stickerView.placeholderView.hidden = self.images.count > 0 ? YES : NO;
    if (self.images.count > 9) { return 9; }
    return self.images.count;
}

- (void)stickerView:(CatStickerView *)stickerView willDisplayView:(CatSimpleView *)view atIndexPath:(NSIndexPath *)indexPath {
    view.LYSelf.n2W(RH(73)).n2H(RH(73))
        .LYIcon.n2Top(RH(3)).n2W(RH(70)).n2H(RH(70))
        .LYCloseButton.n2Image([UIImage imageNamed:@"right_close"]).n2Hidden(NO).n2Top(RH(-3)).n2Left(RH(60)).n2SizeToFit();
    
    [view.closeButton addTarget:self
                         action:@selector(closeAction:)
               forControlEvents:UIControlEventTouchUpInside];
    
    if([self.images[indexPath.row] isKindOfClass:[UIImage class]]) {
        view.icon.image = self.images[indexPath.row];
    }else {
        WS(weakSelf)
        [view.icon cc_setImageWithURL:[NSURL URLWithString:self.images[indexPath.row]]
                     placeholderImage:nil
                     showProgressView:NO
                            completed:^(UIImage * _Nullable image, NSError * _Nullable error, BOOL finished) {
            SS(strongSelf)
            NSMutableArray *imagesM = [NSMutableArray arrayWithArray:strongSelf.images];
            imagesM[indexPath.row] = image;
            strongSelf.images = imagesM.copy;
        }];
    }
}

#pragma mark - Layout -
- (void)layoutSimpleView:(CatSimpleView *)simpleView {
    [simpleView.oneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(RH(16));
        make.top.mas_equalTo(RH(16));
        make.height.width.mas_equalTo(RH(73));
    }];
    
    [simpleView.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(simpleView.oneButton.mas_right).mas_offset(11);
        make.right.mas_equalTo(RH(-16));
        make.top.mas_equalTo(simpleView.oneButton).mas_offset(8);
    }];
    
    [simpleView.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(simpleView.titleLabel);
        make.bottom.mas_equalTo(simpleView.oneButton);
    }];
}

@end
