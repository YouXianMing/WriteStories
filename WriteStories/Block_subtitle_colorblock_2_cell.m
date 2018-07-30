//
//  Block_subtitle_colorblock_2_cell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/10.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Block_subtitle_colorblock_2_cell.h"
#import "Block_subtitle_colorblock_2.h"

@interface Block_subtitle_colorblock_2_cell ()

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation Block_subtitle_colorblock_2_cell

- (void)buildSubview {
    
    [super buildSubview];
    
    self.contentLabel         = [[UILabel alloc] init];
    self.contentLabel.font    = [UIFont PingFangSC_Semibold_WithFontSize:18.f];
    self.contentLabel.text    = @"小标题";
    [self.contentLabel sizeToFit];
    self.contentLabel.left    = 20.f;
    self.contentLabel.centerY = 45 / 2.f;
    [self.contentView addSubview:self.contentLabel];
    
    UIView *leftRedView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 19.f)];
    leftRedView.backgroundColor = UIColor.redColor;
    [self.contentView addSubview:leftRedView];

    leftRedView.centerY = 45 / 2.f;
    leftRedView.left    = 10.f;
    
    UIView *rightRedView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 19.f)];
    rightRedView.backgroundColor = UIColor.redColor;
    [self.contentView addSubview:rightRedView];
    
    rightRedView.centerY = 45 / 2.f;
    rightRedView.left    = self.contentLabel.right + 5;
}

- (void)loadContent {
    
    [super loadContent];
}

+ (CGFloat)cellHeightWithData:(id)data {
    
    return  45.f;
}

- (BaseBlockItem *)blockItem {
    
    return [Block_subtitle_colorblock_2 defalutObject];
}

@end
