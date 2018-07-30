//
//  SheetMenuButton.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/15.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "SheetMenuButton.h"
#import "UIView+SetRect.h"
#import "UIFont+Project.h"
#import "HexColors.h"

@interface SheetMenuButton ()

@property (nonatomic, strong) UILabel     *label;
@property (nonatomic, strong) UILabel     *highlightLabel;
@property (nonatomic, strong) UIImageView *backgroundImageView;

@end

@implementation SheetMenuButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundImageView       = [[UIImageView alloc] initWithFrame:self.bounds];
        self.backgroundImageView.image = [UIImage imageNamed:@"menuButtonBG"];
        self.backgroundImageView.alpha = 0.f;
        [self addSubview:self.backgroundImageView];
        
        self.label           = [[UILabel alloc] initWithFrame:self.bounds];
        self.label.left      = 30.f;
        self.label.textColor = [UIColor colorWithHexString:@"#212121"];
        self.label.font      = [UIFont PingFangSC_Medium_WithFontSize:22.f];
        [self addSubview:self.label];
        
        self.highlightLabel           = [[UILabel alloc] initWithFrame:self.bounds];
        self.highlightLabel.left      = 30.f;
        self.highlightLabel.textColor = [UIColor whiteColor];
        self.highlightLabel.font      = [UIFont PingFangSC_Medium_WithFontSize:22.f];
        self.highlightLabel.alpha     = 0.f;
        [self addSubview:self.highlightLabel];
    }
    
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {
    
    [super setHighlighted:highlighted];
    
    [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        self.label.alpha               = highlighted ? 0 : 1.f;
        self.highlightLabel.alpha      = highlighted ? 1 : 0.f;
        self.backgroundImageView.alpha = highlighted ? 1 : 0.f;
        
    } completion:nil];
}

- (void)setTitle:(NSString *)title {
    
    self.label.text          = title;
    self.highlightLabel.text = title;
}

@end
