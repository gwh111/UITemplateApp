//
//  CatTabbarController.m
//  UITemplateKit
//
//  Created by 路飞 on 2019/5/31.
//  Copyright © 2019 路飞. All rights reserved.
//

#define kCatTabbarSelectedColor RGBA(36, 151, 235, 1)
#define kCatTabbarNormalColor RGBA(167, 164, 164, 1)

#import "CatTabbarController.h"
#import "CatBaseNC.h"
#import "CatBaseVC.h"

@interface CatTabbarController ()

@property (nonatomic, strong) NSMutableArray* classNameArr;
@property (nonatomic, strong) NSMutableArray* titleArr;
@property (nonatomic, strong) NSMutableArray* imgNameArr;
@property (nonatomic, strong) NSMutableArray* selectedImgNameArr;
@property (nonatomic, strong) UIColor* textColor;
@property (nonatomic, strong) UIColor* selectedTextColor;
@property (nonatomic, assign) CatTabbarTheme theme;

@property (nonatomic, strong) NSMutableArray* childControllerArr;
@property (nonatomic, strong) NSMutableArray* itemArr;
@end

@implementation CatTabbarController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.itemArr = [[NSMutableArray alloc]init];
    self.childControllerArr = [[NSMutableArray alloc]init];
}

#pragma mark - network

#pragma mark - private
- (void)setUpChildVC {
    for (int i = 0; i < _classNameArr.count; i++) {
        NSString* className = _classNameArr[i];
        Class childClass = NSClassFromString(className);
        UIViewController* vc = (UIViewController*)[[childClass alloc]init];
        [self addChildVC:vc title:_titleArr[i] image:_imgNameArr[i] selectedImage:_selectedImgNameArr[i] index:i];
    }
    self.viewControllers = self.childControllerArr;
}

- (void) addChildVC:(UIViewController *)childVC title:(NSString *) title image:(NSString *) image selectedImage:(NSString *) selectedImage index:(int)index{
    
    UITabBarItem *item = childVC.tabBarItem;
    item.tag = 100 +index;
    NSMutableDictionary *normalDic = [NSMutableDictionary dictionary];
    NSMutableDictionary *selectedDic = [NSMutableDictionary dictionary];
    switch (_theme) {
        case CatTabbarThemeNormal:
            item.title = title;
            normalDic[NSForegroundColorAttributeName] = _textColor;
            normalDic[NSFontAttributeName] = RF(11.0f);
            [item setTitleTextAttributes:normalDic forState:UIControlStateNormal];
            selectedDic[NSForegroundColorAttributeName] = _selectedTextColor;
            selectedDic[NSFontAttributeName] = RF(11.0f);
            [item setTitleTextAttributes:selectedDic forState:UIControlStateSelected];
            item.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            item.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            break;
        case CatTabbarThemeImage:
            item.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            item.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            item.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
            break;
        default:
            break;
    }
    [self.itemArr addObject:item];
    CatBaseNC* nav = [[CatBaseNC alloc]initWithRootViewController:childVC];
    [self.childControllerArr addObject:nav];
}

#pragma mark - public
- (instancetype)initWithClassNameArr:(NSArray<NSString *> *)classNameArr titleArr:(NSArray<NSString *> *)titleArr imageNameArr:(NSArray<NSString *> *)imageNameArr selectedImageNameArr:(NSArray<NSString *> *)selectedImageArr textColor:(UIColor *)textColor selectedTextColor:(UIColor *)selectedTextColor theme:(CatTabbarTheme)theme{
    if (self = [super init]) {
        self.classNameArr = [classNameArr mutableCopy];
        self.titleArr = [titleArr mutableCopy];
        self.imgNameArr = [imageNameArr mutableCopy];
        self.selectedImgNameArr = [selectedImageArr mutableCopy];
        self.textColor = textColor?textColor:kCatTabbarNormalColor;
        self.selectedTextColor = selectedTextColor?selectedTextColor:kCatTabbarSelectedColor;
        self.theme = theme;
        [self setUpChildVC];
    }
    return self;
}

- (void)addItemWithClassName:(NSString *)className title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName index:(NSInteger)index{
    if (index <= self.childControllerArr.count) {
        
        [self.classNameArr insertObject:className atIndex:index];
        [self.titleArr insertObject:title atIndex:index];
        [self.imgNameArr insertObject:imageName atIndex:index];
        [self.selectedImgNameArr insertObject:selectedImageName atIndex:index];
        
        Class childClass = NSClassFromString(className);
        UIViewController *VC = (UIViewController*)[[childClass alloc] init];
        CatBaseNC *nav = [[CatBaseNC alloc] initWithRootViewController:VC];
        
        NSMutableDictionary *normalDic = [NSMutableDictionary dictionary];
        NSMutableDictionary *selectedDic = [NSMutableDictionary dictionary];
        switch (_theme) {
            case CatTabbarThemeNormal:
                nav.tabBarItem.title = title;
                normalDic[NSForegroundColorAttributeName] = _textColor;
                normalDic[NSFontAttributeName] = RF(11.0f);
                [nav.tabBarItem setTitleTextAttributes:normalDic forState:UIControlStateNormal];
                selectedDic[NSForegroundColorAttributeName] = _selectedTextColor;
                selectedDic[NSFontAttributeName] = RF(11.0f);
                [nav.tabBarItem setTitleTextAttributes:selectedDic forState:UIControlStateSelected];
                nav.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                break;
            case CatTabbarThemeImage:
                nav.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                nav.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
                break;
            default:
                break;
        }
        
        [self.childControllerArr insertObject:nav atIndex:index];
        self.viewControllers = self.childControllerArr;
    }
}

- (void)deleteItemAtIndex:(NSInteger)index{
    if (index < self.childControllerArr.count) {
        
        [self.classNameArr removeObjectAtIndex:index];
        [self.titleArr removeObjectAtIndex:index];
        [self.imgNameArr removeObjectAtIndex:index];
        [self.selectedImgNameArr removeObjectAtIndex:index];
        
        [self.childControllerArr removeObjectAtIndex:index];
        self.viewControllers = self.childControllerArr;
    }
}

- (void)updateBadgeNum:(NSString *)badgeNum index:(NSInteger)index{
    UITabBarItem* item = _itemArr[index];
    //    if ([badgeNum integerValue] <= 0) {
    //        item.badgeValue = nil;
    //    }else{
    item.badgeValue = badgeNum;
    //    }
}
#pragma mark - notification

#pragma mark - delegate

#pragma mark - property


@end
