//
//  CatLoginController.m
//  UITemplateLib
//
//  Created by ml on 2019/5/16.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CatLoginController.h"
#import "ccs.h"

#import "CatLoginFieldView.h"

#import "CatLoginSmsTextField.h"
#import "CatLoginCountButton.h"

#import "CatLoginPwdTextField.h"

#import "CatSideView.h"
#import "UITextField+CCUI.h"

CatLoginContentStringKey const CatLoginContentAccountString = @"CatLoginContentAccountString";
CatLoginContentStringKey const CatLoginContentPwdString = @"CatLoginContentPwdString";
CatLoginContentStringKey const CatLoginContentSmsString = @"CatLoginContentSmsString";

NSNotificationName const CatLoginSuccessNotification = @"CatLoginSuccessNotification";

NSString * const CatLoginContainerGreet = @"CatLoginContainerGreet";
NSString * const CatLoginContainerContent = @"CatLoginContainerContent";
NSString * const CatLoginContainerThirdParty = @"CatLoginContainerThirdParty";

NSString * const CatLoginAccountList = @"cat_login_history_accounts";

@interface CatLoginController ()  <UITextFieldDelegate,CatLoginSmsTextFieldDeleagte,UITableViewDataSource,UITableViewDelegate> {
    UIButton *_backButton;
    UIButton *_loginTroubleButton;
    
    UIImageView *_greetImageView;
    UILabel *_greetLabel;
    UILabel *_greetMoreLabel;
    
    CatLoginFieldView *_accountView;
    CatLoginFieldView *_pwdView;
    CatLoginFieldView *_smsView;
    UIButton *_forgetButton;
    UILabel *_protocolLabel;
    UIButton *_protocolButton;
    UIButton *_submitButton;
    
    UIView *_thirdPartyContainerView;
    NSMutableArray *_thirdPartyButtonViews;
    
    UIView *_visitModeView;
    UIButton *_visitModeButton;
    
    UIColor *_originNavigationColor;
    
    NSDictionary *_infoDictionary;
    
    /// 成功登录历史视图
    UITableView *_loginHistoryView;
}

@property (nonatomic,assign) CatLoginType type;
@property (nonatomic,assign) CatLoginOption option;

- (nullable NSArray *)searchWithKeyword:(NSString *)keyword;
@end

@implementation CatLoginController

// MARK: - Public API -
+ (instancetype)controllerWithType:(CatLoginType)type {
    CatLoginController *controller = [CatLoginController new];
    controller.type = type;
    
    [controller setupUI];
    [controller setupNotifications];
    return controller;
}

- (void)presentFromRootViewController:(UIViewController *)rootViewController {
    if(self.navigationController) {
        self.navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
        [rootViewController presentViewController:self.navigationController animated:YES completion:nil];
    }else {
        UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:self];
        navC.modalPresentationStyle = UIModalPresentationFullScreen;
        [rootViewController presentViewController:navC animated:YES completion:nil];
    }
}

