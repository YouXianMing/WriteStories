//
//  NSString+AES.h
//  AES加密
//
//  Created by 王全金 on 2018/1/31.
//  Copyright © 2018年 王全金. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AES)

//加密方法
+ (NSString *)encryptAES:(NSString *)content key:(NSString *)key;
//解密方法
+ (NSString *)decryptAES:(NSString *)content key:(NSString *)key;

@end
