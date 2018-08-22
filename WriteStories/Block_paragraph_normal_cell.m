//
//  ParagraphStyleNormalCell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/26.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Block_paragraph_normal_cell.h"
#import "Block_paragraph_normal.h"

static NSString *_demo = @"夫君子之行，静以修身，俭以养德。非淡泊无以明志，非宁静无以致远。夫学须静也，才须学也，非学无以广才，非志无以成学。淫慢则不能励精，险躁则不能冶性。年与时驰，意与日去，遂成枯落，多不接世，悲守穷庐，将复何及！";

@interface Block_paragraph_normal_cell ()

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation Block_paragraph_normal_cell

- (void)buildSubview {
    
    [super buildSubview];

    self.contentLabel               = [[UILabel alloc] init];
    self.contentLabel.text          = _demo;
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.font          = [UIFont PingFangSC_Light_WithFontSize:16.f];
    self.contentLabel.width         = Width - 20.f;
    [self.contentLabel sizeToFit];
    [self.contentView addSubview:self.contentLabel];
    
    self.contentLabel.left = 12.f;
    self.contentLabel.top  = 12.f;
}

- (void)loadContent {
    
    [super loadContent];
}

+ (CGFloat)cellHeightWithData:(id)data {

    return  12.f + [_demo heightWithStringFont:[UIFont PingFangSC_Light_WithFontSize:16.f] fixedWidth:Width - 20.f] + 12.f;
}

- (BaseBlockItem *)blockItem {
    
    return [Block_paragraph_normal defalutObject];
}

@end
