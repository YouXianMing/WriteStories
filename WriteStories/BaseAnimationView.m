//
//  BaseAnimationView.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/27.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseAnimationView.h"

@implementation BaseAnimationView

+ (BaseAnimationView *)defaultView {
    
    BaseAnimationView *animationView = [[self alloc] initWithFrame:CGRectMake(0, 0, Width, 0)];
    [animationView buildSubViews];
        
    return animationView;
}

- (void)buildSubViews {
    
}

- (void)didUpdateFrame {
    
}

@end
