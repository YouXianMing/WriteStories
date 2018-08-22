//
//  NormalTitleViewController.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/24.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "NormalTitleViewController.h"

@interface NormalTitleViewController ()

@end

@implementation NormalTitleViewController

- (void)makeViewsConfig:(NSMutableDictionary<NSString *,ControllerBaseViewConfig *> *)viewsConfig {
    
    CGFloat titleViewHeight = 64.f;
    if (DeviceInfo.isFringeScreen) {
        
        titleViewHeight += DeviceInfo.fringeScreenTopSafeHeight;
    }
    
    // 更新titleView尺寸
    {
        ControllerBaseViewConfig *config = viewsConfig[titleViewId];
        config.backgroundColor           = UIColor.whiteColor;
        
        if (DeviceInfo.isFringeScreen) {
            
            config.frame = CGRectMake(0, 0, Width, titleViewHeight);
        }
    }
    
    // 更新contentView尺寸
    {
        ControllerBaseViewConfig *config = viewsConfig[contentViewId];
        
        if (DeviceInfo.isFringeScreen) {
            
            config.frame = CGRectMake(0, titleViewHeight, Width, Height - titleViewHeight);
        }
    }
    
    // 更新背景色
    {
        ControllerBaseViewConfig *config = viewsConfig[backgroundViewId];
        config.backgroundColor           = UIColor.BackgroundColor;
    }
}

- (void)setupSubViews {
    
    UIImageView *bgImageView           = [[UIImageView alloc] initWithFrame:self.titleView.bounds];
    bgImageView.image                  = [UIImage imageNamed:@"titleMenuBgNormal"];
    bgImageView.userInteractionEnabled = NO;
    [self.titleView addSubview:bgImageView];
    
    UIImageView *shadeImageView           = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width, 2.f)];
    shadeImageView.image                  = [UIImage imageNamed:@"shade"];
    shadeImageView.userInteractionEnabled = NO;
    shadeImageView.top                    = self.titleView.height;
    [self.titleView addSubview:shadeImageView];
    
    self.titleContentView        = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 64.f)];
    self.titleContentView.bottom = self.titleView.height;
    [self.titleView addSubview:self.titleContentView];
    
    self.titleLabel               = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, Width - 100, 64.f)];
    self.titleLabel.font          = [UIFont PingFangSC_Medium_WithFontSize:23.f];
    self.titleLabel.centerX       = self.titleContentView.middleX;
    self.titleLabel.textColor     = [UIColor TextMainColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text          = self.title;
    [self.titleContentView addSubview:self.titleLabel];
    
    self.backButton = [[TitleMenuButton alloc] initWithFrame:CGRectMake(0, 0, 100, 64.f) type:TitleMenuButton_Back];
    [self.backButton addTarget:self action:@selector(backButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleContentView addSubview:self.backButton];
}

- (void)setTitle:(NSString *)title {
    
    [super setTitle:title];
    self.titleLabel.text = title;
}

- (void)backButtonEvent:(TitleMenuButton *)button {
    
    if (button.tag == TitleMenuButton_Back) {
        
        [self popViewControllerAnimated:YES];
    }
}

@end
