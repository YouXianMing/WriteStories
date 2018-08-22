//
//  MarkSortCell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/19.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "MarkSortCell.h"
#import "BaseMarkItem.h"
#import "UIColor+Project.h"
#import "UIFont+Project.h"
#import "UIView+SetRect.h"

@interface MarkSortCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation MarkSortCell

- (void)buildSubview {
    
    self.titleLabel      = [[UILabel alloc] initWithFrame:CGRectMake(15.f, 0, Width - 70.f, 75)];
    self.titleLabel.font = [UIFont PingFangSC_Regular_WithFontSize:25.f];
    [self.contentView addSubview:self.titleLabel];
    
    UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, 74.5, Width, 0.5f)];
    line.backgroundColor = UIColor.LineColor;
    [self.contentView addSubview:line];
}

- (void)loadContent {
    
    BaseMarkItem *item = self.data;
    self.titleLabel.text = item.title;
}
@end
