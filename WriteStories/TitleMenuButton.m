//
//  TitleMenuButton.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/24.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "TitleMenuButton.h"
#import "UIView+SetRect.h"

@interface TitleMenuButton ()

@property (nonatomic)         TitleMenuButtonType  type;
@property (nonatomic, strong) UIImageView         *iconImageView;

@end

@implementation TitleMenuButton

- (instancetype)initWithFrame:(CGRect)frame type:(TitleMenuButtonType)type {
    
    if (self = [super initWithFrame:frame]) {
    
        self.tag  = type;
        self.type = type;
        
        if (type == TitleMenuButton_Back) {
            
            self.iconImageView                        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"titleMenuBackButton"]];
            self.iconImageView.userInteractionEnabled = NO;
            self.iconImageView.left                   = 15.f;
            self.iconImageView.centerY                = self.middleY;
            [self addSubview:self.iconImageView];
            
        } else if (type == TitleMenuButton_Close) {
            
            self.iconImageView                        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"titleMenuClose"]];
            self.iconImageView.userInteractionEnabled = NO;
            self.iconImageView.left                   = 15.f;
            self.iconImageView.centerY                = self.middleY;
            [self addSubview:self.iconImageView];
            
        } else if (type == TitleMenuButton_Setup) {
            
            self.iconImageView                        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MenuSetupButton"]];
            self.iconImageView.userInteractionEnabled = NO;
            self.iconImageView.right                  = self.width - 15.f;
            self.iconImageView.centerY                = self.middleY;
            [self addSubview:self.iconImageView];
            
        } else if (type == TitleMenuButton_More) {
            
            self.iconImageView                        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"titleMenuMoreButton"]];
            self.iconImageView.userInteractionEnabled = NO;
            self.iconImageView.right                  = self.width - 15.f;
            self.iconImageView.centerY                = self.middleY;
            [self addSubview:self.iconImageView];
            
        } else if (type == TitleMenuButton_Save) {
            
            self.iconImageView                        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"titleButtonSave"]];
            self.iconImageView.userInteractionEnabled = NO;
            self.iconImageView.right                  = self.width - 15.f;
            self.iconImageView.centerY                = self.middleY;
            [self addSubview:self.iconImageView];
            
        } else if (type == TitleMenuButton_Wifi) {
            
            self.iconImageView                        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wifi"]];
            self.iconImageView.userInteractionEnabled = NO;
            self.iconImageView.right                  = self.width - 15.f;
            self.iconImageView.centerY                = self.middleY;
            [self addSubview:self.iconImageView];
        }
    }
    
    return self;
}

#pragma mark - Overwrite methods.

- (void)setHighlighted:(BOOL)highlighted {
    
    [super setHighlighted:highlighted];
    
    [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        if (self.type == TitleMenuButton_Back ||
            self.type == TitleMenuButton_Close ||
            self.type == TitleMenuButton_Setup ||
            self.type == TitleMenuButton_More ||
            self.type == TitleMenuButton_Save ||
            self.type == TitleMenuButton_Wifi) {
            
            self.iconImageView.alpha = highlighted ? 0.5f : 1.f;
        }
        
    } completion:nil];
}

- (void)setEnabled:(BOOL)enabled {
    
    [super setEnabled:enabled];
    
    [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        if (self.type == TitleMenuButton_Back ||
            self.type == TitleMenuButton_Close ||
            self.type == TitleMenuButton_Setup ||
            self.type == TitleMenuButton_More ||
            self.type == TitleMenuButton_Save ||
            self.type == TitleMenuButton_Wifi) {
            
            self.iconImageView.alpha = enabled ? 1.f : 0.25f;
        }
        
    } completion:nil];
}

@end
