//
//  StoreButtonsView.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/5.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "StoreButtonsView.h"
#import "HexColors.h"
#import "UIColor+Project.h"
#import "UIFont+Project.h"
#import "UIView+SetRect.h"
#import "UIButton+Inits.h"
#import "GCD.h"

@interface StoreButton : UIButton

@property (nonatomic, strong) NSString *contentTitle;
@property (nonatomic, strong) UILabel  *contentLabel;
@property (nonatomic, strong) UIView   *backgroundView;

@end

@implementation StoreButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
    
        self.backgroundView                 = [[UIView alloc] initWithFrame:self.bounds];
        self.backgroundView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.backgroundView];
        
        self.contentLabel               = [[UILabel alloc] initWithFrame:self.bounds];
        self.contentLabel.textAlignment = NSTextAlignmentCenter;
        self.contentLabel.font          = [UIFont PingFangSC_Light_WithFontSize:16.f];
        self.contentLabel.textColor     = [UIColor blackColor];
        [self addSubview:self.contentLabel];
        
        self.contentLabel.userInteractionEnabled   = NO;
        self.backgroundView.userInteractionEnabled = NO;
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected {
    
    [super setSelected:selected];
    
    [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        self.contentLabel.alpha             = selected ? 0.4f : 1.f;
        self.backgroundView.backgroundColor = selected ? [UIColor colorWithHexString:@"#f1f1f0"] : [UIColor clearColor];
        
    } completion:nil];
}

- (void)setContentTitle:(NSString *)contentTitle {
    
    _contentTitle          = contentTitle;
    self.contentLabel.text = contentTitle;
}

@end

/////////////////////////////////////////////////////////////////////////////

@interface StoreButtonsView ()

@end

@implementation StoreButtonsView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithHexString:@"#FCFCFC"];
        
        CGFloat buttonWidth = self.width / 3.f;
        
        NSArray *titles = @[@"文件夹模板", @"文章标签模板", @"背景样式"];
        [titles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
            
            StoreButton *button = [[StoreButton alloc] initWithFrame:CGRectMake(buttonWidth * idx, 0, buttonWidth, self.height)];
            button.tag          = 1000 + idx;
            button.contentTitle = title;
            [button addTarget:self action:@selector(buttonsEvent:)];
            [self addSubview:button];
        }];
        
        UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 0.5f, self.width, 0.5f)];
        line.backgroundColor = [UIColor.LineColor colorWithAlphaComponent:0.5f];
        [self addSubview:line];
        
        UIView *leftLine         = [[UIView alloc] initWithFrame:CGRectMake(self.width / 3.f, 0, 0.5f, self.height)];
        leftLine.backgroundColor = UIColor.LineColor;
        [self addSubview:leftLine];
        
        UIView *rightLine         = [[UIView alloc] initWithFrame:CGRectMake(self.width / 3.f * 2.f, 0, 0.5f, self.height)];
        rightLine.backgroundColor = UIColor.LineColor;
        [self addSubview:rightLine];
    }
    
    return self;
}

- (void)buttonsEvent:(UIButton *)button {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(storeButtonsView:selected:)]) {
        
        [self.delegate storeButtonsView:self selected:button.tag - 1000];
    }
    
    NSArray *tags = @[@(1000), @(1001), @(1002)];
    [tags enumerateObjectsUsingBlock:^(NSNumber *tag, NSUInteger idx, BOOL * _Nonnull stop) {
        
        StoreButton *tmpButton = [self viewWithTag:tag.integerValue];
        if (tag.integerValue == button.tag) {
            
            tmpButton.selected = YES;
            
        } else {
            
            tmpButton.selected = NO;
        }
        
        tmpButton.enabled = NO;
        [GCDQueue executeInMainQueue:^{
            
            tmpButton.enabled = YES;
            
        } afterDelaySecs:0.25f];
    }];
}

- (void)setSelectedItem:(StoreViewControllerSelectedItem)selectedItem {
   
    _selectedItem = selectedItem;
    
    NSArray *tags = @[@(1000), @(1001), @(1002)];
    [tags enumerateObjectsUsingBlock:^(NSNumber *tag, NSUInteger idx, BOOL * _Nonnull stop) {
        
        StoreButton *button = [self viewWithTag:tag.integerValue];
        if (tag.integerValue - 1000 == selectedItem) {
            
            button.selected = YES;
            
        } else {
            
            button.selected = NO;
        }
    }];
}

@end
