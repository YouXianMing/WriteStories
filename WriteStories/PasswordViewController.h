//
//  PasswordViewController.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/1.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "FullContentViewController.h"

typedef enum : NSUInteger {
    
    PasswordViewControllerTypeSetNewPassword = 0, // 设定新密码
    PasswordViewControllerTypeDeletePassword,     // 密码删除
    PasswordViewControllerTypeComfirmPassword     // 确认密码
    
} PasswordViewControllerType;

typedef enum : NSUInteger {
    
    PasswordViewControllerResultCancel,
    PasswordViewControllerResultSuccess,
    
} PasswordViewControllerResult;

@interface PasswordViewController : FullContentViewController

@property (nonatomic) PasswordViewControllerType type;

@end
