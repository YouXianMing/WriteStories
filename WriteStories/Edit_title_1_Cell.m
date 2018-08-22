//
//  TitleArticleEditCell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/27.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Edit_title_1_Cell.h"

@interface Edit_title_1_Cell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation Edit_title_1_Cell

- (void)buildSubview {
    
    [super buildSubview];
    
    self.titleLabel               = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, Width - 80.f, [Edit_title_1_Cell cellHeightWithData:nil])];
    self.titleLabel.font          = [UIFont PingFangSC_Semibold_WithFontSize:25.f];
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];
}

- (void)loadContent {
    
    [super loadContent];
    
    self.edgeLabel.hidden          = YES;
    self.deleteButton.hidden       = YES;
    self.rightView.backgroundColor = UIColor.clearColor;
    
    id <ArticleEditObjectProtocol> object = self.data;
    self.titleLabel.text = object.cell_text;
}

+ (CGFloat)cellHeightWithData:(id)data {
    
    return 140.f;
}

@end
