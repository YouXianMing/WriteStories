//
//  BaseItemSetupView.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/17.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseItemSetupView.h"

@implementation BaseItemSetupView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.layer.masksToBounds = YES;
    }
    
    return self;
}

- (void)buildSubViews {
    
}

@end
