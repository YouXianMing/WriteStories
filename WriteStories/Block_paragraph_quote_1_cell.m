//
//  ParagraphStyleQuote_1_Cell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/26.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "Block_paragraph_quote_1_cell.h"
#import "EdgeInsetsLabel.h"
#import "Block_paragraph_quote_1.h"

static NSString *_demo = @"夫君子之行，静以修身，俭以养德。非淡泊无以明志，非宁静无以致远。夫学须静也，才须学也，非学无以广才，非志无以成学。淫慢则不能励精，险躁则不能冶性。年与时驰，意与日去，遂成枯落，多不接世，悲守穷庐，将复何及！";

@interface Block_paragraph_quote_1_cell ()

@property (nonatomic, strong) EdgeInsetsLabel *contentLabel;

@end

@implementation Block_paragraph_quote_1_cell

- (void)buildSubview {
    
    [super buildSubview];
    
    self.contentLabel                 = [[EdgeInsetsLabel alloc] init];
    self.contentLabel.numberOfLines   = 0;
    self.contentLabel.edgeInsets      = UIEdgeInsetsMake(5, 10, 5, 10);
    self.contentLabel.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
    self.contentLabel.font            = [UIFont PingFangSC_Light_WithFontSize:13.f];
    self.contentLabel.width           = Width - 120.f;
    self.contentLabel.textColor       = [UIColor colorWithHexString:@"#8c8c8c"];
    [self.contentLabel sizeToFitWithText:_demo];
    [self.contentView addSubview:self.contentLabel];
    
    self.contentLabel.left = 60.f;
    self.contentLabel.top  = 12.f;
    
    UIView *lineView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8.f, self.contentLabel.height)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#d5d5d5"];
    lineView.right           = self.contentLabel.left;
    lineView.top             = self.contentLabel.top;
    [self.contentView addSubview:lineView];
}

- (void)loadContent {
    
    [super loadContent];
}

- (BaseBlockItem *)blockItem {
    
    return [Block_paragraph_quote_1 defalutObject];
}

+ (CGFloat)cellHeightWithData:(id)data {
    
    return  12.f + [_demo heightWithStringFont:[UIFont PingFangSC_Light_WithFontSize:13.f] fixedWidth:Width - 120.f - 20.f] + 12.f + 10.f;
}

@end
