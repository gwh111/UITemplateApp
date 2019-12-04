//
//  CatLoginController.h
//  UITemplateLib
//
//  Created by ml on 2019/5/16.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CatLoginCountButton.h"

NS_ASSUME_NONNULL_BEGIN
@class CatLoginController;

/// 从上到下 && 从左到右
typedef NS_ENUM(NSInteger, CatLoginEnableKey) {
    CatLoginEnableKeyBackImage         = 0,  /// 返回按钮
    CatLoginEnableKeyHelpLabel         = 1,  /// 找客服文案
    CatLoginEnableKeyGreetImage        = 2,  /// 欢迎图片
    CatLoginEnableKeyGreetLabel        = 3,  /// 欢迎文案
    CatLoginEnableKeyGreetMoreLabel    = 4,  /// 更多欢迎文案
    CatLoginEnableKeyGreetRegButton    = 5,  /// 更多文案后是否有一个注册按钮(likeFreeStyle)
    CatLoginEnableKeyAccountField      = 6,  /// 账号/邮箱/手机号输入域
    CatLoginEnableKeyPwdField          = 7,  /// 密码输入域
    CatLoginEnableKeySmsField          = 8,  /// 短信验证码输入域
    CatLoginEnableKeyForgetButton      = 9,  /// 左侧 - 忘记密码按钮(likeFreeStyle)
    CatLoginEnableKeyRegButton         = 10, /// 右侧 - 手机注册按钮(likeFreeStyle)
    CatLoginEnableKeyProtocolLabel     = 11, /// 协议文案
    CatLoginEnableKeyProtocolButton    = 12, /// 协议按钮
    CatLoginEnableKeyRoleView          = 13, /// 使用默认角色登录(KK)
    CatLoginEnableKeySubmitButton      = 14, /// 提交按钮
    CatLoginEnableKeyBottomRegLabel    = 15, /// 底部 新用户? 注册 (Default)
    CatLoginEnableKeyThirdPartyView    = 16, /// 第三方登录视图
    CatLoginEnableKeyVisitModeLabel    = 17, /// 访客模式文案
};

typedef NSString * CatLoginContentStringKey NS_TYPED_ENUM;

UIKIT_EXTERN CatLoginContentStringKey const CatLoginContentAccountString;
UIKIT_EXTERN CatLoginContentStringKey const CatLoginContentPwdString;
UIKIT_EXTERN CatLoginContentStringKey const CatLoginContentSmsString;
    
typedef NS_ENUM(NSInteger,CatLoginType) {
    CatLoginTypeDefault,
    CatLoginTypeLikefreely,
    CatLoginTypeKK,     /// KK风格
    CatLoginTypeDoctor, /// 医疗
    CatLoginTypeCustom,
};


typedef NS_OPTIONS(NSInteger,CatLoginOption) {
    CatLoginOptionNone               = 1 << 0,
    CatLoginOptionFloatLabel         = 1 << 1, /// TextField 上方含有描述文字 (CatLoginTypeDefault)
    CatLoginOptionTextFieldLargeText = 1 << 2, /// TextField 文字更大 (CatLoginTypeLikefreely)
    CatLoginOptionCornerButton       = 1 << 3, /// 圆角按钮 (CatLoginTypeLikefreely)
    CatLoginOptionVisitMode          = 1 << 4, /// 支持游客模式 - 出现暂不登录,随便看看(CatLoginTypeKK)
    CatLoginOptionSecuritySubmit     = 1 << 5, /// 数据不合法时提交按钮不可用
    CatLoginOptionLoginHistory       = 1 << 6, /// 有登录历史记录
};

@protocol CatLoginControllerDelegate <NSObject>

/**
 登录

 @param controller CatLoginController对象
 @param content 输入内容
 @param sender 登录按钮
 
 @note
    账号密码登录
 CatLoginContentAccountString
 CatLoginContentPwdString
 
    短信验证码登录
 CatLoginContentAccountString
 CatLoginContentSmsString
 */
- (void)catLoginController:(CatLoginController *)controller
                   content:(NSDictionary <CatLoginContentStringKey,NSString *>*)content
          commitWithSender:(UIButton *)sender;

