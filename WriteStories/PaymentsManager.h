//
//  PaymentsManager.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/5.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseEncodeObject.h"

@interface PaymentItem : BaseEncodeObject

@property (nonatomic, strong) NSString *paymentID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *version;
@property (nonatomic) BOOL              didPay; // 是否支付了

@end

@interface PaymentsManager : BaseEncodeObject

@property (nonatomic, strong) NSString                *version;
@property (nonatomic, strong) NSArray <PaymentItem *> *paymentItems;

+ (void)prepare;

/**
 升级版本的时候使用
 */
+ (void)update;

+ (PaymentsManager *)defaultManager;

- (BOOL)didPayByItemID:(NSString *)itemId;

- (void)store;

@end
