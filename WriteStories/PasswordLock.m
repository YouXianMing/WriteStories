//
//  PasswordLock.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/1.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "PasswordLock.h"

static NSTimeInterval _seconds = 60 * 60;

static NSString *_errorCount    = @"_errorCount";
static NSString *_errorTime     = @"_errorTime";
static NSString *_lock          = @"_lock";

@implementation PasswordLock

+ (void)PasswordError {
    
    // 获取出错次数
    NSInteger count = [NSUserDefaults.standardUserDefaults integerForKey:_errorCount];
    
    // 出错次数+1
    count += 1;
    
    // 存储出错次数
    [NSUserDefaults.standardUserDefaults setInteger:count forKey:_errorCount];
    
    // 第一次出错,记录出错时间
    if (count == 1) {
        
        [NSUserDefaults.standardUserDefaults setObject:NSDate.date forKey:_errorTime];
    }
    
    // 错误五次后锁定
    if (count >= 5) {
        
        // 锁定
        [NSUserDefaults.standardUserDefaults setBool:YES forKey:_lock];
        
        // 错误5次后更新出错时间
        [NSUserDefaults.standardUserDefaults setObject:NSDate.date forKey:_errorTime];
    }
}

+ (BOOL)Locked {
    
    // 你第一次出错过了一个小时,或者5次出错后过了一个小时之后就重置为 UnLock 状态
    if ([NSUserDefaults.standardUserDefaults objectForKey:_errorTime]) {
        
        NSDate    *date    = [NSUserDefaults.standardUserDefaults objectForKey:_errorTime];
        NSInteger  seconds = [NSDate.date timeIntervalSinceDate:date];
        
        if (seconds >= _seconds) {
            
            [PasswordLock Reset];
        }
    }
    
    return [NSUserDefaults.standardUserDefaults boolForKey:_lock];
}

+ (void)Reset {
    
    // 清空出错次数
    [NSUserDefaults.standardUserDefaults setInteger:0 forKey:_errorCount];
    
    // 清空第一次出错时间
    [NSUserDefaults.standardUserDefaults setObject:nil forKey:_errorTime];
    
    // 清空锁定
    [NSUserDefaults.standardUserDefaults setBool:NO forKey:_lock];
}

+ (NSInteger)unLockSeconds {
    
    return _seconds - [NSDate.date timeIntervalSinceDate:[NSUserDefaults.standardUserDefaults objectForKey:_errorTime]] + 1;
}

@end
