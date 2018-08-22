//
//  ItemAddCell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/25.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "ItemAddCell.h"
#import "UIButton+Inits.h"
#import "UIView+SetRect.h"

@implementation ItemAddCell

- (void)setupCell {
    
    self.backgroundColor = [UIColor clearColor];
}

- (void)buildSubview {
    
    UIButton *button        = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 38.f)];
    button.normalImage      = [UIImage imageNamed:@"add-cell"];
    button.highlightedImage = [UIImage imageNamed:@"add-cell-pre"];
    button.center           = CGPointMake(Width / 2.f, 38.f / 2.f);
    [button addTarget:self action:@selector(buttonEvent)];
    [self.contentView addSubview:button];
}

+ (CGFloat)cellHeightWithData:(id)data {
    
    return 38.f;
}

- (void)buttonEvent {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customCell:event:)]) {
        
        [self.delegate customCell:self event:nil];
    }
}

@end
