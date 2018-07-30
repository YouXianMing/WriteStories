//
//  BaseBackgroundStyleCell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/11.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseBackgroundStyleCell.h"
#import "UIView+SetRect.h"
#import "UIFont+Project.h"
#import "HexColors.h"
#import "BackgroundStyleObject.h"
#import "PaymentLabel.h"

@interface BaseBackgroundStyleCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *desLabel;

@property (nonatomic, strong) UIView *coverView;

@property (nonatomic, strong) PaymentLabel *paymentLabel;

@end

@implementation BaseBackgroundStyleCell

- (void)buildSubview {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    imageView.image        = [[UIImage imageNamed:@"homeMenuBG"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
    imageView.x           -= 3;
    imageView.y           -= 3;
    imageView.width       += 7.f;
    imageView.height      += 7.f;
    [self.contentView addSubview:imageView];
    
    self.areaView                 = [[UIView alloc] initWithFrame:self.bounds];
    self.areaView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.areaView];
    
    self.titleLabel      = [UILabel new];
    self.titleLabel.font = [UIFont PingFangSC_Regular_WithFontSize:18];
    [self.contentView addSubview:self.titleLabel];
    
    self.coverView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0)];
    self.coverView.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.35f];
    [self.contentView addSubview:self.coverView];
    
    self.desLabel               = [UILabel new];
    self.desLabel.numberOfLines = 0;
    self.desLabel.textColor     = [UIColor whiteColor];
    self.desLabel.font          = [UIFont PingFangSC_Light_WithFontSize:12.f];
    [self.contentView addSubview:self.desLabel];
    
    self.paymentLabel       = [[PaymentLabel alloc] initWithPaymentLabel];
    self.paymentLabel.right = self.width - 10.f;
    [self addSubview:self.paymentLabel];
}

- (void)loadContent {
    
    BackgroundStyleObject *object = self.data;
    
    self.titleLabel.text = object.title;
    [self.titleLabel sizeToFit];
    
    self.titleLabel.left = 10.f;
    self.titleLabel.top  = 10.f;
    
    self.desLabel.text  = object.desInfo;
    self.desLabel.width = self.width - 20.f;
    [self.desLabel sizeToFit];
    self.desLabel.left   = 10.f;
    self.desLabel.bottom = self.height - 10.f;
    
    self.coverView.frame  = CGRectMake(0, 0, self.width, self.desLabel.height + 20.f);
    self.coverView.left   = 0.f;
    self.coverView.bottom = self.height;
    
    self.paymentLabel.bottom       = self.coverView.top - 10.f;
    self.paymentLabel.paymentState = object.paymentState;
}

@end