- (void)setupUI {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, WIDTH(), HEIGHT() - STATUS_AND_NAV_BAR_HEIGHT)];
    _scrollView.showsVerticalScrollIndicator = NO;
    
    NSArray *existUIElements = [self setupExistedUI];
    
    CGFloat maxY = 0;
    UIView *lastView = nil;
    for (int i = 0; i < existUIElements.count; ++i) {
        switch ([existUIElements[i] intValue]) {
            case CatLoginEnableKeyBackImage: {
                if (!_backButton) {
                    _backButton = UIButton.new;
                    [_backButton setImage:imageResouceWithName(@"login_back@2x.png") forState:UIControlStateNormal];
                    [_backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
                }
            }
                break;
            case CatLoginEnableKeyHelpLabel : {
                NSString *troubleString = @"登录遇到问题?";
                if (!_loginTroubleButton) {
                    _loginTroubleButton = UIButton.new;
                    _loginTroubleButton.titleLabel.font = [ccs appStandard:CONTENT_FONT];
                    [_loginTroubleButton setTitleColor:[ccs appStandard:CONTENT_COLOR] forState:UIControlStateNormal];
                    [_loginTroubleButton sizeToFit];
                    [_loginTroubleButton addTarget:self action:@selector(loginTroubleAction:) forControlEvents:UIControlEventTouchUpInside];
                }
                
                [_loginTroubleButton setTitle:troubleString forState:UIControlStateNormal];
            }
                break;
            case CatLoginEnableKeyGreetImage: {
                if (!self.greetImageView) {
                    _greetImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, RH(100), RH(100))];
                    _greetImageView.contentMode = UIViewContentModeScaleAspectFit;
                    _greetImageView.image = imageResouceWithName(@"login_welcome@2x.png");
                }
                
                lastView = _greetImageView;
                
                lastView.left = RH(25);
                lastView.top = maxY;
                maxY = CGRectGetMaxY(lastView.frame);
            }
                break;
            case CatLoginEnableKeyGreetLabel: {
                [self createGreetLabel];
                CGFloat margin = _greetImageView.image ? RH(10) : RH(20);
                lastView = _greetLabel;
                lastView.left = RH(25);
                lastView.top = maxY + margin;
                maxY = CGRectGetMaxY(lastView.frame);
            }
                break;
            case CatLoginEnableKeyGreetMoreLabel: {
                [self createGreetMoreLabel];
                CGFloat margin = _greetLabel.text.length > 0 ? RH(10) : 0;
                
                lastView = _greetMoreLabel;
                lastView.left = RH(25);
                lastView.top = maxY + margin;
                maxY = CGRectGetMaxY(lastView.frame);
            }
                break;
            case CatLoginEnableKeyGreetRegButton: {
                if (!_greetRegButton) {
                    _greetRegButton = [self registerButtonWithTitle:@"注册"
                                                          textColor:[ccs appStandard:TITLE_COLOR]];
                }
                
                lastView = _greetRegButton;
                lastView.centerY = _greetMoreLabel.centerY;
                lastView.left = CGRectGetMaxX(_greetMoreLabel.frame) + 2;
                
                maxY = MAX(CGRectGetMaxY(lastView.frame), CGRectGetMaxY(_greetMoreLabel.frame));

            }
                break;
            case CatLoginEnableKeyAccountField: {
                [self createAccountField];
                CGFloat margin = _greetMoreLabel ? RH(20) : RH(40);
                
                lastView = _accountView;
                lastView.top = maxY + margin;
                maxY = CGRectGetMaxY(lastView.frame);
            }
                break;
            case CatLoginEnableKeyPwdField: {
                [self createPwdField];
                lastView = _pwdView;
                lastView.top = maxY + RH(10);
                maxY = CGRectGetMaxY(lastView.frame);
            }
                break;
            case CatLoginEnableKeySmsField: {
                [self createSmsField];
                lastView = _smsView;
                lastView.top = maxY + RH(10);
                
                maxY = CGRectGetMaxY(lastView.frame);
            }
                break;
            case CatLoginEnableKeyForgetButton : {
                if (!_forgetButton) {
                    _forgetButton = UIButton.new;
                    _forgetButton.titleLabel.font = [ccs appStandard:CONTENT_FONT];
                    [_forgetButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
                    [_forgetButton setTitleColor:[ccs appStandard:CONTENT_COLOR] forState:UIControlStateNormal];
                    [_forgetButton sizeToFit];
                    [_forgetButton addTarget:self action:@selector(forgetAction:) forControlEvents:UIControlEventTouchUpInside];
                }
                
                lastView = _forgetButton;
                lastView.left = ({
                    (self.type == CatLoginTypeDefault || self.type == CatLoginTypeKK) ? WIDTH() - _forgetButton.width - RH(25) :
                    RH(25);
                });
                
                if (_regButton) {
                    lastView.centerY = _regButton.centerY;
                }else {
                    lastView.top = maxY + RH(12);
                }
                
                maxY = CGRectGetMaxY(lastView.frame);
            }
                break;
            case CatLoginEnableKeyRegButton : {
                [self createRegButton];
                lastView = _regButton;
                
                lastView.left = ({
                    (self.type == CatLoginTypeKK) ? RH(25) :
                    (self.type == CatLoginTypeLikefreely) ? WIDTH() - _regButton.width - RH(25) :
                    RH(25);
                });
                
                if (_forgetButton) {
                    lastView.centerY = _forgetButton.centerY;
                }else {
                    lastView.top = maxY + RH(12);
                }
                
                maxY = CGRectGetMaxY(lastView.frame);
            }
                break;
            case CatLoginEnableKeyProtocolLabel : {
                if (!_protocolLabel) {
                    _protocolLabel = UILabel.new;
                    _protocolLabel.text = @"注册登录即表示你同意";
                    _protocolLabel.font = RF(12);
                    _protocolLabel.textColor = UIColor.lightGrayColor;
                    [_protocolLabel sizeToFit];
                }
                
                lastView = _protocolLabel;
                lastView.left = RH(25);
                lastView.top = maxY + RH(16);
                
                maxY = CGRectGetMaxY(lastView.frame) + RH(16);
            }
                break;
            case CatLoginEnableKeyProtocolButton : {
                if (!_protocolButton) {
                    _protocolButton = UIButton.new;
                    _protocolButton.titleLabel.font = RF(12);
                    [_protocolButton setTitle:@"《服务协议》" forState:UIControlStateNormal];
                    [_protocolButton setTitleColor:[ccs appStandard:MASTER_COLOR] forState:UIControlStateNormal];
                    [_protocolButton addTarget:self action:@selector(protocolAction:) forControlEvents:UIControlEventTouchUpInside];
                    [_protocolButton sizeToFit];
                }
                
                lastView = _protocolButton;
                lastView.left = _protocolLabel.right;
                lastView.centerY = _protocolLabel.centerY;
                
                maxY = MAX(CGRectGetMaxY(lastView.frame), CGRectGetMaxY(_protocolLabel.frame));
                
            }
                break;
            case CatLoginEnableKeyRoleView : {
                UIView *roleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(), 30)];
                
                UIImageView *imageView = [[UIImageView alloc] initWithImage:imageResouceWithName(@"check")];
                imageView.frame = CGRectMake(0, 0, 26, 26);
                [roleView addSubview:imageView];
                
                UILabel *roleLabel = UILabel.new;
                roleLabel.text = @"使用默认角色登录";
                roleLabel.font = RF(13);
                roleLabel.textColor = [ccs appStandard:CONTENT_COLOR];
                [roleLabel sizeToFit];
                
                [roleView addSubview:roleLabel];
                
                lastView = roleLabel;
                lastView.left = 30;
                lastView.centerY = imageView.centerY;
                
                lastView = roleView;
                lastView.left = RH(25);
                lastView.top = maxY + RH(20);
                
                maxY = CGRectGetMaxY(lastView.frame);
            }
                break;
            case CatLoginEnableKeySubmitButton : {
                [self createSubmitButton];
                lastView = _submitButton;
                
                lastView.top = ({
                    (self.type == CatLoginTypeDefault    || self.type == CatLoginTypeKK)     ? maxY + RH(20) :
                    (self.type == CatLoginTypeLikefreely || self.type == CatLoginTypeDoctor) ? maxY + RH(40) :
                    maxY + RH(20);
                });
                lastView.centerX = _scrollView.centerX;
                
                maxY = CGRectGetMaxY(lastView.frame);
            }
                break;
            case CatLoginEnableKeyBottomRegLabel : {
                [self createBottomLabel];
                lastView = _regButton;
                lastView.left = (WIDTH() - _regButton.width) * 0.5;
                lastView.top = _scrollView.height - RH(40) - RH(20);
                
                maxY = CGRectGetMaxY(lastView.frame);
            }
                break;
            case CatLoginEnableKeyThirdPartyView : {
                [self createThirdPartyView];
                if (self.thirdPartyImages.count > 0) {
                    lastView = _thirdPartyContainerView;
                    lastView.top = maxY;
                    
                    maxY = CGRectGetMaxY(lastView.frame);
                }
            }
                break;
            case CatLoginEnableKeyVisitModeLabel : {
                [self createVisitModelLabel];
                lastView = _visitModeButton;
                lastView.left = (WIDTH() - _visitModeButton.size.width) * 0.5;
                
                lastView = _visitModeView;
                lastView.top = _scrollView.height - RH(40) - RH(20);
                
                maxY = CGRectGetMaxY(lastView.frame);
            }
                break;
            default:
                break;
        }
        
        [self.scrollView addSubview:lastView];
    }
}

