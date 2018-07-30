//
//  ValidateProductReceipt.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/30.
//  Copyright © 2018年 YouXianMing. All rights reserved.
//

#import "ValidateProductReceipt.h"

@implementation ValidateProductReceipt

- (void)startValidateProductReceipt {

    // 从沙盒中获取到购买凭据
    NSData *receipt = [NSData dataWithContentsOfURL:NSBundle.mainBundle.appStoreReceiptURL];
    
    // 如果有购买凭证
    if (receipt) {
        
        // 发送网络POST请求，对购买凭据进行验证
        NSString *verifyUrlString;
        NSString *sandbox;
        
#if (defined(APPSTORE_ASK_TO_BUY_IN_SANDBOX) && defined(DEBUG))
        verifyUrlString = @"https://sandbox.itunes.apple.com/verifyReceipt";
        sandbox         = @"1";
#else
        verifyUrlString = @"https://buy.itunes.apple.com/verifyReceipt";
        sandbox         = @"0";
#endif
        
        NSDictionary *requestContents = @{@"receipt-data": [receipt base64EncodedStringWithOptions:0],
                                          @"sandbox"     : sandbox};
        
        NSLog(@"%@", requestContents);
        
        NSData       *requestData     = [NSJSONSerialization dataWithJSONObject:requestContents options:0 error:nil];
        
        // 国内访问苹果服务器比较慢，timeoutInterval 需要长一点
        NSMutableURLRequest *storeRequest = [NSMutableURLRequest requestWithURL:[[NSURL alloc] initWithString:verifyUrlString]
                                                                    cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                                timeoutInterval:10.0f];
        storeRequest.HTTPMethod = @"POST";
        storeRequest.HTTPBody   = requestData;
        
        // 开始验证
        NSLog(@"开始验证购买");
        NSURLSessionDataTask *dataTask = [NSURLSession.sharedSession dataTaskWithRequest:storeRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (error) {
                
                NSLog(@"%@", error);
                
            } else {
                
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                NSLog(@"%@", jsonResponse);
            }
        }];
        
        [dataTask resume];
    }
}

@end
