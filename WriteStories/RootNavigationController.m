//
//  RootNavigationController.m
//  WriteStories
//
//  Created by YouXianMing on 2018/5/24.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "RootNavigationController.h"
#import "AppleSystemService.h"
#import "UIView+AnimationProperty.h"

@interface RootNavigationController ()

@end

@implementation RootNavigationController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // LaunchImage
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    iconImageView.image        = AppleSystemService.launchImage;
    [self.view addSubview:iconImageView];
    
    // Do animation
    [UIView animateKeyframesWithDuration:0.75 delay:1.f options:0 animations:^{
        
        iconImageView.scale = 1.2f;
        iconImageView.alpha = 0.f;
        
    } completion:^(BOOL finished) {
        
        [iconImageView removeFromSuperview];
    }];
}

@end
