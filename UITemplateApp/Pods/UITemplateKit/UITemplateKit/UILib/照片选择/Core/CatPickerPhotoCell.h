//
//  CatPickerPhotoCell.h
//  Patient
//
//  Created by ml on 2019/6/14.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CatPickerPhotoCell : UICollectionViewCell

@property (nonatomic,copy) NSString *representedAssetIdentifier;
@property (nonatomic,strong) UIImageView *icon;
@property (nonatomic,strong) UIButton *checkButton;
@property (nonatomic,strong) UIImageView *livePhotoBadgeImageView;
@property (nonatomic,strong) UIImage *originImage;

@end

NS_ASSUME_NONNULL_END
