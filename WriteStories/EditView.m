//
//  EditView.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/16.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "EditView.h"
#import "PointInsideView.h"
#import "DeviceInfo.h"
#import "YXEasing.h"
#import "UIView+SetRect.h"
#import "HexColors.h"
#import "UIButton+Inits.h"
#import "GCD.h"

@interface EditView ()

@end

@implementation EditView

- (instancetype)initWithFrame:(CGRect)frame {
    
    CGFloat bottomSafeHeight = 0;
    if (DeviceInfo.isFringeScreen) {
        
        bottomSafeHeight += DeviceInfo.fringeScreenBottomSafeHeight;
    }
    
    if (self = [super initWithFrame:CGRectMake(0, 0, Width, 300.f + bottomSafeHeight)]) {
        
        self.areaView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 50.f, Width, 250.f + bottomSafeHeight)];
        self.areaView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.areaView];
        
        // 阴影
        UIImageView *shadeImageView           = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width, 2.f)];
        shadeImageView.image                  = [UIImage imageNamed:@"shade-"];
        shadeImageView.bottom                 = 0.f;
        shadeImageView.alpha                  = 0.25f;
        shadeImageView.userInteractionEnabled = NO;
        [self.areaView addSubview:shadeImageView];
    }
    
    return self;
}

- (void)buildSubViews {
    
}

- (void)showInContentView:(UIView *)contentView {
    
    [contentView addSubview:self];
    
    [self buildSubViews];
    
    UIButton *button        = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 90, 45)];
    button.normalImage      = [UIImage imageNamed:@"menuClose"];
    button.highlightedImage = [UIImage imageNamed:@"menuClose-pre"];
    button.right            = Width + 25.f;
    [button addTarget:self action:@selector(hide)];
    [self.areaView addSubview:button];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(editViewWillShow:)]) {
        
        [self.delegate editViewWillShow:self];
    }
    
    // 配置view动画
    self.top                          = contentView.height;
    CGPoint toPoint                   = CGPointMake(self.middleX, contentView.height - self.height / 2.f);
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animation];
    keyAnimation.keyPath              = @"position";
    keyAnimation.duration             = 0.45f;
    keyAnimation.values               = [YXEasing calculateFrameFromPoint:self.center
                                                                  toPoint:toPoint
                                                                     func:ExponentialEaseOut
                                                               frameCount:0.45f * 60];
    self.layer.position = toPoint;
    [self.layer addAnimation:keyAnimation forKey:nil];
    
    {
        UIView *lineView         = [[UIView alloc] initWithFrame:CGRectMake(0, 45.f, Width, 0.5f)];
        lineView.backgroundColor = UIColor.LineColor;
        [self.areaView addSubview:lineView];
    }
    
    [GCDQueue executeInMainQueue:^{
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(editViewDidShow:)]) {
            
            [self.delegate editViewDidShow:self];
        }
        
    } afterDelaySecs:0.45];
}

- (void)hide {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(editViewWillHide:)]) {
        
        [self.delegate editViewWillHide:self];
    }
    
    [UIView animateWithDuration:0.15f animations:^{
        
        self.top  += 10.f;
        self.alpha = 0.f;
        
    } completion:^(BOOL finished) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(editViewDidHide:)]) {
            
            [self.delegate editViewDidHide:self];
        }
        
        [self removeFromSuperview];
    }];
}

#pragma mark - other

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    __block BOOL inside = NO;
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        BOOL contain = CGRectContainsPoint(obj.frame, point);
        if (contain == YES) {
            
            inside = YES;
            *stop  = YES;
        }
    }];
    
    return inside;
}

@end