- (void)createGreetMoreLabel {
    NSString *appName = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleDisplayName"];
    NSString *greetMoreString = ({
        self.type == CatLoginTypeDefault    ? @"登陆后继续浏览" :
        self.type == CatLoginTypeLikefreely ? [NSString stringWithFormat:@"欢迎来到%@,立即",appName] :
        self.type == CatLoginTypeKK         ? @"欢迎登录" : @"";
    });
    
    NSDictionary *attrDic = @{NSFontAttributeName:[ccs appStandard:CONTENT_FONT],
                              NSForegroundColorAttributeName:[ccs appStandard:CONTENT_COLOR]};
    
    NSAttributedString *greetMoreAttrString = [[NSAttributedString alloc] initWithString:greetMoreString
                                                                              attributes:attrDic];
    
    if (!_greetMoreLabel) {
        _greetMoreLabel = UILabel.new;
        _greetMoreLabel.attributedText = greetMoreAttrString;
    }
    
    [_greetMoreLabel sizeToFit];
}

- (void)createSmsField {
    if (!_smsView) {
        _smsView = [[CatLoginFieldView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(), RH(50))];
        CatLoginSmsTextField *td = CatLoginSmsTextField.new;
        td.smsDelegate = self;
        td.rightViewMode = UITextFieldViewModeAlways;
        [td.countButton setTitleColor:[ccs appStandard:MASTER_COLOR] forState:UIControlStateNormal];
        [td.countButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        _smsView.textField = _smsField = td;
        [_smsField addTarget:self action:@selector(singleLineEditingChangedAction:) forControlEvents:UIControlEventEditingChanged];
    }
    
    NSString *smsString = @"验证码";
    
    if (self.option & CatLoginOptionFloatLabel) {
        _smsView.floatLabel.text = smsString;
        _smsView.height = RH(70);
    }
    
    _smsField.placeholder = [NSString stringWithFormat:@"输入您的%@",smsString];
    _smsField.delegate = self;
    _smsField.keyboardType = UIKeyboardTypeNumberPad;
    
    if (self.option & CatLoginOptionTextFieldLargeText) {
        _smsField.font = [ccs appStandard:TITLE_FONT];
    }else {
        _smsField.font = [ccs appStandard:CONTENT_FONT];
    }
    
    [_smsView addSubview:_smsField];
}

- (NSArray *)searchWithKeyword:(NSString *)keyword {
    NSUserDefaults *uf =  [[NSUserDefaults alloc] initWithSuiteName:@"CAT"];
    NSArray *keyWords = [uf objectForKey:CatLoginAccountList];
    
    NSMutableArray *keyWordsM = [NSMutableArray array];
    [keyWords enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj hasPrefix:keyword]) {
            [keyWordsM addObject:obj];
        }
    }];
    
    return keyWordsM.copy;
}

