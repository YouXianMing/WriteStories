//
//  PaymentObject.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/30.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseEncodeObject.h"

@interface PaymentObject : BaseEncodeObject

@property (nonatomic, strong) NSString *version;    // 1.1 表示支付过了，1.0表示没有支付过
@property (nonatomic, strong) NSString *subVersion; // 0表示没有验证过, 1表示验证过
@property (nonatomic, strong) NSDate   *startDate;  // 启动时间

+ (void)prepare;

+ (NSString *)theVersion;
+ (NSString *)theSubVersion;
+ (NSDate *)theStartDate;

+ (void)updateVersion;
+ (void)updateSubVersion;

+ (NSString *)showString; // 提示信息
+ (BOOL)timeout;          // 超时

@end
