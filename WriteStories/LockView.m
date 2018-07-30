//
//  LockView.m
//  LockButton
//
//  Created by YouXianMing on 2018/1/16.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "LockView.h"
#import "UIView+SetRect.h"

@interface LockView ()

@property (nonatomic, strong) UIView      *upView;
@property (nonatomic, strong) UIView      *contentView;

@property (nonatomic, strong) UIImageView *upLockView;
@property (nonatomic, strong) UIImageView *downLockView;

@end

@implementation LockView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
    
        self.contentView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:self.contentView];
        
        self.upView               = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height / 2.f)];
        self.upView.clipsToBounds = YES;
        [self.contentView addSubview:self.upView];
        
        self.upLockView         = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lock_up"]];
        self.upLockView.centerX = self.upView.middleX;
        [self.upView addSubview:self.upLockView];
        
        self.downLockView         = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lock_down"]];
        self.downLockView.top     = self.height / 2.f;
        self.downLockView.centerX = self.middleX;
        [self.contentView addSubview:self.downLockView];
    }
    
    return self;
}

- (void)changeToState:(ELockViewState)state animated:(BOOL)animated {

    [UIView animateWithDuration:animated ? 0.25f : 0.f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        if (state == ELockViewStateUnlock) {
            
            self.upLockView.bottom = self.upView.height - 0.f;
            self.contentView.top   = 2.f;
            self.alpha             = 0.45;
            
        } else if (state == ELockViewStateLock) {
            
            self.upLockView.bottom = self.upView.height + 4.f;
            self.contentView.top   = 0.f;
            self.alpha             = 0.25;
        }
        
    } completion:nil];
}

@end
