//
//  NormalTitleViewController.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/24.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseCustomViewController.h"
#import "HexColors.h"
#import "UIView+SetRect.h"
#import "DeviceInfo.h"
#import "TitleMenuButton.h"
#import "UIColor+Project.h"
#import "UIFont+Project.h"

@interface NormalTitleViewController : BaseCustomViewController

@property (nonatomic, strong) TitleMenuButton *backButton;
@property (nonatomic, strong) UILabel         *titleLabel;
@property (nonatomic, strong) UIView          *titleContentView;

- (void)backButtonEvent:(TitleMenuButton *)button;

@end
