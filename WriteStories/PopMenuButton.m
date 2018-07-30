//
//  PopMenuButton.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/15.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "PopMenuButton.h"
#import "UIView+SetRect.h"
#import "UIFont+Project.h"
#import "HexColors.h"

@interface PopMenuButton ()

@property (nonatomic)         PopMenuButtonTitleType titleType;
@property (nonatomic)         PopMenuButtonIconType  iconType;
@property (nonatomic, strong) NSString              *title;

@property (nonatomic, strong) UILabel     *contentLabel;
@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation PopMenuButton

- (instancetype)initWithFrame:(CGRect)frame icon:(PopMenuButtonIconType)icon titleType:(PopMenuButtonTitleType)titleType title:(NSString *)title {
    
    if (self = [super initWithFrame:frame]) {
    
        self.tag       = icon;
        self.title     = title;
        self.iconType  = icon;
        self.titleType = titleType;
        
        if (icon == PopMenuButtonIconTypeAdd) {
            
            self.iconImageView        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"popMenuAdd"]];
            self.iconImageView.center = CGPointMake(27.f, self.middleY);
            self.iconImageView.userInteractionEnabled = NO;
            
            [self addSubview:self.iconImageView];
            
        } else if (icon == PopMenuButtonIconTypeSort) {
            
            self.iconImageView        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"popMenuButtonSort"]];
            self.iconImageView.center = CGPointMake(27.f, self.middleY);
            self.iconImageView.userInteractionEnabled = NO;
            
            [self addSubview:self.iconImageView];
            
        } else if (icon == PopMenuButtonIconTypeChange) {
            
            self.iconImageView        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"change-top-title"]];
            self.iconImageView.center = CGPointMake(27.f, self.middleY);
            self.iconImageView.userInteractionEnabled = NO;
            
            [self addSubview:self.iconImageView];
            
        } else if (icon == PopMenuButtonIconTypeLoadFile) {
            
            self.iconImageView        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"file-load"]];
            self.iconImageView.center = CGPointMake(27.f, self.middleY);
            self.iconImageView.userInteractionEnabled = NO;
            
            [self addSubview:self.iconImageView];
            
        } else if (icon == PopMenuButtonIconTypeBackgroundAdjust) {
            
            self.iconImageView        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"styleAdjust"]];
            self.iconImageView.center = CGPointMake(27.f, self.middleY);
            self.iconImageView.userInteractionEnabled = NO;
            
            [self addSubview:self.iconImageView];
            
        } else if (icon == PopMenuButtonIconTypeBackgroundManager) {
            
            self.iconImageView        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"styleManager"]];
            self.iconImageView.center = CGPointMake(27.f, self.middleY);
            self.iconImageView.userInteractionEnabled = NO;
            
            [self addSubview:self.iconImageView];
            
        } else if (icon == PopMenuButtonIconTypeAnimationSet) {
            
            self.iconImageView        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"animation"]];
            self.iconImageView.center = CGPointMake(27.f, self.middleY);
            self.iconImageView.userInteractionEnabled = NO;
            
            [self addSubview:self.iconImageView];
        }
        
        self.contentLabel = [UILabel new];
        self.contentLabel.userInteractionEnabled = NO;
        if (titleType == PopMenuButtonTitleTypeCyanBold) {
            
            self.contentLabel.font = [UIFont PingFangSC_Semibold_WithFontSize:17.f];
            self.contentLabel.textColor = [UIColor colorWithHexString:@"#38a1dd"];
            
        } else {
            
            self.contentLabel.font = [UIFont PingFangSC_Light_WithFontSize:17.f];
            self.contentLabel.textColor = [UIColor blackColor];
        }
        
        self.contentLabel.text = title;
        [self.contentLabel sizeToFit];
        self.contentLabel.left    = 52.f;
        self.contentLabel.centerY = self.middleY;
        [self addSubview:self.contentLabel];
    }
    
    return self;
}

- (CGFloat)effectiveWidth {
    
    return self.contentLabel.right + 20.f;
}

- (void)setHighlighted:(BOOL)highlighted {
    
    [super setHighlighted:highlighted];
    
    [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        self.alpha = highlighted ? 0.5 : 1.f;
        
    } completion:nil];
}


@end
