//
//  CatImagePreviewVC.h
//  CatImagePicker
//
//  Created by david on 2018/12/18.
//  Copyright © 2018 david. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CatImagePreviewVC : UIViewController

#pragma mark - 预览图片

-(void)setPreviewImages:(NSArray <UIImage *>*)imageArr defaultIndex:(NSUInteger)defaultIndex;

-(void)setPreviewImageURLs:(NSArray <NSString *>*)imageURLArr defaultIndex:(NSUInteger)defaultIndex;

@end






