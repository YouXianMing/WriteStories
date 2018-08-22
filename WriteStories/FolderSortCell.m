//
//  FolderSortCell.m
//  WriteStories
//
//  Created by YouXianMing on 2018/6/11.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "FolderSortCell.h"
#import "BaseFolderItem.h"
#import "UIColor+Project.h"
#import "UIFont+Project.h"
#import "UIView+SetRect.h"

@interface FolderSortCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation FolderSortCell

- (void)buildSubview {
    
    self.titleLabel      = [[UILabel alloc] initWithFrame:CGRectMake(15.f, 0, Width - 70.f, 75)];
    self.titleLabel.font = [UIFont PingFangSC_Regular_WithFontSize:25.f];
    [self.contentView addSubview:self.titleLabel];
    
    UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, 74.5, Width, 0.5f)];
    line.backgroundColor = UIColor.LineColor;
    [self.contentView addSubview:line];
}

- (void)loadContent {
    
    BaseFolderItem *item = self.data;
    self.titleLabel.text = item.title;
}

@end
