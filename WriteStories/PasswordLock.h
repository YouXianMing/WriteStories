//
//  PasswordLock.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/1.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PasswordLock : NSObject

/**
 被锁定了

 @return YES为被锁定了，NO为没有锁定
 */
+ (BOOL)Locked;

/**
 多少秒后解锁

 @return 秒
 */
+ (NSInteger)unLockSeconds;

/**
 密码出错了，出错五次后，将锁定
 */
+ (void)PasswordError;

/**
 输入正确后清空
 */
+ (void)Reset;

@end
