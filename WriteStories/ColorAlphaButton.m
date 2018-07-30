//
//  ColorAlphaButton.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/17.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "ColorAlphaButton.h"

@implementation ColorAlphaButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
    
        self.layer.cornerRadius  = 4.f;
        self.layer.masksToBounds = YES;
    }
    
    return self;
}

#pragma mark - Overwrite methods.

- (void)setHighlighted:(BOOL)highlighted {
    
    [super setHighlighted:highlighted];
    
    [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        self.alpha = highlighted ? 0.5f : 1.f;
        
    } completion:nil];
}

@end