@optional

/**
 触发时机:
 1. 点击返回按钮
 2. 获得登录/第三发登录成功时的通知
 3. 暂不登录，随便看看
 
 @note 若代理对象未实现该方法,则尝试自动关闭登录页面
 
 @param controller controller CatLoginController对象
 */
- (void)catLoginControllerDismiss:(CatLoginController *)controller;

/**
 检查输入内容是否合法

 @param controller CatLoginController对象
 @param content 输入内容
 @return 是否正确 正确则登录按钮可用
 @note 若不实现该方法 则为不限制输入内容
 */
- (BOOL)catLoginController:(CatLoginController *)controller
           validateContent:(NSDictionary <CatLoginContentStringKey,NSString *>*)content;

/**
 第三方登录

 @param controller CatLoginController对象
 @param index 点击的索引
 */
- (void)catLoginController:(CatLoginController *)controller
            didSelectIndex:(NSInteger)index;

/**
 点击获得验证码

 @param controller CatLoginController对象
 @params content 输入内容
 @param sender 倒计时按钮对象
 */
- (BOOL)catLoginController:(CatLoginController *)controller
                   content:(NSDictionary <CatLoginContentStringKey,NSString *>*)content
             smsWithSender:(CatLoginCountButton *)sender;

- (void)catLoginController:(CatLoginController *)controller
                   content:(NSDictionary <CatLoginContentStringKey,NSString *>*)content
        smsDelayWithSender:(CatLoginCountButton *)sender;

@end

@protocol CatLoginGuideDelegate <NSObject>

@optional
/**
 跳转到登录遇到问题页面
 
 @param controller CatLoginController对象
 */
- (void)catLoginControllerJump2LoginTrouble:(CatLoginController *)controller;

/**
 跳转到忘记密码页面
 
 @param controller CatLoginController对象
 */
- (void)catLoginControllerJump2ForgetPwd:(CatLoginController *)controller;

/**
 跳转到注册页面
 
 @param controller CatLoginController对象
 */
- (void)catLoginContorllerJump2Register:(CatLoginController *)controller;

/**
 跳转到服务协议页面
 
 @param controller CatLoginController对象
 */
- (void)catLoginControllerJump2ServiceProtocol:(CatLoginController *)controller;

@end

@interface CatLoginController : UIViewController

@property (nonatomic,readonly) CatLoginType type;
/// 额外的选项
@property (nonatomic,assign)   CatLoginOption extraOption;

@property (nonatomic,readonly) UIScrollView   *scrollView;

@property (nonatomic,readonly) UIImageView    *backImageView;
@property (nonatomic,readonly) UILabel        *helpLabel;

@property (nonatomic,readonly) UIImageView    *greetImageView;
@property (nonatomic,readonly) UILabel        *greetLabel;
@property (nonatomic,readonly) UILabel        *greetMoreLabel;
@property (nonatomic,readonly) UIButton       *greetRegButton;

@property (nonatomic,readonly) UITextField    *accountField;
@property (nonatomic,readonly) UITextField    *pwdField;
@property (nonatomic,readonly) UITextField    *smsField;
@property (nonatomic,readonly) UIButton       *forgetButton;
@property (nonatomic,readonly) UIButton       *regButton;
@property (nonatomic,readonly) UIButton       *submitButton;
@property (nonatomic,readonly) UILabel        *protocolLabel;
@property (nonatomic,readonly) UIButton       *protocolButton;

@property (nonatomic,copy) NSArray<UIImage *> *thirdPartyImages;

@property (nonatomic,weak) id<CatLoginControllerDelegate> delegate;
@property (nonatomic,weak) id<CatLoginGuideDelegate>      guideDelegate;

/**
 创建一个登录视图控制器对象
 
 @param type 样式
 @return 登录控制器视图对象
 */
+ (instancetype)controllerWithType:(CatLoginType)type;

/// 展示登陆控制器
- (void)presentFromRootViewController:(UIViewController *)rootViewController;

@end

UIKIT_EXTERN NSNotificationName const CatLoginSuccessNotification;

@interface UIButton (CatUI)

- (void)ui_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

@end

NS_ASSUME_NONNULL_END
