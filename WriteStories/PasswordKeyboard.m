//
//  PasswordKeyboard.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/1.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "PasswordKeyboard.h"
#import "UIView+SetRect.h"
#import "HexColors.h"
#import "TapAlphaButton.h"

@implementation PasswordKeyboard

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
    
        self.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
        self.itemHeight      = 65.f;
        self.lineColor       = [UIColor.lightGrayColor colorWithAlphaComponent:0.5];
        self.numberFont      = [UIFont systemFontOfSize:24.f];
    }
    
    return self;
}

- (void)buildButtons {

    self.frame        = CGRectMake(0, 0, Width, self.itemHeight * 4.f);
    CGFloat itemWidth = Width / 3.f;
    
    // 按钮
    NSArray   *titles = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0"];
    NSInteger  index  = 0;
    
    for (int line = 0; line < 4; line++) {
        
        for (int column = 0; column < 3; column++) {
            
            if (line == 3 && column == 0) {
                
                continue;
            }
            
            if (line == 3 && column == 2) {
                
                UIButton *button = [[TapAlphaButton alloc] initWithFrame:CGRectMake(column * itemWidth, line * self.itemHeight, itemWidth, self.itemHeight)];
                button.tag       = 11;
                [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                [button addTarget:self action:@selector(buttonsEvent:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:button];
                
                UIImageView *imageView           = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"number-del"]];
                imageView.userInteractionEnabled = NO;
                imageView.center                 = button.middlePoint;
                [button addSubview:imageView];
                
                break;
            }
            
            UIButton *button       = [[TapAlphaButton alloc] initWithFrame:CGRectMake(column * itemWidth, line * self.itemHeight, itemWidth, self.itemHeight)];
            button.titleLabel.font = self.numberFont;
            button.tag             = [titles[index] integerValue];
            [button addTarget:self action:@selector(buttonsEvent:) forControlEvents:UIControlEventTouchUpInside];
            if (button.tag == 0) {
                
                button.tag = 10;
            }
            button.backgroundColor = [UIColor whiteColor];
            [button setTitle:titles[index] forState:UIControlStateNormal];
            [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
            index += 1;
            
            [self addSubview:button];
        }
    }
    
    // 线条
    for (int i = 0; i < 5; i++) {
        
        UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, i * self.itemHeight, Width, 0.5f)];
        line.backgroundColor = self.lineColor;
        [self addSubview:line];
    }
    
    for (int i = 0; i < 2; i++) {
        
        UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(Width / 3.f * (i + 1), 0, 0.5f, self.height)];
        line.backgroundColor = self.lineColor;
        [self addSubview:line];
    }
}

- (void)buttonsEvent:(UIButton *)button {
    
    if (button.tag == 11) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(passwordKeyboardDelete:)]) {
            
            [self.delegate passwordKeyboardDelete:self];
        }
        
    } else {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(passwordKeyboard:selectedNumber:)]) {
            
            [self.delegate passwordKeyboard:self selectedNumber:@(button.tag % 10)];
        }
    }
}

@end
