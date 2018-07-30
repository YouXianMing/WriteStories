//
//  TapAlphaButton.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/25.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "TapAlphaButton.h"

@implementation TapAlphaButton

- (void)setHighlighted:(BOOL)highlighted {
    
    [super setHighlighted:highlighted];
    
    [UIView animateWithDuration:0.15f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        self.alpha = highlighted ? 0.5f : 1.f;
        
    } completion:nil];
}

- (void)setEnabled:(BOOL)enabled {
    
    [super setEnabled:enabled];
    
    [UIView animateWithDuration:0.15f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        self.alpha = enabled ? 1.f : 0.25f;
        
    } completion:nil];
}

@end
