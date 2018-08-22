//
//  PasswordViewController.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/1.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "PasswordViewController.h"
#import "TitleMenuButton.h"
#import "NSString+AES.h"
#import "PasswordKeyboard.h"
#import "UIFont+Project.h"
#import "UIButton+Inits.h"
#import "TapAlphaButton.h"
#import "Values.h"
#import "GCD.h"
#import "DateFormatter.h"
#import "PasswordLock.h"
#import "HexColors.h"
#import "DeviceInfo.h"
#import <MessageUI/MessageUI.h>

typedef enum : NSUInteger {
    
    Tag_Button = 1000,
    
} ValueTag;

@interface PasswordViewController () <UITextFieldDelegate, PasswordKeyboardDelegate, MFMailComposeViewControllerDelegate>

@property (nonatomic) BOOL comfirmNewPasswordStep;

@property (nonatomic, strong) PasswordKeyboard            *keyBoard;
@property (nonatomic, strong) UILabel                     *label;
@property (nonatomic, strong) UIView                      *areaView;
@property (nonatomic, strong) UILabel                     *notiLabel;

@property (nonatomic, strong) NSMutableArray <NSNumber *> *numbers;
@property (nonatomic, strong) NSMutableArray <NSNumber *> *oldNumbers;

@property (nonatomic, strong) TapAlphaButton              *fogetPasswordButton;
@property (nonatomic, strong) TitleMenuButton             *closeButton;

@property (nonatomic, strong) UIImageView *passwordLockImageView;
@property (nonatomic, strong) UILabel     *passwordInfoLabel;

@end

@implementation PasswordViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    CGFloat top    = 0.f;
    CGFloat bottom = 0.f;
    if (DeviceInfo.isFringeScreen) {
        
        top    += DeviceInfo.fringeScreenTopSafeHeight;
        bottom += DeviceInfo.fringeScreenBottomSafeHeight;
    }
    
    self.numbers = [NSMutableArray array];
    
    self.closeButton = [[TitleMenuButton alloc] initWithFrame:CGRectMake(0, top, 100, 70) type:TitleMenuButton_Close];
    [self.closeButton addTarget:self action:@selector(closeEvent)];
    [self.contentView addSubview:self.closeButton];
    
    self.fogetPasswordButton                  = [[TapAlphaButton alloc] initWithFrame:CGRectMake(0, top, 100, 70)];
    self.fogetPasswordButton.titleLabel.font  = [UIFont PingFangSC_Thin_WithFontSize:18.f];
    self.fogetPasswordButton.right            = Width;
    self.fogetPasswordButton.normalTitle      = @"忘记密码";
    self.fogetPasswordButton.normalTitleColor = UIColor.blackColor;
    self.fogetPasswordButton.hidden           = YES;
    [self.fogetPasswordButton addTarget:self action:@selector(fogetPasswordEvent)];
    [self.contentView addSubview:self.fogetPasswordButton];
    
    self.keyBoard            = [PasswordKeyboard new];
    self.keyBoard.numberFont = [UIFont PingFangSC_Thin_WithFontSize:30.f];
    self.keyBoard.delegate   = self;
    [self.keyBoard buildButtons];
    self.keyBoard.bottom     = self.contentView.height - bottom;
    self.keyBoard.left       = 0.f;
    [self.contentView addSubview:self.keyBoard];
    
    self.areaView        = [[UIView alloc] initWithFrame:CGRectMake(0, 100, Width, 100)];
    self.areaView.bottom = self.contentView.height / 3.f;
    [self.contentView addSubview:self.areaView];
    
    self.label               = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, Width, 70.f)];
    self.label.font          = [UIFont PingFangSC_Thin_WithFontSize:16.f];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.areaView addSubview:self.label];
    
    self.notiLabel               = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Width, 40.f)];
    self.notiLabel.font          = [UIFont PingFangSC_Thin_WithFontSize:14.f];
    self.notiLabel.textAlignment = NSTextAlignmentCenter;
    self.notiLabel.textColor     = [UIColor redColor];
    self.notiLabel.top           = self.areaView.height;
    [self.areaView addSubview:self.notiLabel];
    
    self.passwordLockImageView        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password_lock"]];
    self.passwordLockImageView.center = self.contentView.middlePoint;
    self.passwordLockImageView.alpha  = 0.f;
    [self.contentView addSubview:self.passwordLockImageView];
    
    self.passwordInfoLabel               = [UILabel new];
    self.passwordInfoLabel.alpha         = 0.f;
    self.passwordInfoLabel.numberOfLines = 0;
    self.passwordInfoLabel.font          = [UIFont PingFangSC_Thin_WithFontSize:15.f];
    self.passwordInfoLabel.textColor     = [UIColor colorWithHexString:@"#6d6d6d"];
    [self.contentView addSubview:self.passwordInfoLabel];
    
    {
        CGFloat width  = 30.f;
        CGFloat height = 30.f;
        CGFloat x      = (Width - width * 4) / 2.f;
        
        for (int i = 0; i < 4; i++) {
            
            CGRect    rect                = CGRectMake(x + width * i, self.areaView.height - height, width, height);
            UIButton *button              = [[UIButton alloc] initWithFrame:rect];
            button.tag                    = Tag_Button + i;
            button.userInteractionEnabled = NO;
            button.normalImage            = [UIImage imageNamed:@"circle-hollow"];
            [self.areaView addSubview:button];
        }
    }
    
    if (self.type == PasswordViewControllerTypeSetNewPassword) {
        
        self.label.text = @"请输入新密码";
        
    } else if (self.type == PasswordViewControllerTypeDeletePassword || self.type == PasswordViewControllerTypeComfirmPassword) {
        
        self.fogetPasswordButton.hidden = NO;
        
        self.label.text = @"请输入密码";
        
        // 判断锁定状态
        if (PasswordLock.Locked) {
            
            self.areaView.alpha              = 0.f;
            self.keyBoard.alpha              = 0.f;
            self.passwordLockImageView.alpha = 1.f;
            self.passwordInfoLabel.alpha     = 1.f;
            
            self.passwordInfoLabel.text = [NSString stringWithFormat:@"您重试次数太多，请%ld分%ld秒后尝试！", [PasswordLock unLockSeconds] / 60, [PasswordLock unLockSeconds] % 60];
            [self.passwordInfoLabel sizeToFit];
            self.passwordInfoLabel.centerX = Width / 2.f;
            self.passwordInfoLabel.top     = self.passwordLockImageView.bottom + 20.f;
        }
    }
}