- (void)createPwdField {
    if (!_pwdView) {
        _pwdView = [[CatLoginFieldView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(), RH(50))];
        _pwdView.textField = CatLoginPwdTextField.new;
        _pwdView.textField.secureTextEntry = YES;
        _pwdField = _pwdView.textField;
        [_pwdField addTarget:self action:@selector(singleLineEditingChangedAction:) forControlEvents:UIControlEventEditingChanged];
    }
    
    NSString *pwdString = @"密码";
    
    if (self.option & CatLoginOptionFloatLabel) {
        _pwdView.floatLabel.text = pwdString;
        _pwdView.height = RH(70);
    }
    
    _pwdView.textField.placeholder = [NSString stringWithFormat:@"输入您的%@",pwdString];
    if (self.option & CatLoginOptionTextFieldLargeText) {
        _pwdView.textField.font = [ccs appStandard:TITLE_FONT];
    }else {
        _pwdView.textField.font = [ccs appStandard:CONTENT_FONT];
    }
    [_pwdView addSubview:_pwdView.textField];
}

- (void)createAccountField {
    if (!_accountView) {
        _accountView = [[CatLoginFieldView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(), RH(50))];
        _accountView.textField = UITextField.new;
        _accountField = _accountView.textField;
        _accountField.delegate = self;
        [_accountField addTarget:self action:@selector(singleLineEditingChangedAction:) forControlEvents:UIControlEventEditingChanged];
        _accountField.keyboardType = UIKeyboardTypePhonePad;
        _accountField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    
    NSString *accountString = ({
        self.type == CatLoginTypeDefault    ? @"邮箱" :
        self.type == CatLoginTypeLikefreely ? @"用户名/手机号/邮箱" :
        self.type == CatLoginTypeKK         ? @"手机号" :
        self.type == CatLoginTypeDoctor     ? @"手机号" :
        @"";
    });
    
    if (self.option & CatLoginOptionFloatLabel) {
        _accountView.floatLabel.text = accountString;
        _accountView.height = RH(70);
    }
    
    _accountField.placeholder = [NSString stringWithFormat:@"输入您的%@",accountString];
    if (self.option & CatLoginOptionTextFieldLargeText) {
        _accountField.font = [ccs appStandard:TITLE_FONT];
    }else {
        _accountField.font = [ccs appStandard:CONTENT_FONT];
    }
    [_accountView addSubview:_accountField];
    
    
}

- (void)createRegButton {
    NSString *title = ({
        (self.type == CatLoginTypeLikefreely) ? @"手机注册" :
        (self.type == CatLoginTypeKK) ? @"注册" :
        @"注册";
    });
    
    _regButton = [self registerButtonWithTitle:title
                                     textColor:[ccs appStandard:CONTENT_COLOR]];
    
    _regButton.titleLabel.font = [ccs appStandard:CONTENT_FONT];
}

- (void)createGreetLabel {
    if (!self.greetLabel) {
        _greetLabel = UILabel.new;
        _greetLabel.textColor = [ccs appStandard:HEADLINE_COLOR];
    }
    
    _greetLabel.text = ({
        self.type == CatLoginTypeDefault    ? @"欢迎回来" :
        self.type == CatLoginTypeKK         ? @"KK系平台统一账户" :
        self.type == CatLoginTypeDoctor     ? @"欢迎登录" :
        self.type == CatLoginTypeLikefreely ? @"您好" : @"";
    });
    
    _greetLabel.font = ({
        self.type == CatLoginTypeKK         ? [UIFont boldSystemFontOfSize:23] :
        self.type == CatLoginTypeDoctor     ? [UIFont boldSystemFontOfSize:23] : [ccs appStandard:HEADLINE_FONT];
    });
    
    [_greetLabel sizeToFit];
}

- (void)createSubmitButton {
    if (!_submitButton) {
        _submitButton = UIButton.new;
        _submitButton.titleLabel.font = [ccs appStandard:CONTENT_FONT];
        [_submitButton setTitle:@"登录" forState:UIControlStateNormal];
        [_submitButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _submitButton.width = WIDTH() - RH(25) * 2;
        _submitButton.height = RH(43) > 43 ? 43 : RH(40);
        
        [_submitButton addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
        [_submitButton ui_setBackgroundColor:[ccs appStandard:MASTER_COLOR] forState:UIControlStateNormal];
    }
    
    if (self.option & CatLoginOptionCornerButton) {
        _submitButton.layer.cornerRadius = 5;
        _submitButton.layer.masksToBounds = YES;
    }
    
    if (self.option & CatLoginOptionSecuritySubmit) {
        [_submitButton ui_setBackgroundColor:[ccs appStandard:DATE_COLOR] forState:UIControlStateDisabled];
        _submitButton.enabled = NO;
    }
}

- (void)createBottomLabel {
    NSMutableAttributedString *attrS = [[NSMutableAttributedString alloc] initWithString:@"新用户?注册" attributes:@{
                                                                                                                NSFontAttributeName:[ccs appStandard:CONTENT_FONT],
                                                                                                                NSForegroundColorAttributeName:[ccs appStandard:CONTENT_COLOR]
                                                                                                                }];
    NSRange range = [attrS.string rangeOfString:@"注册"];
    [attrS addAttribute:NSForegroundColorAttributeName value:[ccs appStandard:TITLE_COLOR] range:range];
    
    if (!_regButton) {
        _regButton = UIButton.new;
        [_regButton setAttributedTitle:attrS forState:UIControlStateNormal];
        [_regButton addTarget:self
                       action:@selector(registerAction:)
             forControlEvents:UIControlEventTouchUpInside];
        [_regButton sizeToFit];
    }
}

- (void)createThirdPartyView {
    if (_thirdPartyImages.count > 0) {
        if (!_thirdPartyContainerView) {
            _thirdPartyContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(), RH(100))];
        }
        
        [_thirdPartyContainerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        
        UILabel *tpLabel = UILabel.new;
        tpLabel.text = @"第三方登录";
        tpLabel.textColor = [ccs appStandard:CONTENT_COLOR];
        [tpLabel sizeToFit];
        
        for (int i = 0 ; i < self.thirdPartyImages.count; ++i) {
            UIImage *image = self.thirdPartyImages[i];
            UIButton *btn = UIButton.new;
            btn.frame = CGRectMake(0, 0, 60, 60);
            [btn setImage:image forState:UIControlStateNormal];
            btn.contentMode = UIViewContentModeScaleAspectFit;
            [btn addTarget:self action:@selector(thirdPartyAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = i;
            
            CGFloat inter = (WIDTH() - 2 * RH(25) - self.thirdPartyImages.count * CGRectGetWidth(btn.frame)) / (self.thirdPartyImages.count - 1);
            btn.left = RH(25) + (inter + CGRectGetWidth(btn.frame) ) * i;
            btn.top = RH(30);
            [_thirdPartyContainerView addSubview:btn];
        }
    }
}

- (void)createVisitModelLabel {
    if (self.option & CatLoginOptionVisitMode) {
        if (!_visitModeView) {
            _visitModeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(), RH(40))];
            if (!_visitModeButton) {
                _visitModeButton = UIButton.new;
                _visitModeButton.titleLabel.font = RF(14);
                [_visitModeButton setTitle:@"暂不登录,随便看看" forState:UIControlStateNormal];
                [_visitModeButton setTitleColor:[ccs appStandard:CONTENT_COLOR] forState:UIControlStateNormal];
                [_visitModeButton sizeToFit];
                [_visitModeButton addTarget:self action:@selector(clickVisitModeAction:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
        [_visitModeView addSubview:_visitModeButton];
    }
}

- (NSArray *)setupExistedUI {
    NSArray *existUIElements = nil;
    switch (self.type) {
        case CatLoginTypeDefault: {
            existUIElements = @[
                                @(CatLoginEnableKeyGreetImage),
                                @(CatLoginEnableKeyGreetLabel),
                                @(CatLoginEnableKeyGreetMoreLabel),
                                @(CatLoginEnableKeyAccountField),
                                @(CatLoginEnableKeyPwdField),
                                @(CatLoginEnableKeyForgetButton),
                                @(CatLoginEnableKeySubmitButton),
                                @(CatLoginEnableKeyBottomRegLabel)];
            
            _option = CatLoginOptionFloatLabel;
        }
            break;
        case CatLoginTypeLikefreely: {
            existUIElements = @[@(CatLoginEnableKeyBackImage),
                                @(CatLoginEnableKeyHelpLabel),
                                @(CatLoginEnableKeyGreetLabel),
                                @(CatLoginEnableKeyGreetMoreLabel),
                                @(CatLoginEnableKeyGreetRegButton),
                                @(CatLoginEnableKeyAccountField),
                                @(CatLoginEnableKeyPwdField),
                                @(CatLoginEnableKeyForgetButton),
                                @(CatLoginEnableKeyRegButton),
                                @(CatLoginEnableKeySubmitButton)];
            
            _option = CatLoginOptionCornerButton | CatLoginOptionTextFieldLargeText;
        }
            break;
        case CatLoginTypeKK: {
            existUIElements = @[@(CatLoginEnableKeyGreetLabel),
                                @(CatLoginEnableKeyGreetMoreLabel),
                                @(CatLoginEnableKeyAccountField),
                                @(CatLoginEnableKeyPwdField),
                                @(CatLoginEnableKeyRoleView),
                                @(CatLoginEnableKeySubmitButton),
                                @(CatLoginEnableKeyRegButton),
                                @(CatLoginEnableKeyForgetButton),
                                @(CatLoginEnableKeyVisitModeLabel)];
            
            _option = CatLoginOptionFloatLabel | CatLoginOptionVisitMode;
            
        }
            break;
        case CatLoginTypeDoctor : {
            
            existUIElements = @[@(CatLoginEnableKeyGreetLabel),
                                @(CatLoginEnableKeyAccountField),
                                @(CatLoginEnableKeySmsField),
                                @(CatLoginEnableKeyProtocolLabel),
                                @(CatLoginEnableKeyProtocolButton),
                                @(CatLoginEnableKeySubmitButton)
                                ];
            
            _option = CatLoginOptionFloatLabel | CatLoginOptionCornerButton | CatLoginOptionSecuritySubmit;
            
        }
            break;
            
        default:
            break;
    }
    
    _option = _option | _extraOption;
    
    return existUIElements;
}


- (void)setupNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginSuccessAction:)
                                                 name:CatLoginSuccessNotification
                                               object:nil];
}

- (UIButton *)registerButtonWithTitle:(NSString *)title textColor:(UIColor *)color {
    UIButton *b = UIButton.new;
    [b setTitle:title forState:UIControlStateNormal];
    [b setTitleColor:color forState:UIControlStateNormal];
    [b sizeToFit];
    [b addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    return b;
}

// MARK: - LifeCycle -

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboardAction:)];
    [self.view addGestureRecognizer:tap];
    
    [self.view addSubview:_scrollView];
    if (_backButton) {
        if (self.navigationController) {
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
        }
    }
    
    if (_loginTroubleButton) {
        if (self.navigationController) {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_loginTroubleButton];
        }
    }
    
    if (@available(iOS 11.0, *)) {
        _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self _fixup:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self _fixup:YES];
}

