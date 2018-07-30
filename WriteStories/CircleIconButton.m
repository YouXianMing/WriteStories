//
//  CircleIconButton.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/25.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "CircleIconButton.h"
#import "UIView+SetRect.h"

@interface CircleIconButton ()

@property (nonatomic, strong) UIImageView *circleImageView;
@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation CircleIconButton

- (instancetype)initWithType:(CircleIconButtonType)type {
    
    if (self = [super initWithFrame:CGRectMake(0, 0, 50, 50)]) {
    
        self.tag = type;
        
        self.circleImageView                        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle-button-bg"]];
        self.circleImageView.center                 = self.middlePoint;
        self.circleImageView.userInteractionEnabled = NO;
        [self addSubview:self.circleImageView];
        
        if (type == CircleIconButtonType_Back) {
            
            self.iconImageView                        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle-button-back"]];
            self.iconImageView.userInteractionEnabled = NO;
            self.iconImageView.centerY                = self.middleY;
            self.iconImageView.x                      = 16.f;
            [self addSubview:self.iconImageView];
            
        } else if (type == CircleIconButtonType_Edit) {
            
            self.iconImageView                        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle-button-edit"]];
            self.iconImageView.userInteractionEnabled = NO;
            self.iconImageView.centerY                = self.middleY;
            self.iconImageView.x                      = 14.f;
            [self addSubview:self.iconImageView];
            
        } else if (type == CircleIconButtonType_Close) {
            
            self.iconImageView                        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"titleMenuCloseVer2"]];
            self.iconImageView.userInteractionEnabled = NO;
            self.iconImageView.center                 = self.middlePoint;
            self.iconImageView.x                      = 14.f;
            [self addSubview:self.iconImageView];
            
        } else if (type == CircleIconButtonType_More) {
            
            self.iconImageView                        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle-button-more"]];
            self.iconImageView.userInteractionEnabled = NO;
            self.iconImageView.center                 = self.middlePoint;
            [self addSubview:self.iconImageView];
            
        } else if (type == CircleIconButtonType_See) {
            
            self.iconImageView                        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle-button-see"]];
            self.iconImageView.userInteractionEnabled = NO;
            self.iconImageView.center                 = self.middlePoint;
            [self addSubview:self.iconImageView];
            
        } else if (type == CircleIconButtonType_Background) {
            
            self.iconImageView                        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"html-set-background"]];
            self.iconImageView.userInteractionEnabled = NO;
            self.iconImageView.center                 = self.middlePoint;
            [self addSubview:self.iconImageView];
        }
    }
    
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {
    
    [super setHighlighted:highlighted];
    
    [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        self.circleImageView.alpha = highlighted ? 0.5f : 1.f;
        self.iconImageView.alpha   = highlighted ? 0.5f : 1.f;
        
    } completion:nil];
}

- (void)setEnabled:(BOOL)enabled {
    
    [super setEnabled:enabled];
    
    [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        self.circleImageView.alpha = enabled ? 1.f : 0.25f;
        self.iconImageView.alpha   = enabled ? 1.f : 0.25f;
        
    } completion:nil];
}

@end
