//
//  ValidateProductReceipt.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/30.
//  Copyright © 2018年 YouXianMing. All rights reserved.
//

#define APPSTORE_ASK_TO_BUY_IN_SANDBOX

#import <Foundation/Foundation.h>
@class ValidateProductReceipt;

@protocol ValidateProductReceiptDelegate <NSObject>

@end

@interface ValidateProductReceipt : NSObject

- (void)startValidateProductReceipt;

@end
