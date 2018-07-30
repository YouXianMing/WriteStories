//
//  AppleProducts.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/30.
//  Copyright © 2018年 YouXianMing. All rights reserved.
//

#import "AppleProducts.h"

@interface AppleProducts () <SKProductsRequestDelegate, SKRequestDelegate>

@property (nonatomic, strong) SKProductsRequest     *sKProductsRequest;
@property (nonatomic, strong) NSArray <SKProduct *> *products;

@end

@implementation AppleProducts

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.productIDs = @[];
    }
    
    return self;
}

- (void)startGetProducts {
    
    self.isRunning = YES;
    
    self.sKProductsRequest          = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithArray:self.productIDs]];
    self.products                   = @[];
    self.sKProductsRequest.delegate = self;
    [self.sKProductsRequest start];
}

#pragma mark - SKProductsRequestDelegate

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    
    self.products = response.products;
    
    [response.products enumerateObjectsUsingBlock:^(SKProduct * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        NSLog(@"%@", obj.productIdentifier);
    }];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(appleProductsDidFinish:)]) {
        
        [self.delegate appleProductsDidFinish:self];
    }
}

#pragma mark - SKRequestDelegate

- (void)requestDidFinish:(SKRequest *)request {
    
    self.isRunning = NO;
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    
    self.isRunning = NO;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(appleProductsDidFailed:withError:)]) {
        
        [self.delegate appleProductsDidFailed:self withError:error];
    }
}

@end