- (void)updateButtonsWithCount:(NSInteger)count {
    
    for (int i = 0; i < 4; i++) {
        
        UIButton *button = [self.areaView viewWithTag:Tag_Button + i];
        
        if (i < count) {
            
            button.normalImage = [UIImage imageNamed:@"circle-password"];
            
        } else {
            
            button.normalImage = [UIImage imageNamed:@"circle-hollow"];
        }
    }
}

#pragma mark - PasswordKeyboardDelegate

- (void)passwordKeyboardDelete:(PasswordKeyboard *)keyboard {
    
    NSLog(@"delete");
    [self.numbers removeLastObject];
    
    [self updateButtonsWithCount:self.numbers.count];
}

- (void)passwordKeyboard:(PasswordKeyboard *)keyboard selectedNumber:(NSNumber *)number {
    
    if /* 设置新密码 */ (self.type == PasswordViewControllerTypeSetNewPassword) {
        
        if (self.comfirmNewPasswordStep == NO) {
            
            if (self.numbers.count < 3) {
                
                [self.numbers addObject:number];
                [self updateButtonsWithCount:self.numbers.count];
                
            } else if (self.numbers.count == 3) {
                
                [self.numbers addObject:number];
                [self updateButtonsWithCount:self.numbers.count];
                
                [GCDQueue executeInMainQueue:^{
                    
                    self.label.text             = @"请再次输入新密码";
                    self.notiLabel.text         = @"";
                    self.comfirmNewPasswordStep = YES;
                    self.oldNumbers             = [NSMutableArray arrayWithArray:self.numbers];
                    [self.numbers removeAllObjects];
                    [self updateButtonsWithCount:self.numbers.count];
                    
                } afterDelaySecs:0.5];
            }
            
        } else if (self.comfirmNewPasswordStep == YES) {
            
            if (self.numbers.count < 3) {
                
                [self.numbers addObject:number];
                [self updateButtonsWithCount:self.numbers.count];
                
            } else if (self.numbers.count == 3) {
                
                [self.numbers addObject:number];
                [self updateButtonsWithCount:self.numbers.count];
                
                // 校验操作
                __block BOOL success = YES;
                [self.oldNumbers enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if (obj.integerValue != self.numbers[idx].integerValue) {
                        
                        success = NO;
                    }
                }];
                
                if /* 校验成功 */ (success == YES) {
                    
                    // 存储密码
                    Values.Passwords = self.numbers;
                    
                    self.closeButton.userInteractionEnabled = NO;
                    self.keyBoard.userInteractionEnabled    = NO;
                    
                    if (self.eventDelegate && [self.eventDelegate respondsToSelector:@selector(baseCustomViewController:event:)]) {
                        
                        [self.eventDelegate baseCustomViewController:self event:@(PasswordViewControllerResultSuccess)];
                    }
                    
                    [GCDQueue executeInMainQueue:^{
                        
                        [self dismissViewControllerAnimated:YES completion:nil];
                        
                    } afterDelaySecs:0.5f];
                    
                } /* 校验失败 */ else {
                    
                    self.notiLabel.text = @"两次密码输入不一致，请重新输入！";
                    
                    [GCDQueue executeInMainQueue:^{
                        
                        self.comfirmNewPasswordStep = NO;
                        self.label.text             = @"请输入新密码";
                        [self.oldNumbers removeAllObjects];
                        [self.numbers removeAllObjects];
                        [self updateButtonsWithCount:self.numbers.count];
                        
                    } afterDelaySecs:0.5f];
                }
            }
        }
        
    } /* 删除密码 */ else if (self.type == PasswordViewControllerTypeDeletePassword) {
        
        if (self.numbers.count < 3) {
            
            [self.numbers addObject:number];
            [self updateButtonsWithCount:self.numbers.count];
            
        } else if (self.numbers.count == 3) {
            
            [self.numbers addObject:number];
            [self updateButtonsWithCount:self.numbers.count];
            
            // 校验操作
            __block BOOL success = YES;
            [Values.Passwords enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if (obj.integerValue != self.numbers[idx].integerValue) {
                    
                    success = NO;
                }
            }];

            if /* 校验成功 */ (success == YES) {
                
                // 删除密码
                Values.Passwords = @[];
                
                self.notiLabel.text                     = @"";
                self.closeButton.userInteractionEnabled = NO;
                self.keyBoard.userInteractionEnabled    = NO;
                
                if (self.eventDelegate && [self.eventDelegate respondsToSelector:@selector(baseCustomViewController:event:)]) {
                    
                    [self.eventDelegate baseCustomViewController:self event:@(PasswordViewControllerResultSuccess)];
                }
                
                [GCDQueue executeInMainQueue:^{
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                    
                } afterDelaySecs:0.5f];
                
                // 重置
                [PasswordLock Reset];
                
            } /* 校验失败 */ else {
                
                self.notiLabel.text = @"密码有误，请重新输入！";
                
                [GCDQueue executeInMainQueue:^{
                    
                    [self.numbers removeAllObjects];
                    [self updateButtonsWithCount:self.numbers.count];
                    
                } afterDelaySecs:0.5f];
                
                // 增加出错次数
                [PasswordLock PasswordError];
                
                // 如果锁定了(错了五次了)
                if (PasswordLock.Locked) {
                    
                    self.passwordInfoLabel.text = [NSString stringWithFormat:@"您重试次数太多，请%ld分%ld秒后尝试！", [PasswordLock unLockSeconds] / 60, [PasswordLock unLockSeconds] % 60];
                    [self.passwordInfoLabel sizeToFit];
                    self.passwordInfoLabel.centerX = Width / 2.f;
                    self.passwordInfoLabel.top     = self.passwordLockImageView.bottom + 20.f;
                    
                    [UIView animateWithDuration:0.5f animations:^{
                        
                        self.areaView.alpha              = 0.f;
                        self.keyBoard.alpha              = 0.f;
                        self.passwordLockImageView.alpha = 1.f;
                        self.passwordInfoLabel.alpha     = 1.f;
                    }];
                }
            }
        }
        
    }  /* 确认密码 */ else if (self.type == PasswordViewControllerTypeComfirmPassword) {
        
        if (self.numbers.count < 3) {
            
            [self.numbers addObject:number];
            [self updateButtonsWithCount:self.numbers.count];
            
        } else if (self.numbers.count == 3) {
            
            [self.numbers addObject:number];
            [self updateButtonsWithCount:self.numbers.count];
            
            // 校验操作
            __block BOOL success = YES;
            [Values.Passwords enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if (obj.integerValue != self.numbers[idx].integerValue) {
                    
                    success = NO;
                }
            }];
            
            if /* 校验成功 */ (success == YES) {
                
                self.notiLabel.text                     = @"";
                self.closeButton.userInteractionEnabled = NO;
                self.keyBoard.userInteractionEnabled    = NO;
                
                if (self.eventDelegate && [self.eventDelegate respondsToSelector:@selector(baseCustomViewController:event:)]) {
                    
                    [self.eventDelegate baseCustomViewController:self event:@(PasswordViewControllerResultSuccess)];
                }
                
                [GCDQueue executeInMainQueue:^{
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                    
                } afterDelaySecs:0.5f];
                
                // 重置
                [PasswordLock Reset];
                
            } /* 校验失败 */ else {
                
                self.notiLabel.text = @"密码有误，请重新输入！";
                
                [GCDQueue executeInMainQueue:^{
                    
                    [self.numbers removeAllObjects];
                    [self updateButtonsWithCount:self.numbers.count];
                    
                } afterDelaySecs:0.5f];
                
                // 增加出错次数
                [PasswordLock PasswordError];
                
                // 如果锁定了(错了五次了)
                if (PasswordLock.Locked) {
                    
                    self.passwordInfoLabel.text = [NSString stringWithFormat:@"您重试次数太多，请%ld分%ld秒后尝试！", [PasswordLock unLockSeconds] / 60, [PasswordLock unLockSeconds] % 60];
                    [self.passwordInfoLabel sizeToFit];
                    self.passwordInfoLabel.centerX = Width / 2.f;
                    self.passwordInfoLabel.top     = self.passwordLockImageView.bottom + 20.f;
                    
                    [UIView animateWithDuration:0.5f animations:^{
                        
                        self.areaView.alpha              = 0.f;
                        self.keyBoard.alpha              = 0.f;
                        self.passwordLockImageView.alpha = 1.f;
                        self.passwordInfoLabel.alpha     = 1.f;
                    }];
                }
            }
        }
    }
}

