//
//  SubTitleNormal_1_Cell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/27.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Block_subtitle_normal_1_cell.h"
#import "Block_subtitle_normal_1.h"

@interface Block_subtitle_normal_1_cell ()

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation Block_subtitle_normal_1_cell

- (void)buildSubview {
    
    [super buildSubview];
    
    self.contentLabel         = [[UILabel alloc] init];
    self.contentLabel.font    = [UIFont PingFangSC_Semibold_WithFontSize:18.f];
    self.contentLabel.text    = @"小标题";
    [self.contentLabel sizeToFit];
    self.contentLabel.left    = 10.f;
    self.contentLabel.centerY = 45 / 2.f;
    [self.contentView addSubview:self.contentLabel];
}

- (void)loadContent {
    
    [super loadContent];
}

+ (CGFloat)cellHeightWithData:(id)data {
    
    return  45.f;
}

- (BaseBlockItem *)blockItem {
    
    return [Block_subtitle_normal_1 defalutObject];
}

@end