- (void)dealloc {
#if DEBUG
    NSLog(@"%s",__func__);
#endif
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// MARK: - UITextFieldDelegate -
- (void)singleLineEditingChangedAction:(UITextField *)sender {
    NSMutableDictionary *infoM = [NSMutableDictionary dictionary];
    
    [infoM cc_setKey:CatLoginContentAccountString value:_accountField.text];
    [infoM cc_setKey:CatLoginContentPwdString value:_pwdField.text];
    [infoM cc_setKey:CatLoginContentSmsString value:_smsField.text];
    
    if ([sender isEqual:_accountField]) {
        [_accountField cc_cutWithMaxLength:11];
    }
    
    if ([sender isEqual:_smsField]) {
        [_smsField cc_cutWithMaxLength:6];
    }
    
    if (self.option & CatLoginOptionLoginHistory) {
        if ([sender isEqual:_accountField]) {
            /// 查询是否有满足要求的历史登录成功记录
            if([self searchWithKeyword:sender.text]) {
                if(!_loginHistoryView) {
                    _loginHistoryView = [[UITableView alloc] initWithFrame:CGRectMake(sender.left, 0, sender.width, 88) style:0];
                    _loginHistoryView.dataSource = self;
                    _loginHistoryView.delegate = self;
                    _loginHistoryView.rowHeight = 44;
                    _loginHistoryView.layer.borderColor = UIColor.groupTableViewBackgroundColor.CGColor;
                    _loginHistoryView.layer.borderWidth = 1;
                    _loginHistoryView.separatorStyle = UITableViewCellSeparatorStyleNone;
                }
                            
                CatSideView *sv = _loginHistoryView.cc_sideView;
                sv.animated = NO;
                sv.option = CatSideViewBehaviorOptionNoneCoverView;
                
                CGPoint point = [sender.superview convertPoint:CGPointMake(sender.left, sender.bottom) toView:self.view];
                sv.deltaOffset = CGPointMake(0, point.y);
                
                [sv showWithDirection:CatSideViewDirectionTop];
                
                [_loginHistoryView reloadData];
            }else {
                [_loginHistoryView.cc_sideView dismissViewAnimated:NO];
            }
            
            if (sender.text.length == 0 || sender.text.length == 11) {
                [_loginHistoryView.cc_sideView dismissViewAnimated:NO];
            }
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(catLoginController:validateContent:)]) {
        BOOL rs = [self.delegate catLoginController:self validateContent:infoM.copy];
        if (rs) {
            _submitButton.enabled = YES;
        }else {
            _submitButton.enabled = NO;
        }
    }else {
        BOOL rs = YES;
        
        if (self.option & CatLoginOptionSecuritySubmit) {
            if ([ccs function_isEmpty:[infoM objectForKey:CatLoginContentAccountString]]) {
                rs = NO;
            }
            
            if (_pwdField) {
                if ([ccs function_isEmpty:[infoM objectForKey:CatLoginContentPwdString]]) {
                    rs = NO;
                }
            }else if (_smsField) {
                if ([ccs function_isEmpty:[infoM objectForKey:CatLoginContentSmsString]]) {
                    rs = NO;
                }
            }
            
            if (rs) {
                _submitButton.enabled = YES;
            }else {
                _submitButton.enabled = NO;
            }
        }else {
            _submitButton.enabled = YES;
        }
    }
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    NSMutableDictionary *infoM = [NSMutableDictionary dictionary];
//    if (![ccs function_isEmpty:_accountField]) {
//        [infoM setObject:_accountField.text forKey:CatLoginContentAccountString];
//    }
//
//    if (![ccs function_isEmpty:_pwdField]) {
//        [infoM setObject:_pwdField.text forKey:CatLoginContentPwdString];
//    }
//
//    if (![ccs function_isEmpty:_smsField]) {
//        [infoM setObject:_smsField.text forKey:CatLoginContentSmsString];
//    }
//
//    _infoDictionary = infoM.copy;
//    NSMutableDictionary *infoDictionary = [NSMutableDictionary dictionaryWithDictionary:_infoDictionary];
//    if (_accountField == textField) {
//        NSString *currentString = [self _textField:textField range:range string:string];
//        [infoDictionary safeSetObject:currentString forKey:CatLoginContentAccountString];
//    }else if (_pwdField == textField) {
//        NSString *currentString = [self _textField:textField range:range string:string];
//        [infoDictionary safeSetObject:currentString forKey:CatLoginContentPwdString];
//    }else {
//        NSString *currentString = [self _textField:textField range:range string:string];
//        [infoDictionary safeSetObject:currentString forKey:CatLoginContentSmsString];
//    }
//
//    if ([self.delegate respondsToSelector:@selector(catLoginController:validateContent:)]) {
//        BOOL rs = [self.delegate catLoginController:self validateContent:infoDictionary];
//        if (rs) {
//            _submitButton.enabled = YES;
//        }else {
//            _submitButton.enabled = NO;
//        }
//    }else {
//        BOOL rs = YES;
//        if ([ccs function_isEmpty:[infoDictionary objectForKey:CatLoginContentAccountString]]) {
//            rs = NO;
//        }
//        if (self.method == CatLoginMethdPwd) {
//            if ([ccs function_isEmpty:[infoDictionary objectForKey:CatLoginContentPwdString]]) {
//                rs = NO;
//            }
//        }else if (self.method == CatLoginMethodSms) {
//            if ([ccs function_isEmpty:[infoDictionary objectForKey:CatLoginContentSmsString]]) {
//                rs = NO;
//            }
//        }
//        if (rs) {
//            _submitButton.enabled = YES;
//        }else {
//            _submitButton.enabled = NO;
//        }
//    }
//
//    _infoDictionary = infoDictionary.copy;
//    return YES;
//}
//
//- (NSString *)_textField:(UITextField *)textField range:(NSRange)range string:(NSString *)string {
//    NSMutableString *currentString = nil;
//    if (string.length) {
//        currentString = [NSMutableString stringWithString:textField.text];
//        [currentString insertString:string atIndex:range.location];
//
//        // 处理密码键盘的特殊情况
//        if (textField.secureTextEntry == YES) {
//            currentString = [NSMutableString stringWithString:string];
//        }
//    }else {
//        if (textField.text.length >= 1) {
//            currentString = [NSMutableString stringWithString:textField.text];
//            [currentString deleteCharactersInRange:range];
//        }
//
//        // 处理密码键盘的特殊情况
//        if (textField.secureTextEntry == YES) {
//            currentString = [NSMutableString stringWithFormat:@""];
//        }
//    }
//    return currentString.copy;
//}

// MARK: - UITableView -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self searchWithKeyword:_accountField.text].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cat_login_cell"];
    NSString *account = [self searchWithKeyword:_accountField.text][indexPath.row];
    cell.textLabel.text = account;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *accounts = [self searchWithKeyword:_accountField.text];
    if (accounts.count > indexPath.row) {
        NSString *account = [self searchWithKeyword:_accountField.text][indexPath.row];
        _accountField.text = account;
        [tableView.cc_sideView dismissViewAnimated:NO];
    }
}

// MARK: - Actions -
- (void)protocolAction:(UIButton *)sender {
    if ([self.guideDelegate respondsToSelector:@selector(catLoginControllerJump2ServiceProtocol:)]) {
        [self.guideDelegate catLoginControllerJump2ServiceProtocol:self];
    }
}

- (void)loginTroubleAction:(UIButton *)sender {
    if([self.guideDelegate respondsToSelector:@selector(catLoginControllerJump2LoginTrouble:)]) {
        [self.guideDelegate catLoginControllerJump2LoginTrouble:self];
    }
}

- (void)backAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(catLoginControllerDismiss:)]) {
        [self.delegate catLoginControllerDismiss:self];
    }
}

