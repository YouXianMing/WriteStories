//
//  PaymentLabel.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/5.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "PaymentLabel.h"
#import "UIFont+Project.h"
#import "UIColor+Project.h"
#import "HexColors.h"

@interface PaymentLabel ()

@property (nonatomic, strong) UILabel *payLabel;

@end

@implementation PaymentLabel

- (instancetype)initWithPaymentLabel {
    
    if (self = [super initWithFrame:CGRectMake(0, 0, 75.f, 24.f)]) {
    
        self.userInteractionEnabled = NO;
        
        self.payLabel                    = [[UILabel alloc] initWithFrame:self.bounds];
        self.payLabel.backgroundColor    = [UIColor whiteColor];
        self.payLabel.layer.borderWidth  = 0.5f;
        self.payLabel.layer.borderColor  = [UIColor LineColor].CGColor;
        self.payLabel.layer.cornerRadius = 12.f;
        self.payLabel.clipsToBounds      = YES;
        self.payLabel.textAlignment      = NSTextAlignmentCenter;
        self.payLabel.text               = @"已够买";
        self.payLabel.font               = [UIFont PingFangSC_Semibold_WithFontSize:13.f];
        [self addSubview:self.payLabel];
        
        self.paymentState = WriteStoriesBaseItemObjectPaymantStateNormalUse;
    }
    
    return self;
}

- (void)setPaymentState:(WriteStoriesBaseItemObjectPaymantState)paymentState {
    
    _paymentState = paymentState;
    
    if (paymentState == WriteStoriesBaseItemObjectPaymantStateNormalUse) {
        
        self.hidden = YES;
        
    } else if (paymentState == WriteStoriesBaseItemObjectPaymantStateNotPay) {
        
        self.hidden             = NO;
        self.payLabel.text      = @"¥6.00";
        self.payLabel.textColor = [UIColor redColor];
        
    } else if (paymentState == WriteStoriesBaseItemObjectPaymantStateDidPay) {
        
        self.hidden             = NO;
        self.payLabel.text      = @"已购买";
        self.payLabel.textColor = [UIColor colorWithHexString:@"#959595"];
    }
}

@end
