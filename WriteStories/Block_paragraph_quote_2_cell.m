
//
//  Block_paragraph_quote_2_cell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/26.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Block_paragraph_quote_2_cell.h"
#import "EdgeInsetsLabel.h"
#import "Block_paragraph_quote_2.h"

static NSString *_demo = @"夫君子之行，静以修身，俭以养德。非淡泊无以明志，非宁静无以致远。夫学须静也，才须学也，非学无以广才，非志无以成学。淫慢则不能励精，险躁则不能冶性。年与时驰，意与日去，遂成枯落，多不接世，悲守穷庐，将复何及！";

@interface Block_paragraph_quote_2_cell ()

@property (nonatomic, strong) EdgeInsetsLabel *contentLabel;

@end

@implementation Block_paragraph_quote_2_cell

- (void)buildSubview {
    
    [super buildSubview];
    
    self.contentLabel                 = [[EdgeInsetsLabel alloc] init];
    self.contentLabel.numberOfLines   = 0;
    self.contentLabel.edgeInsets      = UIEdgeInsetsMake(5, 10, 5, 10);
    // self.contentLabel.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
    self.contentLabel.font            = [UIFont PingFangSC_Light_WithFontSize:13.f];
    self.contentLabel.width           = Width - 120.f;
    self.contentLabel.textColor       = [UIColor colorWithHexString:@"#8c8c8c"];
    [self.contentLabel sizeToFitWithText:_demo];
    [self.contentView addSubview:self.contentLabel];
    
    self.contentLabel.left = 60.f;
    self.contentLabel.top  = 18.f;
    
    UIImageView *maskImageView = [[UIImageView alloc] initWithFrame:CGRectInset(self.contentLabel.frame, -10, -10)];
    maskImageView.alpha        = 0.2f;
    maskImageView.image        = [[UIImage imageNamed:@"quote_1_cell"] resizableImageWithCapInsets:UIEdgeInsetsMake(30, 30, 30, 30)];
    [self.contentView addSubview:maskImageView];
}

- (void)loadContent {
    
    [super loadContent];
}

- (BaseBlockItem *)blockItem {
    
    return [Block_paragraph_quote_2 defalutObject];
}

+ (CGFloat)cellHeightWithData:(id)data {
    
    return  18.f + [_demo heightWithStringFont:[UIFont PingFangSC_Light_WithFontSize:13.f] fixedWidth:Width - 120.f - 20.f] + 18.f + 10.f;
}

@end
