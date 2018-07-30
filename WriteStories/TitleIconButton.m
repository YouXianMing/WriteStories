//
//  TitleIconButton.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/16.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "TitleIconButton.h"
#import "UIView+SetRect.h"
#import "UIFont+Project.h"
#import "HexColors.h"

@interface TitleIconButton ()

@property (nonatomic, strong) UILabel     *label;
@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation TitleIconButton

- (instancetype)initWithFrame:(CGRect)frame iconType:(TitleIconButtonIconType)iconType {
    
    if (self = [super initWithFrame:frame]) {
        
        self.tag = iconType;
        
        self.label               = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 30)];
        self.label.font          = [UIFont PingFangSC_Light_WithFontSize:9.f];
        self.label.textColor     = [UIColor colorWithHexString:@"#7e7e7e"];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.top           = 40.f;
        [self addSubview:self.label];
        
        if (iconType == TitleIconButtonIconType_InfoEdit) {
            
            self.iconImageView        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"infoEdit"]];
            self.iconImageView.center = CGPointMake(self.middleX, 30.f);
            self.label.text           = @"信息编辑";
            [self addSubview:self.iconImageView];
            
        } else if (iconType == TitleIconButtonIconType_StyleAdjust) {
            
            self.iconImageView        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"styleAdjust"]];
            self.iconImageView.center = CGPointMake(self.middleX, 30.f);
            self.label.text           = @"样式调整";
            [self addSubview:self.iconImageView];
            
        } else if (iconType == TitleIconButtonIconType_StyleManager) {
            
            self.iconImageView        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"styleManager"]];
            self.iconImageView.center = CGPointMake(self.middleX, 30.f);
            self.label.text           = @"样式管理";
            [self addSubview:self.iconImageView];
        }
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