- (void)thirdPartyAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(catLoginController:didSelectIndex:)]) {
        [self.delegate catLoginController:self didSelectIndex:sender.tag];
    }
}

- (void)registerAction:(UIButton *)sender {
    if ([self.guideDelegate respondsToSelector:@selector(catLoginContorllerJump2Register:)]) {
        [self.guideDelegate catLoginContorllerJump2Register:self];
    }
}

- (void)forgetAction:(UIButton *)sender {
    if ([self.guideDelegate respondsToSelector:@selector(catLoginControllerJump2ForgetPwd:)]) {
        [self.guideDelegate catLoginControllerJump2ForgetPwd:self];
    }
}

- (void)dismissKeyboardAction:(UITapGestureRecognizer *)sender {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (void)clickVisitModeAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(catLoginControllerDismiss:)]) {
        [self.delegate catLoginControllerDismiss:self];
    }else {
        if (self.presentingViewController) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }else if (self.navigationController) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)submitAction:(UIButton *)sender {
    BOOL isValidate = YES;
    NSMutableDictionary *infoM = [NSMutableDictionary dictionary];
    if (![ccs function_isEmpty:_accountField]) {
        [infoM setObject:_accountField.text forKey:CatLoginContentAccountString];
    }
    
    if (![ccs function_isEmpty:_pwdField]) {
        [infoM setObject:_pwdField.text forKey:CatLoginContentPwdString];
    }
    
    if (![ccs function_isEmpty:_smsField]) {
        [infoM setObject:_smsField.text forKey:CatLoginContentSmsString];
    }
    
    _infoDictionary = infoM.copy;
    if ([self.delegate respondsToSelector:@selector(catLoginController:validateContent:)]) {
        isValidate = [self.delegate catLoginController:self
                                       validateContent:_infoDictionary];
    }
    
    if (isValidate) {
        if ([self.delegate respondsToSelector:@selector(catLoginController:content:commitWithSender:)]) {
            [self.delegate catLoginController:self
                                      content:_infoDictionary
                             commitWithSender:sender];
        }
    }
}

