//
//  ParagraphArticleEditCell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/26.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Edit_paragraph_1_Cell.h"

@interface Edit_paragraph_1_Cell ()

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation Edit_paragraph_1_Cell

- (void)buildSubview {
    
    [super buildSubview];
    
    self.contentLabel               = [[UILabel alloc] init];
    self.contentLabel.textColor     = [UIColor colorWithHexString:@"#010101"];
    self.contentLabel.font          = [UIFont PingFangSC_Regular_WithFontSize:14.f];
     self.contentLabel.numberOfLines = 4;
    [self.contentView addSubview:self.contentLabel];
}

- (void)loadContent {
    
    [super loadContent];
    
    id <ArticleEditObjectProtocol> object = self.data;
    
    self.contentLabel.text  = object.cell_text;
    self.contentLabel.width = self.areaView.width - 20.f;
    [self.contentLabel sizeToFit];
    self.contentLabel.left = 10.f;
    self.contentLabel.top  = 10.f;
}

+ (CGFloat)cellHeightWithData:(id)data {
    
    id <ArticleEditObjectProtocol> object = data;
    
    CGFloat width         = Width - [BaseArticleEditCell rightViewWidth] - 20.f;
    CGFloat oneLineHeight = [@"我们" heightWithStringFont:[UIFont PingFangSC_Regular_WithFontSize:14.f]           fixedWidth:width];
    CGFloat totalHeight   = [object.cell_text heightWithStringFont:[UIFont PingFangSC_Regular_WithFontSize:14.f] fixedWidth:width];
    
    if (totalHeight / oneLineHeight >= 4.f) {
        
        totalHeight = oneLineHeight * 4.f;
    }
    
    return 10 + totalHeight + 10;
}

@end
