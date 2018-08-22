//
//  SubtitleArticleEditCell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/27.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Edit_subTitle_1_Cell.h"

@interface Edit_subTitle_1_Cell ()

@property (nonatomic, strong) UILabel *mainContentLabel;

@end

@implementation Edit_subTitle_1_Cell

- (void)buildSubview {
    
    [super buildSubview];
    
    self.mainContentLabel               = [[UILabel alloc] init];
    self.mainContentLabel.font          = [UIFont PingFangSC_Semibold_WithFontSize:19.f];
    self.mainContentLabel.numberOfLines = 2;
    [self.areaView addSubview:self.mainContentLabel];
}

- (void)loadContent {
    
    [super loadContent];
    
    id <ArticleEditObjectProtocol> object = self.data;
    
    self.mainContentLabel.text  = object.cell_text;
    self.mainContentLabel.width = Width - [BaseArticleEditCell rightViewWidth] - 20.f;
    [self.mainContentLabel sizeToFit];
    self.mainContentLabel.left = 10.f;
    self.mainContentLabel.top  = 10.f;
}

+ (CGFloat)cellHeightWithData:(id)data {
    
    id <ArticleEditObjectProtocol> object = data;
    
    CGFloat width         = Width - [BaseArticleEditCell rightViewWidth] - 20.f;
    CGFloat oneLineHeight = [@"我们" heightWithStringFont:[UIFont PingFangSC_Semibold_WithFontSize:19.f]           fixedWidth:width];
    CGFloat totalHeight   = [object.cell_text heightWithStringFont:[UIFont PingFangSC_Semibold_WithFontSize:19.f] fixedWidth:width];
    
    if (totalHeight / oneLineHeight >= 2.f) {
        
        totalHeight = oneLineHeight * 2.f;
    }
    
    return 10 + totalHeight + 10;
}

@end
