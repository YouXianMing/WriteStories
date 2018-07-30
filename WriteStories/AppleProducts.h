//
//  AppleProducts.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/30.
//  Copyright © 2018年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<StoreKit/StoreKit.h>
@class AppleProducts;

@protocol AppleProductsDelegate <NSObject>

- (void)appleProductsDidFinish:(AppleProducts *)appleProducts;
- (void)appleProductsDidFailed:(AppleProducts *)appleProducts withError:(NSError *)error;

@end

@interface AppleProducts : NSObject

@property (nonatomic, weak)   id <AppleProductsDelegate>  delegate;
@property (nonatomic, strong) NSArray <NSString *>       *productIDs;
@property (nonatomic)         BOOL                        isRunning;

- (void)startGetProducts;

@property (nonatomic, readonly) NSArray <SKProduct *> *products;

@end
