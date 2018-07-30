//
//  ProductPayment.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/30.
//  Copyright © 2018年 YouXianMing. All rights reserved.
//

#import "ProductPayment.h"

#define APPSTORE_ASK_TO_BUY_IN_SANDBOX

typedef enum : NSUInteger {
    
    ProductPaymentTypePay,
    ProductPaymentTypeRestore,
    
} ProductPaymentType;

@interface ProductPayment () <SKPaymentTransactionObserver>

@property (nonatomic)         ProductPaymentResult result;
@property (nonatomic)         ProductPaymentType   type;
@property (nonatomic, strong) SKPayment           *skPayment;

@property (nonatomic, strong) NSMutableSet        *restoreProductIDs;

@end

@implementation ProductPayment

- (instancetype)init {
    
    if (self = [super init]) {
        
        [SKPaymentQueue.defaultQueue addTransactionObserver:self];
    }
    
    return self;
}

- (void)startPaymentWithProduct:(SKProduct *)product {
    
    self.type      = ProductPaymentTypePay;
    self.skPayment = [SKPayment paymentWithProduct:product];
    [SKPaymentQueue.defaultQueue addPayment:self.skPayment];
}

- (void)restoreCompletedPayments {
    
    self.type              = ProductPaymentTypeRestore;
    self.restoreProductIDs = [NSMutableSet set];
    [SKPaymentQueue.defaultQueue restoreCompletedTransactions];
}

#pragma mark - SKPaymentTransactionObserver

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions {
    
    if (self.type == ProductPaymentTypePay) {
        
        [transactions enumerateObjectsUsingBlock:^(SKPaymentTransaction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            // 只监听当前商品
            if ([obj.payment.productIdentifier isEqualToString:self.skPayment.productIdentifier]) {
                
                switch (obj.transactionState) {
                        
                        // Transaction is being added to the server queue.
                    case SKPaymentTransactionStatePurchasing: {
                        
                        NSLog(@"==> 添加了交易商品");
                        
                    } break;
                        
                        // Transaction is in queue, user has been charged. Client should complete the transaction.
                    case SKPaymentTransactionStatePurchased: {
                        
                        NSLog(@"==> 购买成功");
                        [queue finishTransaction:obj];
                        if (self.delegate && [self.delegate respondsToSelector:@selector(productDidPaymentWithResult:productIDs:)]) {
                            
                            [self.delegate productDidPaymentWithResult:ProductPaymentResultPurchasedSuccess productIDs:@[obj.payment.productIdentifier]];
                        }
                        
                    } break;
                        
                        // Transaction was cancelled or failed before being added to the server queue.
                    case SKPaymentTransactionStateFailed: {
                        
                        NSLog(@"==> 购买失败(用户取消或者购买失败)");
                        [queue finishTransaction:obj];
                        if (self.delegate && [self.delegate respondsToSelector:@selector(productDidPaymentWithResult:productIDs:)]) {
                            
                            [self.delegate productDidPaymentWithResult:ProductPaymentResultPurchasedFailed productIDs:@[obj.payment.productIdentifier]];
                        }
                        
                    } break;
                        
                        // Transaction was restored from user's purchase history.  Client should complete the transaction.
                    case SKPaymentTransactionStateRestored: {
                        
                        NSLog(@"==> 恢复购买");
                        [queue finishTransaction:obj];
                        if (self.delegate && [self.delegate respondsToSelector:@selector(productDidPaymentWithResult:productIDs:)]) {
                            
                            [self.delegate productDidPaymentWithResult:ProductPaymentResultPurchasedDidRestoredSuccess productIDs:@[]];
                        }
                        
                    } break;
                        
                        // The transaction is in the queue, but its final status is pending external action.
                    case SKPaymentTransactionStateDeferred: {
                        
                        NSLog(@"==> 交易还在队列里面，但最终状态还没有决定");
                        
                    } break;
                        
                    default:
                        break;
                }
            }
        }];
        
    } else if (self.type == ProductPaymentTypeRestore) {
        
        [transactions enumerateObjectsUsingBlock:^(SKPaymentTransaction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            switch (obj.transactionState) {
                    
                    // Transaction is being added to the server queue.
                case SKPaymentTransactionStatePurchasing: {
                    
                    NSLog(@"==> 添加交易商品");
                    
                } break;
                    
                    // Transaction is in queue, user has been charged. Client should complete the transaction.
                case SKPaymentTransactionStatePurchased: {
                    
                    NSLog(@"==> 购买成功");
                    [queue finishTransaction:obj];
                    
                } break;
                    
                    // Transaction was cancelled or failed before being added to the server queue.
                case SKPaymentTransactionStateFailed: {
                    
                    NSLog(@"==> 购买失败(用户取消或者购买失败)");
                    [queue finishTransaction:obj];
                    
                } break;
                    
                    // Transaction was restored from user's purchase history.  Client should complete the transaction.
                case SKPaymentTransactionStateRestored: {
                    
                    NSLog(@"==> 恢复购买 %@", obj.payment.productIdentifier);
                    [self.restoreProductIDs addObject:obj.payment.productIdentifier];
                    [queue finishTransaction:obj];
                    
                } break;
                    
                    // The transaction is in the queue, but its final status is pending external action.
                case SKPaymentTransactionStateDeferred: {
                    
                    NSLog(@"==> 交易还在队列里面，但最终状态还没有决定");
                    
                } break;
                    
                default:
                    break;
            }
        }];
    }
}

- (void)paymentQueue:(SKPaymentQueue *)queue removedTransactions:(NSArray<SKPaymentTransaction *> *)transactions {
    
    if (self.type == ProductPaymentTypePay) {
        
        [transactions enumerateObjectsUsingBlock:^(SKPaymentTransaction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj.payment.productIdentifier isEqualToString:self.skPayment.productIdentifier]) {
                
                NSLog(@"removed -> %@", obj.payment.productIdentifier);
            }
        }];
        
    } else if (self.type == ProductPaymentTypeRestore) {
        
        [transactions enumerateObjectsUsingBlock:^(SKPaymentTransaction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
        }];
    }
}

- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(productDidPaymentWithResult:productIDs:)]) {
        
        NSLog(@"%@", error);
        [self.delegate productDidPaymentWithResult:ProductPaymentResultPurchasedDidRestoredFailed productIDs:@[]];
    }
}

- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(productDidPaymentWithResult:productIDs:)]) {
        
        [self.delegate productDidPaymentWithResult:ProductPaymentResultPurchasedDidRestoredSuccess productIDs:self.restoreProductIDs.allObjects];
    }
}

#pragma mark - dealloc

- (void)dealloc {
    
    [SKPaymentQueue.defaultQueue removeTransactionObserver:self];
}

@end
