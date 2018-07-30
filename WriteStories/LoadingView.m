//
//  LoadingView.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/16.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "LoadingView.h"
#import "UIView+SetRect.h"
#import "InfiniteRotationView.h"
#import "UIView+AnimationProperty.h"

@interface LoadingView ()

@property (nonatomic, weak)   UIWindow     *keyWindow;
@property (nonatomic, strong) UIImageView  *imageView;

@end

@implementation LoadingView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self.keyWindow = [UIApplication sharedApplication].keyWindow;
    
    if (self = [super initWithFrame:self.keyWindow.bounds]) {
        
        self.alpha = 0.f;
    }
    
    return self;
}

- (void)startLoading {
    
    [self.keyWindow addSubview:self];
    
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    centerView.center  = self.middlePoint;
    [self addSubview:centerView];
    
    InfiniteRotationView *rotateView = [[InfiniteRotationView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    rotateView.speed                 = 0.95f;
    rotateView.clockWise             = YES;
    [rotateView startRotateAnimation];
    [centerView addSubview:rotateView];
    
    static NSInteger count = 1;
    
    UILabel *label  = [UILabel new];
    label.text      = count ++ % 2 ? @"美" : @"记";
    label.font      = [UIFont fontWithName:@"AaFangMeng" size:20];
    label.textColor = [UIColor lightGrayColor];
    [label sizeToFit];
    label.center = centerView.middlePoint;
    [centerView addSubview:label];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    imageView.image        = [UIImage imageNamed:@"loadingCircle"];
    imageView.center       = rotateView.middlePoint;
    imageView.angle        = (arc4random() % 100) / M_PI_2;
    [rotateView addSubview:imageView];
    
    [UIView animateWithDuration:0.45 delay:0.f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        self.alpha = 1.f;
        
    } completion:^(BOOL finished) {
        
        
    }];
}

- (void)stopLoading {
    
    [UIView animateWithDuration:0.45 delay:0.f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        self.alpha = 0.f;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

+ (instancetype)loadingViewStartLoadingInKeyWindow {
    
    LoadingView *loadingView = [LoadingView new];
    [loadingView startLoading];
    
    return loadingView;
}

@end
