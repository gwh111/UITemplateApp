//
//  PTTakePhotoView.h
//  Patient
//
//  Created by ml on 2019/7/16.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatSimpleView.h"
#import "CatStickerView.h"

NS_ASSUME_NONNULL_BEGIN
@class CatFormView;

@interface PTTakePhotoView : CatSimpleView <CatStickerViewDatesource,CatStickerViewDelegate>

@property (nonatomic,strong) CatStickerView *stickerView;
/// 所有选择的图片对象
@property (nonatomic,copy) NSArray *images;

@property (nonatomic,weak) CatFormView *formView;

- (void)reloadPhotosImages:(NSArray *)images isAppend:(BOOL)append;
@end

NS_ASSUME_NONNULL_END