#pragma mark - Button's event.

- (void)closeEvent {
    
    if (self.eventDelegate && [self.eventDelegate respondsToSelector:@selector(baseCustomViewController:event:)]) {
        
        [self.eventDelegate baseCustomViewController:self event:@(PasswordViewControllerResultCancel)];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)fogetPasswordEvent {
    
    // 密码
    NSMutableString *string = [NSMutableString string];
    [Values.Passwords enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [string appendFormat:@"%@", obj];
    }];
    
    NSString *key = @"_you.xi_an.ming_";
    key           = [key stringByReplacingOccurrencesOfString:@"xi_an" withString:FmtStr(@"%05u", arc4random() % 10000)];
    
    // 加密数据
    NSString *body = FmtStr(@"<div style=\"text-align: center;\">\
           <p style=\"padding-bottom: 16px; font: normal 400 14px/28px PingFangSC-thin;\">解密后给您发送回密码</p>\
           <span style=\"color : #5A5C5C; font: normal 800 18px/28px PingFangSC-Light; text-align: center; border: 2px; border-color: #EAEBEC; border-style: solid; padding: 3px 7px; border-radius: 5px; background-color: #C1C2C3;\">%@</span>\
           </div>", [NSString encryptAES:string key:key]);
    
    // 解密工具
//    NSString *encryptString = [NSString encryptAES:string key:key];
//    for (int i = 0; i < 10000; i++) {
//
//        NSString *tempKey = @"_you.xi_an.ming_";
//        tempKey           = [tempKey stringByReplacingOccurrencesOfString:@"xi_an" withString:FmtStr(@"%05u", i)];
//
//        if ([NSString decryptAES:encryptString key:tempKey].length == 4) {
//
//            NSLog(@"%@", [NSString decryptAES:encryptString key:tempKey]);
//        }
//    }
    
    if ([MFMailComposeViewController canSendMail] && [MFMessageComposeViewController canSendText]) {

        // 控制器模式
        
        MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
        mailController.mailComposeDelegate          = self;

        NSString *time = [DateFormatter dateStringFromDate:[NSDate date] outputDateStringFormatter:@"yyyy-MM-dd HH:mm"];

        [mailController setToRecipients:@[@"YouXianMing1987@iCloud.com"]];
        [mailController setSubject:[NSString stringWithFormat:@"[%@] 找回密码", time]];
        [mailController setMessageBody:body isHTML:YES];
        [self presentViewController:mailController animated:YES completion:nil];

    } else {
        
        // mailto:方式
        
        NSString *time = [DateFormatter dateStringFromDate:[NSDate date] outputDateStringFormatter:@"yyyy-MM-dd HH:mm"];
        NSMutableString *mailUrl = [[NSMutableString alloc] init];
        [mailUrl appendFormat:@"mailto:YouXianMing1987@iCloud.com"];
        [mailUrl appendFormat:@"?&subject=[%@] 找回密码", time];
        [mailUrl appendFormat:@"&body=%@", body];
        NSString *emailPath = [mailUrl stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:emailPath]];
    }
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(nullable NSError *)error {
    
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
