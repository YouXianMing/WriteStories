//
//  ItemHeaderView.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/17.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "ItemHeaderView.h"
#import "ItemsHeader.h"
#import "StyleAdjustEditView.h"

@interface ItemHeaderView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ItemHeaderView

- (void)setupHeaderFooterView {
    
    [self setHeaderFooterViewBackgroundColor:[UIColor whiteColor]];
}

- (void)buildSubview {
    
    UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, 22.5f, StyleAdjustEditView.StyleAdjustEditViewLeftLineGap, 0.5f)];
    line.backgroundColor = UIColor.LineColor;
    [self.contentView addSubview:line];
    
    self.titleLabel           = [[UILabel alloc] initWithFrame:CGRectMake(7.f, 0, StyleAdjustEditView.StyleAdjustEditViewLeftLineGap - 2, 23.f)];
    self.titleLabel.font      = [UIFont PingFangSC_Regular_WithFontSize:10.f];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"#7e7e7e"];
    [self.contentView addSubview:self.titleLabel];
    
    UIView *colorBlock         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 3.f, 11.f)];
    colorBlock.backgroundColor = [UIColor colorWithHexString:@"#7e7e7e"];
    colorBlock.centerY         = 23 / 2.f;
    [self.contentView addSubview:colorBlock];
}

- (void)loadContent {
    
    ItemsHeader *header  = self.data;
    self.titleLabel.text = header.title;
}

@end