- (void)loginSuccessAction:(NSNotification *)sender {
    if ([sender.name isEqualToString:CatLoginSuccessNotification]) {
        if ([self.delegate respondsToSelector:@selector(catLoginControllerDismiss:)]) {
            [self.delegate catLoginControllerDismiss:self];
        }else {
            if (self.presentingViewController) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }else if (self.navigationController) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }
}


// MARK: - CatLoginCountButtonDelegate -
- (void)smsTextField:(CatLoginSmsTextField *)textField withSender:(CatLoginCountButton *)countButton {
    if ([self.delegate respondsToSelector:@selector(catLoginController:content:smsDelayWithSender:)]) {
        if (_accountField.text) {
            [self.delegate catLoginController:self
                                      content:@{CatLoginContentAccountString:_accountField.text}
                           smsDelayWithSender:countButton];
        }else {
            [self.delegate catLoginController:self
                                      content:@{}
                           smsDelayWithSender:countButton];
        }
    }else {
        if ([self.delegate respondsToSelector:@selector(catLoginController:content:smsWithSender:)]) {
            BOOL rs = NO;
            if (_accountField.text) {
                rs = [self.delegate catLoginController:self content:@{CatLoginContentAccountString:_accountField.text} smsWithSender:countButton];
            }else {
                rs = [self.delegate catLoginController:self content:@{} smsWithSender:countButton];
            }
            
            if (rs) {
                [textField.countButton manualTrigger];
            }else {
                textField.countButton.enabled = YES;
            }
        }
    }
}

- (void)_fixup:(BOOL)isDidAppear {
    if (isDidAppear) {
        self.navigationController.navigationBar.shadowImage = nil;
        self.navigationController.navigationBar.barTintColor = _originNavigationColor;
    }else {
        self.navigationController.navigationBar.shadowImage = [UIImage new];
        _originNavigationColor = self.navigationController.navigationBar.barTintColor;
        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    }
}

UIImage *imageResouceWithName(NSString *imageName) {
    /// 暂时忽略scale
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"CatLogin" ofType:@"bundle"];
    NSString *imagePath = [resourcePath stringByAppendingPathComponent:imageName];
    return [UIImage imageWithContentsOfFile:imagePath];
}


@end

@implementation UIButton (CatUI)

- (void)ui_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [backgroundColor CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self setBackgroundImage:image forState:state];
}

@end
