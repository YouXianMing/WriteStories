//
//  ProductPayment.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/30.
//  Copyright © 2018年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<StoreKit/StoreKit.h>
@class ProductPayment;

typedef enum : NSUInteger {
    
    ProductPaymentResultPurchasedSuccess = 1000, // 购买成功
    ProductPaymentResultPurchasedFailed,         // 购买失败
    
    ProductPaymentResultPurchasedDidRestoredSuccess, // 恢复购买成功
    ProductPaymentResultPurchasedDidRestoredFailed,
    
} ProductPaymentResult;

@protocol ProductPaymentDelegate <NSObject>

- (void)productDidPaymentWithResult:(ProductPaymentResult)result productIDs:(NSArray <NSString *> *)productIDs;

@end

@interface ProductPayment : NSObject

@property (nonatomic, weak) id <ProductPaymentDelegate> delegate;

/**
 开始购买商品
 */
- (void)startPaymentWithProduct:(SKProduct *)product;

/**
 恢复购买
 */
- (void)restoreCompletedPayments;

@end
