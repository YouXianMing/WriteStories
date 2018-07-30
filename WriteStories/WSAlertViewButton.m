//
//  WSAlertViewButton.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/20.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "WSAlertViewButton.h"
#import "UIView+SetRect.h"
#import "UIFont+Project.h"

@interface WSAlertViewButton ()

@property (nonatomic, strong) UILabel               *contentLabel;
@property (nonatomic, strong) WSAlertViewButtonInfo *buttonInfo;

@end

@implementation WSAlertViewButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
    
        self.contentLabel               = [[UILabel alloc] initWithFrame:self.bounds];
        self.contentLabel.textAlignment = NSTextAlignmentCenter;
        self.contentLabel.font          = [UIFont PingFangSC_Regular_WithFontSize:21.f];
        [self addSubview:self.contentLabel];
    }
    
    return self;
}

- (void)use:(WSAlertViewButtonInfo *)buttonInfo {
    
    self.buttonInfo        = buttonInfo;
    self.contentLabel.text = buttonInfo.title;
    
    if (buttonInfo.type == WSAlertViewButtonTypeCancel) {
        
        self.contentLabel.textColor = [UIColor blackColor];
        self.contentLabel.alpha     = 0.2f;
        
    } else {
        
        self.contentLabel.textColor = [UIColor whiteColor];
        self.contentLabel.alpha     = 1.f;
    }
}

- (void)setHighlighted:(BOOL)highlighted {
    
    [super setHighlighted:highlighted];
    
    [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        self.alpha = highlighted ? 0.5f : 1.f;
        
    } completion:nil];
}

@end
