//
//  PaymentLabel.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/5.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WriteStoriesBaseItemObject.h"

@interface PaymentLabel : UIView

- (instancetype)initWithPaymentLabel;

@property (nonatomic) WriteStoriesBaseItemObjectPaymantState paymentState;

@end
